const connectionDb = require("../database/dbconections2");
class ConsolidadoModel {
  async create(
    Periodo,
    DNI,
    ApellidoPaterno,
    ApellidoMaterno,
    Nombres,
    RemuneracionBasica,
    MMG,
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
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarConsolidado( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          Periodo,
          DNI,
          ApellidoPaterno,
          ApellidoMaterno,
          Nombres,
          RemuneracionBasica,
          MMG,
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
          EsSalud,
        ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error", id: null };
    }
  }

  async getPreboleta(Periodo, DNI) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL VerConsolidadoPorTrabajadorConsolidadoPorPeriodo(?,?)",
        [Periodo, DNI]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getPlanillaConsolidada(Periodo) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL VerConsolidadoTotalConsolidadoPorPeriodo(?)",
        [Periodo]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async delete() {
    try {
      const con = connectionDb.promise();
      const data = await con.query("", []);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }
}

module.exports = ConsolidadoModel;
