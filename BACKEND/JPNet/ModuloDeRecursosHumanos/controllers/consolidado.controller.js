const ConsolidadoModel = require("../models/consolidado.model");
const consolidadoDb = new ConsolidadoModel();

class ConsolidadoController {
  async create(
    Periodo,
    DNI,
    ApellidoPaterno,
    ApellidoMaterno,
    Nombres,
    RemuneracionBasica,
    PRY,
    MCP,
    MCB,
    AQP,
    Total,
    SueldoBruto,
    Dias_DCGH,
    Monto_DCGH,
    Dias_Vacaciones,
    Monto_Vacaciones,
    Dias_FeriadosTrabajados,
    Monto_FeriadosTrabajadaos,
    Dias_Descansos,
    Monto_Descansos,
    AsignacionFamiliar,
    Vacaciones_Compensacion,
    Monto_Compensacion,
    HoraExtras_25,
    HoraExtra_35,
    MontoHorasExtras,
    RemuneracionAsegurable,
    AFPHabitad,
    AFPIntegra,
    AFPPrima,
    AFPProfuturo,
    ONP,
    ImpuestoDeQuinta,
    DevolucionQuinta,
    Adelantos,
    Prestamos,
    DescuentosCuentasARendir,
    DescuentosRecursosHumanos,
    PensionAlimenticia,
    TotalNeto,
    EsSalud
  ) {
    try {
      const result = consolidadoDb.create(
        Periodo,
        DNI,
        ApellidoPaterno,
        ApellidoMaterno,
        Nombres,
        RemuneracionBasica,
        PRY,
        MCP,
        MCB,
        AQP,
        Total,
        SueldoBruto,
        Dias_DCGH,
        Monto_DCGH,
        Dias_Vacaciones,
        Monto_Vacaciones,
        Dias_FeriadosTrabajados,
        Monto_FeriadosTrabajadaos,
        Dias_Descansos,
        Monto_Descansos,
        AsignacionFamiliar,
        Vacaciones_Compensacion,
        Monto_Compensacion,
        HoraExtras_25,
        HoraExtra_35,
        MontoHorasExtras,
        RemuneracionAsegurable,
        AFPHabitad,
        AFPIntegra,
        AFPPrima,
        AFPProfuturo,
        ONP,
        ImpuestoDeQuinta,
        DevolucionQuinta,
        Adelantos,
        Prestamos,
        DescuentosCuentasARendir,
        DescuentosRecursosHumanos,
        PensionAlimenticia,
        TotalNeto,
        EsSalud
      );
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return null;
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", err);
      return null;
    }
  }

  async createForArray(datos) {
    console.log(datos[0]);
    try {
      for (let i = 0; i < datos.length; i++) {
        const result = consolidadoDb.create(
          datos[i].Periodo || 2,
          datos[i].DNI || 0,
          datos[i].ApellidoPaterno || 0,
          datos[i].ApellidoMaterno || 0,
          datos[i].Nombres || 0,
          datos[i].RemuneracionBasica || 0,
          datos[i].PRY || 0,
          datos[i].MCP || 0,
          datos[i].MCB || 0,
          datos[i].AQP || 0,
          datos[i].Total || 0,
          datos[i].SueldoBruto || 0,
          datos[i].Dias_DCGH || 0,
          datos[i].Monto_DCGH || 0,
          datos[i].Dias_Vacaciones || 0,
          datos[i].Monto_Vacaciones || 0,
          datos[i].Dias_FeriadosTrabajados || 0,
          datos[i].Monto_FeriadosTrabajadaos || 0,
          datos[i].Dias_Descansos || 0,
          datos[i].Monto_Descansos || 0,
          datos[i].AsignacionFamiliar || 0,
          datos[i].Vacaciones_Compensacion || 0,
          datos[i].Monto_Compensacion || 0,
          datos[i].HoraExtras_25 || 0,
          datos[i].HoraExtra_35 || 0,
          datos[i].MontoHorasExtras || 0,
          datos[i].Asegurable || 0,
          datos[i].AFPHabitad || 0,
          datos[i].AFPIntegra || 0,
          datos[i].AFPPrima || 0,
          datos[i].AFPProfuturo || 0,
          datos[i].ONP || 0,
          datos[i].RentaDeQuinta || 0,
          datos[i].DevolucionQuinta || 0,
          datos[i].Adelantos || 0,
          datos[i].Prestamos || 0,
          datos[i].DescuentosCuentasARendir || 0,
          datos[i].DescuentosRecursosHumanos || 0,
          datos[i].PensionAlimenticia || 0,
          datos[i].TotalNeto || 0,
          datos[i].EsSalud || 0
        );
        const data = await result.catch((err) => {
          console.log("Controller Error Del Bucle: ", err);
          return null;
        });
        if (i == data.length - 1) {
          return data;
        }
      }
    } catch (error) {
      console.log("Controller Error Del Principal: ", error);
      return null;
    }
  }

  async getPreboletaPorDNI(PERIODO_IN, DNI_IN) {
    try {
      const result = consolidadoDb.getPreboleta(PERIODO_IN, DNI_IN);
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return null;
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", err);
      return null;
    }
  }

  async getConsolidadoDePlanilla(PERIODO_IN) {
    try {
      const result = consolidadoDb.getPlanillaConsolidada(PERIODO_IN);
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return null;
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", err);
      return null;
    }
  }
}

module.exports = ConsolidadoController;
