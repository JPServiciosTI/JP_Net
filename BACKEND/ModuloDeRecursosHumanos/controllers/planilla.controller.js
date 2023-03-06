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
    const result1 = empleadoDb.getEmpleadoForLimitParaPlanilla(0, 100);
    const dataEmpleados = await result1.catch((err) => {
      console.log("Controller Error: ", err);
      return { status: "error Empleados", id: null };
    });
    console.log(dataEmpleados.id[0]);

    for (let i = 0; i < dataEmpleados.id.length; i++) {
      try {
        const resultTareo = tareoDb.getTareoPorFechaEnMinutos(
          FechaInicio,
          FechaFin,
          dataEmpleados.id[0][i].idEmpleado
        );
        const dataTareo = await resultTareo.catch((err) => {
          console.log("Controller Error: ", err);
          return { status: "error Tareo", id: null };
        });

        //HASTA AQUI TENGO TODOS LOS DATOS DE MIS TAREOS
        let datosCalculo = [];
        if (dataTareo[0].length != 0) {
          let costoPorDia =  dataEmpleados.id[0][i].SueldoBase / dataTareo[0].length;
          // QUIERO CALCULAR CUANTO GANA LA PERSONA
          for (let j = 0; j < dataTareo[0].length; j++) {
            if(dataTareo[0][j].idTareo == 8){
                console.log("ESTAMOS EN 8", j)
            }
            let day = new Date(dataTareo[0][j].Fecha);
            if (day.getDay() == 0) {
              if (j < 6) {
              } else {
                let temporal = j - 6;
                let sum = 0;
                for (let temp = temporal; temp <= j; temp++) {
                  sum = dataTareo[0][temp].TiempoCalculado + sum;
                }
                console.log("Presuma ",sum)
                sum = (sum / 60)/6;
                let sumDom = 0;
                if(sum > 8){
                    sumDom = costoPorDia;
                }else{
                    sumDom = (sum * costoPorDia)/8;
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
                    console.log("En sabado",costoPorDia );
                  datosCalculo.push({
                    idTareo: dataTareo[0][j].idTareo,
                    CantidadDePago: costoPorDia,
                    Periodo: PeriodoIN,
                  });
                } else {
                    console.log("En sabado",costoPorDia );
                    dataTareo[0][j].TiempoCalculado * (8 / 60) * costoPorDia;
                  datosCalculo.push({
                    idTareo: dataTareo[0][j].idTareo,
                    CantidadDePago: costo,
                    Periodo: PeriodoIN,
                  });
                }
              }
            }

          }
          console.log(datosCalculo);
          console.log(dataTareo);
          for (let idpago = 0; idpago < datosCalculo.length; idpago++) {
            const result2 = planillaDb.CrearPago(datosCalculo[idpago].idTareo,datosCalculo[idpago].CantidadDePago,datosCalculo[idpago].Periodo);
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
  }





  async CalcularPagoEsSalud(){
    try {
        const result1 = empleadoDb.getEmpleadoForLimitParaPlanilla(0, 100);
        const dataEmpleados = await result1.catch((err) => {
          console.log("Controller Error: ", err);
          return { status: "error Empleados", id: null };
        });
        console.log(dataEmpleados.id[0]);
    
    } catch (error) {
        
    }
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

  async obtenerSueldoBruto(DNI,FechaInicio,FechaFin) {
    try {
      const result = planillaDb.CalcularSueldoBruto(DNI,FechaInicio,FechaFin);
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

  async obtenerEmpleadosPlanilla(FechaInicio,FechaFin) {
    try {
      const result = planillaDb.ObtenerPersonalParaPlanilla(FechaInicio,FechaFin);
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
}

module.exports = PlanillaController;
