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
    NombreEntidad,
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
        NombreEntidad,
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
      console.log("Alli Vamos");
      for (let i = 0; i < datos.length; i++) {
        const result = consolidadoDb.create(
          datos[i].Periodo || 2,
          datos[i].DNI || 0,
          datos[i].ApellidoPaterno || 0,
          datos[i].ApellidoMaterno || 0,
          datos[i].Nombres || 0,
          datos[i].SueldoBase || 0,
          datos[i].MMGContado || 0,
          datos[i].PRYContado || 0,
          datos[i].MCPContado || 0,
          datos[i].MCBContado || 0,
          datos[i].AQPContado || 0,
          datos[i].Total || 0,
          datos[i].SueldoBruto || 0,
          datos[i].DCGHContable || 0,
          datos[i].DCGH || 0,
          datos[i].VacacionesContable || 0,
          datos[i].Vacaciones || 0,
          datos[i].FeriadosTrabajadosContable || 0,
          datos[i].FeriadosTrabajados || 0,
          datos[i].DescansosProgramadosContable || 0,
          datos[i].DescansosProgramados || 0,
          datos[i].AsignacionFamiliar || 0,
          datos[i].VacacionesContable || 0,
          datos[i].Vacaciones || 0,
          datos[i].HorasExtras25 || 0,
          datos[i].HorasExtras35 || 0,
          datos[i].MontoTotalHorasExtras || 0,
          datos[i].Asegurable || 0,
          datos[i].NombreEntidad || 0,
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
          datos[i].NetoTotal || 0,
          datos[i].EsSalud || 0
        );
        const data = await result.catch((err) => {
          console.log("Controller Error Del Bucle: ", err);
          return null;
        });

      }
      const data = {status : "ok"};
      return data;
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
