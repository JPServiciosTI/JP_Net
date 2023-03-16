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
