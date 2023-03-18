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

const DescuentoModel = require("../models/descuentos.model");
const descuentoDb = new DescuentoModel();

class PlanillaController {
  async CalcularPagosATrabajadores(FechaInicio, FechaFin, PeriodoIN) {
    const resultExitenciaDelPeriodo =
      tareoDb.getObtenerTareoDelPeriodo(PeriodoIN);
    const dataExitenciaDelPeriodo = await resultExitenciaDelPeriodo.catch(
      (err) => {
        console.log("Controller Error: ", err);
        // return { status: "error Tareo", id: null };
      }
    );
    if (dataExitenciaDelPeriodo[0].length > 0) {
      const resultEliminarCalculo = tareoDb.deleteCalculoDePago(PeriodoIN);
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
                      sumTareoDelTiempoNeto =
                        dataTareo[0][temp].TiempoCalculado +
                        sumTareoDelTiempoNeto;
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
      console.log(DNI);
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

  async obtenerDescuentos(idContrato, Periodo) {
    try {
      const result = descuentoDb.getDescuentos(idContrato, Periodo);
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
    const UIT = 4600; // Unidad Impositiva Tributaria
    let MontoSupuesto = remuneracionMensual * 12;
    let GratificacionesEstimada = remuneracionMensual * 2;
    let BonificacionLey29351 = GratificacionesEstimada * 0.09;
    let SaldoGravado =
      MontoSupuesto + GratificacionesEstimada + BonificacionLey29351 - UIT * 7;
    // Porcentaje del impuesto de quinta categoría
    const tramoIngreso = [0.08, 0.14, 0.17, 0.2, 0.3];
    const maximoPorTramo = [0, 5, 20, 35, 45, 1000000];
    let SaldoRestante = SaldoGravado;
    let SumaDelImpuesto = 0;
    for (let i = 0; i < tramoIngreso.length; i++) {
      if (SaldoGravado <= 0) {
        break;
      }
      let TramoCalculado = maximoPorTramo[i + 1] - maximoPorTramo[i];
      if (TramoCalculado * UIT >= SaldoRestante) {
        SumaDelImpuesto = SumaDelImpuesto + SaldoRestante * tramoIngreso[i];
        SaldoRestante = 0;
        break;
      } else {
        //console.log("Tramo: ",i," Max:",maximoPorTramo[i]*UIT,"YO: ",SaldoRestante)
        SumaDelImpuesto =
          SumaDelImpuesto + TramoCalculado * UIT * tramoIngreso[i];
        SaldoRestante = SaldoRestante - TramoCalculado * UIT;
      }
    }
    // Redondeamos el impuesto a dos decimales
    const impuestoRedondeado = Math.round((SumaDelImpuesto / 12) * 100) / 100;

    // Devolvemos el resultado
    return impuestoRedondeado;
  }

  async calcularHorasExtras(HorasDe25, HorasDe35, Sueldo) {
    let calculoHoraDelEmpleado = Sueldo / 30 / 8;
    let CalculoHoras25 = calculoHoraDelEmpleado * 1.25 * HorasDe25;
    let CalculoHoras35 = calculoHoraDelEmpleado * 1.35 * HorasDe35;
    console.log("CostoPorHoraRegular:", calculoHoraDelEmpleado);
    console.log("CostoTotalHoras25:", CalculoHoras25);
    console.log("CostoTotalHoras35:", CalculoHoras35);
    console.log("Total:", CalculoHoras25 + CalculoHoras35);
    return (CalculoHoras25 + CalculoHoras35).toFixed(2);
  }

  async obtenerPreGeneradoDePlanilla(FechaInicio, FechaFin, Periodo_IN) {
    const SueldoMinimoVial = 1025;
    let fecha1 = new Date(FechaInicio);
    let fecha2 = new Date(FechaFin);
    let diferencia = fecha2.getTime() - fecha1.getTime();
    let diasDeDiferencia = diferencia / 1000 / 60 / 60 / 24;
    try {
      const result = planillaDb.ObtenerPersonalParaPlanilla(
        FechaInicio,
        FechaFin
      );
      const data = await result.catch((err) => {
        console.log("Controller Data Personal Error: ", err);
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
          console.log("Controller Data Sueldo Error: ", err);
          return { status: "error", id: null };
        });

        const resultTardanza = planillaDb.ObtenerCantidadDeTardanza(
          DNI_IN,
          FechaInicio,
          FechaFin
        );
        const dataTardanza = await resultTardanza.catch((err) => {
          console.log("Controller Data Tardanza Error: ", err);
          return { status: "error", id: null };
        });

        const resultFaltas = planillaDb.ObtenerCantidadDeFaltas(
          DNI_IN,
          FechaInicio,
          FechaFin
        );
        const dataFaltas = await resultFaltas.catch((err) => {
          console.log("Controller Data Faltas Error: ", err);
          return { status: "error", id: null };
        });

        console.log("Faltas> ", dataFaltas["id"][0].Faltas);
        data["id"][0][i].Faltas = dataFaltas["id"][0].Faltas;
        // console.log("Faltas> ", data["id"][0][i].Faltas);
        data["id"][0][i].Tardanza = dataTardanza["id"][0].Tardanzas || 0;
        //console.log("Que fue del periodo:? ", DNI_IN, data3["id"][0]);
        data["id"][0][i].Periodo = Periodo_IN;
        console.log("DNI", DNI_IN, "Sueldo: ", data3["id"][0].SueldoBruto);
        if (data["id"][0][i].SueldoBase <= (data3["id"][0].SueldoBruto || 0)) {
          data["id"][0][i].SueldoTareado = data["id"][0][i].SueldoBase;
        } else {
          data["id"][0][i].SueldoTareado = data3["id"][0].SueldoBruto || 0;
        }

        const resultTotalDeCompensacionesAdicionales =
          planillaDb.ObtenerConsolidadoDeDatosDelTareo(
            data["id"][0][i].idContrato,
            FechaInicio,
            FechaFin
          );
        const dataTotalDeCompensacionesAdicionales =
          await resultTotalDeCompensacionesAdicionales.catch((err) => {
            console.log("Controller Data Tardanza Error: ", err);
            return { status: "error", id: null };
          });
        let SueldoPorDia = data["id"][0][i].SueldoBase / diasDeDiferencia;
        //console.log(dataTotalDeCompensacionesAdicionales["id"][0])
        data["id"][0][i].MMG =  dataTotalDeCompensacionesAdicionales["id"][0][0].MMG * SueldoPorDia ||  0;
        data["id"][0][i].MMGContado =  dataTotalDeCompensacionesAdicionales["id"][0][0].MMG ||  0;
        data["id"][0][i].MCP =  dataTotalDeCompensacionesAdicionales["id"][0][0].MCP * SueldoPorDia || 0;
        data["id"][0][i].MCPContado =  dataTotalDeCompensacionesAdicionales["id"][0][0].MCP || 0;
        data["id"][0][i].MCB = dataTotalDeCompensacionesAdicionales["id"][0][0].MCB * SueldoPorDia ||      0;
        data["id"][0][i].MCBContado = dataTotalDeCompensacionesAdicionales["id"][0][0].MCB ||      0;
        data["id"][0][i].PRY =    dataTotalDeCompensacionesAdicionales["id"][0][0].PRY * SueldoPorDia ||   0;
        data["id"][0][i].PRYContado =    dataTotalDeCompensacionesAdicionales["id"][0][0].PRY ||   0;
        data["id"][0][i].AQPContado =    dataTotalDeCompensacionesAdicionales["id"][0][0].AQP ||   0; 
        data["id"][0][i].DCGH =   dataTotalDeCompensacionesAdicionales["id"][0][0].DCGH *  SueldoPorDia || 0;
        data["id"][0][i].DCGHContable =   dataTotalDeCompensacionesAdicionales["id"][0][0].DCGH || 0;
        data["id"][0][i].DescansosMedicos =      dataTotalDeCompensacionesAdicionales["id"][0][0].MEDICO * SueldoPorDia || 0;
        data["id"][0][i].DescansosMedicosContable =      dataTotalDeCompensacionesAdicionales["id"][0][0].MEDICO || 0;
        data["id"][0][i].DescansosProgramados =       parseFloat((dataTotalDeCompensacionesAdicionales["id"][0][0].DESCANSOSPROGRAMADOS * SueldoPorDia).toFixed(2))|| 0;
        data["id"][0][i].DescansosProgramadosContable =       dataTotalDeCompensacionesAdicionales["id"][0][0].DESCANSOSPROGRAMADOS || 0;
        data["id"][0][i].FeriadosTrabajados =       dataTotalDeCompensacionesAdicionales["id"][0][0].FERIADOSTRABAJADOS *  SueldoPorDia * 2 || 0;
        data["id"][0][i].FeriadosTrabajadosContable =       dataTotalDeCompensacionesAdicionales["id"][0][0].FERIADOSTRABAJADOS *  SueldoPorDia * 2 || 0;
        data["id"][0][i].Vacaciones =          dataTotalDeCompensacionesAdicionales["id"][0][0].VACACIONES * SueldoPorDia || 0;
        data["id"][0][i].VacacionesContable =          dataTotalDeCompensacionesAdicionales["id"][0][0].VACACIONES * SueldoPorDia || 0;

        data["id"][0][i].SueldoBruto = parseFloat(( 
          data["id"][0][i].SueldoTareado +
          data["id"][0][i].MMG +
          data["id"][0][i].MCP +
          data["id"][0][i].MCB +
          data["id"][0][i].PRY).toFixed(2));

          if (data["id"][0][i].SueldoBruto > data["id"][0][i].SueldoBase) {
            data["id"][0][i].SueldoBruto = data["id"][0][i].SueldoBase;
          }
        let SumaTotalDeLosConceptosDelTareo = 
          data["id"][0][i].SueldoBruto +
          data["id"][0][i].DescansosMedicos +         
          data["id"][0][i].DCGH +
          data["id"][0][i].DescansosMedicos +
          data["id"][0][i].DescansosProgramados +
          data["id"][0][i].FeriadosTrabajados +
          data["id"][0][i].Vacaciones;
          console.log("Que Fue: ",           
          data["id"][0][i].SueldoTareado +
          data["id"][0][i].DescansosMedicos ,
          data["id"][0][i].MMG ,
          data["id"][0][i].MCP ,
          data["id"][0][i].MCB ,
          data["id"][0][i].PRY ,
          data["id"][0][i].DCGH ,
          data["id"][0][i].DescansosMedicos ,
          data["id"][0][i].DescansosProgramados ,
          data["id"][0][i].FeriadosTrabajados ,
          data["id"][0][i].Vacaciones)
          console.log("SumaTotalDeLosConceptosDelTareo: ",SumaTotalDeLosConceptosDelTareo);

        let calculoHoraDelEmpleado = data["id"][0][i].SueldoBase / 30 / 8;
        let CalculoHoras25 =
          calculoHoraDelEmpleado *
          1.25 *
          (dataTotalDeCompensacionesAdicionales["id"][0][0].H25 || 0);
        let CalculoHoras35 =
          calculoHoraDelEmpleado *
          1.35 *
          (dataTotalDeCompensacionesAdicionales["id"][0][0].H25 || 0);
        data["id"][0][i].HorasExtras25 =
          dataTotalDeCompensacionesAdicionales["id"][0][0].H25 || 0;
        data["id"][0][i].HorasExtras35 =
          dataTotalDeCompensacionesAdicionales["id"][0][0].H35 || 0;
        data["id"][0][i].MontoHorasExtras25 = CalculoHoras25 || 0;
        data["id"][0][i].MontoHorasExtras35 = CalculoHoras35 || 0;
        data["id"][0][i].MontoTotalHorasExtras =
          parseFloat((CalculoHoras25 + CalculoHoras35).toFixed(2)) || 0;
          if (SumaTotalDeLosConceptosDelTareo > data["id"][0][i].SueldoBase) {
            SumaTotalDeLosConceptosDelTareo = data["id"][0][i].SueldoBase;
          }
          if (data["id"][0][i].NHijos > 0) {
            data["id"][0][i].AsignacionFamiliar = 102.5;
          } else {
            data["id"][0][i].AsignacionFamiliar = 0;
          }
        if (parseFloat(data["id"][0][i].Asegurable) < SueldoMinimoVial) {
          data["id"][0][i].EsSalud = (SueldoMinimoVial * 0.09).toFixed(2);
        }


        data["id"][0][i].CompensacionesAdicionales =
          data["id"][0][i].AsignacionFamiliar;
        data["id"][0][i].Asegurable = parseFloat((SumaTotalDeLosConceptosDelTareo +
          parseFloat(data["id"][0][i].MontoTotalHorasExtras)).toFixed(2));
        console.log("ASEGURARBLE: ", data["id"][0][i].Asegurable);
        data["id"][0][i].EsSalud = (data["id"][0][i].Asegurable * 0.09).toFixed(
          2
        );
        console.log("ESSALUD: ", data["id"][0][i].EsSalud);
        data["id"][0][i].DescuentoAFP = (
          data["id"][0][i].SueldoTareado *
          data["id"][0][i].PorcentajeDeDescuento
        ).toFixed(2);
        switch (data["id"][0][i].idFondoDePension) {
            case 1:
              data["id"][0][i].ONP = data["id"][0][i].DescuentoAFP;
              data["id"][0][i].AFPIntegra = 0;
              data["id"][0][i].AFPPrima = 0;
              data["id"][0][i].AFPHabitad = 0;
              data["id"][0][i].AFPProfuturo = 0;
              break;
            case 2:
              data["id"][0][i].ONP = 0;
              data["id"][0][i].AFPIntegra = data["id"][0][i].DescuentoAFP;
              data["id"][0][i].AFPPrima = 0;
              data["id"][0][i].AFPHabitad = 0;
              data["id"][0][i].AFPProfuturo = 0;
              break;
            case 3:
              data["id"][0][i].ONP = 0;
              data["id"][0][i].AFPIntegra = 0;
              data["id"][0][i].AFPPrima = 0;
              data["id"][0][i].AFPHabitad = data["id"][0][i].DescuentoAFP;
              data["id"][0][i].AFPProfuturo = 0;
              break;  
            case 4:
              data["id"][0][i].ONP = 0;
              data["id"][0][i].AFPIntegra = 0;
              data["id"][0][i].AFPPrima = data["id"][0][i].DescuentoAFP;
              data["id"][0][i].AFPHabitad = 0;
              data["id"][0][i].AFPProfuturo = 0;
              break;   
            case 4:
              data["id"][0][i].ONP = 0;
              data["id"][0][i].AFPIntegra = 0;
              data["id"][0][i].AFPPrima = 0;
              data["id"][0][i].AFPHabitad = 0;
              data["id"][0][i].AFPProfuturo = data["id"][0][i].DescuentoAFP;
              break;       
          }
        /**
         * 2	AFP INTEGRA
3	AFP HABITAD
4	AFP PRIMA
5	AFP PROFUTURO
         * Funcion para el calculo de Quinta Categoria
         */
        const UIT = 4950; // Unidad Impositiva Tributaria
        let MontoSupuesto = data["id"][0][i].SueldoBase * 12;
        let GratificacionesEstimada = data["id"][0][i].SueldoBase * 2;
        let BonificacionLey29351 = GratificacionesEstimada * 0.09;
        let SaldoGravado =
          MontoSupuesto +
          GratificacionesEstimada +
          BonificacionLey29351 -
          UIT * 7;
        // Porcentaje del impuesto de quinta categoría
        const tramoIngreso = [0.08, 0.14, 0.17, 0.2, 0.3];
        const maximoPorTramo = [0, 5, 20, 35, 45, 1000000];
        let SaldoRestante = SaldoGravado;
        let SumaDelImpuesto = 0;
        //console.log("Total: ",MontoSupuesto+GratificacionesEstimada,"Gravado: ",SaldoGravado);
        for (let i = 0; i < tramoIngreso.length; i++) {
          if (SaldoGravado <= 0) {
            break;
          }
          let TramoCalculado = maximoPorTramo[i + 1] - maximoPorTramo[i];
          if (TramoCalculado * UIT >= SaldoRestante) {
            SumaDelImpuesto = SumaDelImpuesto + SaldoRestante * tramoIngreso[i];
            SaldoRestante = 0;
            break;
          } else {
            SumaDelImpuesto =
              SumaDelImpuesto + TramoCalculado * UIT * tramoIngreso[i];
            SaldoRestante = SaldoRestante - TramoCalculado * UIT;
          }
        }
        // Redondeamos el impuesto a dos decimales
        const impuestoRedondeado =
          Math.round((SumaDelImpuesto / 12) * 100) / 100;

        // FIN DE LA FUNCION DE QUINTA CATEGORIA

        data["id"][0][i].RentaDeQuinta = impuestoRedondeado;

        data["id"][0][i].TotalDescuentos =
          parseFloat(data["id"][0][i].DescuentoAFP) +
          parseFloat(data["id"][0][i].RentaDeQuinta);

        data["id"][0][i].TotalDescuentos = parseFloat(
          data["id"][0][i].TotalDescuentos
        ).toFixed(2);
        data["id"][0][i].NetoTotal =
          data["id"][0][i].Asegurable - data["id"][0][i].TotalDescuentos;
        console.log(
          "ASEGF: ",
          data["id"][0][i].Asegurable,
          "DESC: ",
          data["id"][0][i].TotalDescuentos
        );
        data["id"][0][i].NetoTotal = parseFloat(
          data["id"][0][i].NetoTotal
        ).toFixed(2);
        console.log("Neto: ", data["id"][0][i].NetoTotal);
        /*
        const resultDescuentos = descuentoDb.createDescuentoDeLey(
          data["id"][0][i].Periodo,
          data["id"][0][i].idContrato,
          data["id"][0][i].RentaDeQuinta,
          data["id"][0][i].Tardanza,
          data["id"][0][i].Faltas,
          data["id"][0][i].DescuentoAFP
        );
        const dataDescuentos = await resultDescuentos.catch((err) => {
          console.log("Controller Data Descuento Error: ", err);
          return { status: "error", id: null };
        });*/
      }

      return data;
    } catch (error) {
      console.log("Controller Error: ", error);
      return { status: "error", id: null };
    }
  }
}

module.exports = PlanillaController;
