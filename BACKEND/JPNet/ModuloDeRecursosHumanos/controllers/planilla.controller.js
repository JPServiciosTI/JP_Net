/**
 * Librerias
 */
const express = require("express");

const router = express.Router();

/**
 * Modelos
 */

const PlanillaModel = require("../models/planilla.model");
const planillaDb = new PlanillaModel();

const TareoModel = require("../models/tareo.model");
const tareoDb = new TareoModel();

const EmpleadoModel = require("../models/empleado.model");
const empleadoDb = new EmpleadoModel();

class PlanillaController {
  async CalcularPagosATrabajadores(FechaInicio, FechaFin, PeriodoIN) {
    
    const resultExitenciaDelPeriodo = tareoDb.getObtenerTareoDelPeriodo(
      PeriodoIN
    );
    const dataExitenciaDelPeriodo= await resultExitenciaDelPeriodo.catch((err) => {
      console.log("Controller Error: ", err);
      // return { status: "error Tareo", id: null };
    });
    if(dataExitenciaDelPeriodo[0].length > 0){
      const resultEliminarCalculo = tareoDb.deleteCalculoDePago(
        PeriodoIN
      );
      const dataEliminarCalculo = await resultEliminarCalculo.catch((err) => {
        console.log("Controller Error: ", err);
        // return { status: "error Tareo", id: null };
      });     
    }
    
    const result1 = empleadoDb.getEmpleadoForLimitParaPlanilla(0, 100);
    const dataEmpleados = await result1.catch((err) => {
      console.log("Controller Error: ", err);
      return { status: "error Empleados", id: null };
    });
    //console.log(dataEmpleados.id[0]);

    
    for (let i = 0; i < dataEmpleados.id[0].length; i++) {
      try {
        const resultTareo = tareoDb.getTareoPorFechaEnMinutos(
          FechaInicio,
          FechaFin,
          dataEmpleados.id[0][i].idEmpleado
        );
        const dataTareo = await resultTareo.catch((err) => {
          console.log("Controller Error: ", err);
          // return { status: "error Tareo", id: null };
        });

        //HASTA AQUI TENGO TODOS LOS DATOS DE MIS TAREOS
        let datosCalculo = [];
        if (dataTareo[0].length != 0) {
          let costoPorDia =
            dataEmpleados.id[0][i].SueldoBase / dataTareo[0].length;
          // QUIERO CALCULAR CUANTO GANA LA PERSONA
          for (let j = 0; j < dataTareo[0].length; j++) {
            let day = new Date(dataTareo[0][j].Fecha);
            if (
              dataTareo[0][j].idCondicionDeTareo == 3 ||
              dataTareo[0][j].idCondicionDeTareo == 5
            ) {
              datosCalculo.push({
                idTareo: dataTareo[0][j].idTareo,
                CantidadDePago: 0.0,
                Periodo: PeriodoIN,
              });
            }
            if (
              dataTareo[0][j].idCondicionDeTareo == 4 ||
              dataTareo[0][j].idCondicionDeTareo == 6 ||
              dataTareo[0][j].idCondicionDeTareo == 7 ||
              dataTareo[0][j].idCondicionDeTareo == 9
            ) {
              datosCalculo.push({
                idTareo: dataTareo[0][j].idTareo,
                CantidadDePago: costoPorDia,
                Periodo: PeriodoIN,
              });
            }
            if (dataTareo[0][j].idCondicionDeTareo == 8) {
              datosCalculo.push({
                idTareo: dataTareo[0][j].idTareo,
                CantidadDePago: costoPorDia * 3,
                Periodo: PeriodoIN,
              });
            }
            if (
              dataTareo[0][j].idCondicionDeTareo == 1 ||
              dataTareo[0][j].idEstacionDeTrabajo >= 4
            ) {
              datosCalculo.push({
                idTareo: dataTareo[0][j].idTareo,
                CantidadDePago: costoPorDia,
                Periodo: PeriodoIN,
              });
            } else {
              if (day.getDay() == 0) {
                if (j < 6) {
                } else {
                  let temporal = j - 6;
                  let sumTareoDelTiempoNeto = 0;
                  for (let temp = temporal; temp <= j; temp++) {
                    if (dataTareo[0][temp].TiempoCalculado >= 510) {
                      sumTareoDelTiempoNeto = 510 + sumTareoDelTiempoNeto;
                    } else {
                      sumTareoDelTiempoNeto = dataTareo[0][temp].TiempoCalculado + sumTareoDelTiempoNeto;
                    } 
                  }
                  sumTareoDelTiempoNeto = sumTareoDelTiempoNeto / 60 / 6;
                  let sumDom = 0;
                  if (sumTareoDelTiempoNeto > 8) {
                    sumDom = costoPorDia;
                  } else {
                    sumDom = (sumTareoDelTiempoNeto * costoPorDia) / 8;
                  }
                  datosCalculo.push({
                    idTareo: dataTareo[0][j].idTareo,
                    CantidadDePago: sumDom,
                    Periodo: PeriodoIN,
                  });
                }
              } else {
                if (dataTareo[0][j].TiempoCalculado >= 510) {
                  datosCalculo.push({
                    idTareo: dataTareo[0][j].idTareo,
                    CantidadDePago: costoPorDia,
                    Periodo: PeriodoIN,
                  });
                } else {
                  if (dataTareo[0][j].TiempoCalculado >= 330) {
                    datosCalculo.push({
                      idTareo: dataTareo[0][j].idTareo,
                      CantidadDePago: costoPorDia,
                      Periodo: PeriodoIN,
                    });
                  } else {
                    let costo =
                      ((dataTareo[0][j].TiempoCalculado / 60) * costoPorDia) /
                      8;
                    datosCalculo.push({
                      idTareo: dataTareo[0][j].idTareo,
                      CantidadDePago: costo,
                      Periodo: PeriodoIN,
                    });
                  }
                }
              }
            }
          }

          for (let idpago = 0; idpago < datosCalculo.length; idpago++) {
            const result2 = planillaDb.CrearPago(
              datosCalculo[idpago].idTareo,
              datosCalculo[idpago].CantidadDePago,
              datosCalculo[idpago].Periodo
            );
            const ResupuestaConfirmado = await result2.catch((err) => {
              console.log("Controller Error: ", err);
              return { status: "error Pago", id: null };
            });
          }
          
        }
        
      } catch (error) {
        console.log(error);
      }
    }
    return { status: "ok", id: 0 };
  }

  async obtenerPeriodos() {
    try {
      const result = planillaDb.getDatosPeriodo();
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return { status: "error", id: null };
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", error);
      return { status: "error", id: null };
    }
  }

  async obtenerSueldoBruto(DNI, FechaInicio, FechaFin) {
    try {
      const result = planillaDb.CalcularSueldoBruto(DNI, FechaInicio, FechaFin);
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return { status: "error", id: null };
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", error);
      return { status: "error", id: null };
    }
  }


  async calcularImpuestoQuintaCategoria(remuneracionMensual) {
    const UIT = 4950; // Unidad Impositiva Tributaria
    let MontoSupuesto = remuneracionMensual*12;
    let GratificacionesEstimada =  remuneracionMensual*2 ;
    let BonificacionLey29351 = GratificacionesEstimada*0.09;
    let SaldoGravado = MontoSupuesto+GratificacionesEstimada+BonificacionLey29351 - UIT*7 ;
    // Porcentaje del impuesto de quinta categoría
    const tramoIngreso = [0.08,0.14,0.17,0.2,0.3];
    const maximoPorTramo = [5,20,35,45,1000000];
    let SaldoRestante = SaldoGravado;
    let SumaDelImpuesto = 0;
    console.log("Total: ",MontoSupuesto+GratificacionesEstimada,"Gravado: ",SaldoGravado);
    for (let i = 0; i < tramoIngreso.length; i++) {
      if (SaldoGravado <= 0) {
        break;
      }
      if(maximoPorTramo[i]*UIT >= SaldoRestante){
        SumaDelImpuesto = SumaDelImpuesto + SaldoRestante*tramoIngreso[i];
        
        console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT,"Pago :", SaldoRestante*tramoIngreso[i],"YO: ",SaldoRestante, "uma: ", SumaDelImpuesto, "Abonado del Tramo ",SaldoRestante*tramoIngreso[i]);
        SaldoRestante = 0;
        break;
      }else{
        //console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT,"YO: ",SaldoRestante)
        SumaDelImpuesto = SumaDelImpuesto + maximoPorTramo[i]*UIT*tramoIngreso[i];
        SaldoRestante = SaldoRestante - maximoPorTramo[i]*UIT
        console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT, "Pago :", maximoPorTramo[i]*UIT*tramoIngreso[i],"YO: ",SaldoRestante, "uma: ", SumaDelImpuesto,"Abonado del Tramo ",maximoPorTramo[i]*UIT*tramoIngreso[i]);
      }
    }
    // Redondeamos el impuesto a dos decimales
    const impuestoRedondeado = Math.round(SumaDelImpuesto/ 12 * 100) / 100 ;
    
    // Devolvemos el resultado
    return impuestoRedondeado;
  }
  

  async obtenerEmpleadosPlanilla(FechaInicio, FechaFin) {
    const SueldoMinimoVial = 1025;
    try {
      const result = planillaDb.ObtenerPersonalParaPlanilla(
        FechaInicio,
        FechaFin
      );
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return { status: "error", id: null };
      });
      for (let i = 0; i < data["id"][0].length; i++) {
        const DNI_IN = data["id"][0][i].DNI;
        const result3 = planillaDb.CalcularSueldoBruto(
          DNI_IN,
          FechaInicio,
          FechaFin
        );
        const data3 = await result3.catch((err) => {
          console.log("Controller Error: ", err);
          return { status: "error", id: null };
        });

        const resultTardanza = planillaDb.ObtenerCantidadDeTardanza(
          DNI_IN,
          FechaInicio,
          FechaFin
        );
        const dataTardanza = await resultTardanza.catch((err) => {
          console.log("Controller Error: ", err);
          return { status: "error", id: null };
        });
        data["id"][0][i].SueldoBruto = data3["id"][0].SueldoBruto;
        data["id"][0][i].EsSalud = data3["id"][0].EsSalud;
        data["id"][0][i].EsSalud = parseFloat(data["id"][0][i].EsSalud).toFixed(
          2
        );
        if (parseFloat(data["id"][0][i].Asegurable) < SueldoMinimoVial) {
          data["id"][0][i].EsSalud = (SueldoMinimoVial * 0.09).toFixed(2);
        }
        if (data["id"][0][i].NHijos > 0) {
          data["id"][0][i].AsignacionFamiliar = 102.5;
        } else {
          data["id"][0][i].AsignacionFamiliar = 0;
        }
        data["id"][0][i].Asegurable =
          data["id"][0][i].SueldoBruto + data["id"][0][i].AsignacionFamiliar;
        data["id"][0][i].DescuentoAFP = (
          data["id"][0][i].SueldoBruto * data["id"][0][i].PorcentajeDeDescuento
        ).toFixed(2);

        /**
         * Funcion para el calculo de Quinta Categoria
         */
        const UIT = 4950; // Unidad Impositiva Tributaria
        let MontoSupuesto = data["id"][0][i].SueldoBase*12;
        let GratificacionesEstimada = data["id"][0][i].SueldoBase*2 ;
        let BonificacionLey29351 = GratificacionesEstimada*0.09;
        let SaldoGravado = MontoSupuesto+GratificacionesEstimada+BonificacionLey29351 - UIT*7 ;
        // Porcentaje del impuesto de quinta categoría
        const tramoIngreso = [0.08,0.14,0.17,0.2,0.3];
        const maximoPorTramo = [5,20,35,45,1000000];
        let SaldoRestante = SaldoGravado;
        let SumaDelImpuesto = 0;
        console.log("Total: ",MontoSupuesto+GratificacionesEstimada,"Gravado: ",SaldoGravado);
        for (let i = 0; i < tramoIngreso.length; i++) {
          if (SaldoGravado <= 0) {
            break;
          }
          if(maximoPorTramo[i]*UIT >= SaldoRestante){
            SumaDelImpuesto = SumaDelImpuesto + SaldoRestante*tramoIngreso[i];
            
            console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT,"Pago :", SaldoRestante*tramoIngreso[i],"YO: ",SaldoRestante, "uma: ", SumaDelImpuesto, "Abonado del Tramo ",SaldoRestante*tramoIngreso[i]);
            SaldoRestante = 0;
            break;
          }else{
            //console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT,"YO: ",SaldoRestante)
            SumaDelImpuesto = SumaDelImpuesto + maximoPorTramo[i]*UIT*tramoIngreso[i];
            SaldoRestante = SaldoRestante - maximoPorTramo[i]*UIT
            console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT, "Pago :", maximoPorTramo[i]*UIT*tramoIngreso[i],"YO: ",SaldoRestante, "uma: ", SumaDelImpuesto,"Abonado del Tramo ",maximoPorTramo[i]*UIT*tramoIngreso[i]);
          }
        }
        // Redondeamos el impuesto a dos decimales
        const impuestoRedondeado = Math.round(SumaDelImpuesto/ 12 * 100) / 100 ;
        
        // FIN DE LA FUNCION DE QUINTA CATEGORIA
        
        data["id"][0][i].RentaDeQuinta = impuestoRedondeado;


        data["id"][0][i].TotalDescuentos =
          parseFloat(data["id"][0][i].DescuentoAFP) +
          parseFloat(data["id"][0][i].RentaDeQuinta);
        data["id"][0][i].NetoTotal =
          data["id"][0][i].Asegurable - data["id"][0][i].TotalDescuentos;
        data["id"][0][i].NetoTotal = parseFloat(
          data["id"][0][i].NetoTotal
        ).toFixed(2);
        data["id"][0][i].Faltas = data3["id"][0].Faltas;
      }
      return data;
    } catch (error) {
      console.log("Controller Error: ", error);
      return { status: "error", id: null };
    }
  }
}

module.exports = PlanillaController;
