const connectionDb = require("../database/dbconections");
class TareoModel {
  async getTareoPorFecha(FechaDeInicio, FechaFin, idEmpleado) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL VerTareadoHistoricoTrabajadorActivo(?,?,?)",
        [FechaDeInicio, FechaFin, idEmpleado]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getTareoPorFechaEnMinutos(FechaDeInicio, FechaFin, idEmpleado) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL VerTareadoHistoricoTrabajadorCalculadoEnMinutos(?,?,?)",
        [FechaDeInicio, FechaFin, idEmpleado]
      );
      return data[0];
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getObtenerTareoDelPeriodo(Periodo) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL ObtenerTareoPlanillaDelPeriodo(?)", [
        Periodo,
      ]);
      return data[0];
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async deleteCalculoDePago(Periodo) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL ReiniciarPlanillaDelPeriodo(?)", [
        Periodo,
      ]);
      return data[0];
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async createComun(
    FechaIN,
    HoraIngreso,
    HoraAlmuerzo,
    HoraFinDeAlmuerzo,
    HoraSalida,
    idEmpleado,
    idEstacion
  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL AgregarTareadoComun(?,?,?,?,?,?,?)", [
        FechaIN,
        HoraIngreso,
        HoraAlmuerzo,
        HoraFinDeAlmuerzo,
        HoraSalida,
        idEmpleado,
        idEstacion,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async createTareoMina(FechaIN, idOperacion, idEmpleado, idCondicionDeTareo) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL AgregarTareadoMina(?,?,?,?)", [
        FechaIN,
        idOperacion,
        idEmpleado,
        idCondicionDeTareo,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  /**
   * LICENCIAS SIN GOCES DE HABER
   * @param {*} FechaIN
   * @param {*} FechaFin
   * @param {*} idEmpleado
   * @param {*} LINK
   * @returns
   */

  async createLicenciaSinDeHaber(FechaIN, FechaFin, idEmpleado, LINK) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarLicenciasSinGoceDeHaber(?,?,?,?)",
        [FechaIN, FechaFin, LINK, idEmpleado]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getLicenciaSinDeHaber(DNI, fechaInicio, FechaFin) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerLicenciasSinGocePorDNI(?,?,?)",
        [DNI, fechaInicio, FechaFin]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  /**
   * LICENCIAS CON GOCES DE HABER
   * @param {*} FechaIN
   * @param {*} FechaFin
   * @param {*} idEmpleado
   * @param {*} LINK
   * @returns
   */

  async createLicenciaConDeHaber(FechaIN, FechaFin, idEmpleado, LINK) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarLicenciasConGoceDeHaber(?,?,?,?)",
        [FechaIN, FechaFin, LINK, idEmpleado]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getLicenciaConDeHaber(DNI, fechaInicio, FechaFin) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerLicenciasConGocePorDNI(?,?,?)",
        [DNI, fechaInicio, FechaFin]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  /**
   * HORAS EXTRAS
   * @param {*} LINK_IN
   * @param {*} idEmpleado
   * @param {*} FechaIN
   * @param {*} Cantidad25
   * @param {*} Cantidad35
   * @returns
   */
  async createHoraExtra(LINK_IN, idEmpleado, FechaIN, Cantidad25, Cantidad35) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL RegistrarHorasExtra(?,?,?,?,?)", [
        LINK_IN,
        idEmpleado,
        FechaIN,
        Cantidad25,
        Cantidad35,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getHorasExtras(idEmpleado) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL RegistrarHorasExtra(?,?,?,?)", [
        LINK_IN,
        idEmpleado,
        FechaIN,
        Cantidad25,
        Cantidad35,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  /**
   * DESCANSO MEDICO
   * @param {*} LINK_IN
   * @param {*} idEmpleado
   * @param {*} fechaInicio
   * @param {*} FechaFin
   * @returns
   */
  async createDescansoMedicosConIdEmpleado(
    LINK_IN,
    idEmpleado,
    fechaInicio,
    FechaFin
  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL RegistrarDescansoMedico(?,?,?,?)", [
        LINK_IN,
        idEmpleado,
        fechaInicio,
        FechaFin,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getDescansoMedicosPorDNI(DNI, FechaDeInicio, FechaFin) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerDescansosMedicosPorDNI(?,?,?)",
        [DNI, FechaDeInicio, FechaFin]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  /**
   * REGISTRAR VACACIONES
   * @param {*} LINK_IN
   * @param {*} idEmpleado
   * @param {*} fechaInicio
   * @param {*} FechaFin
   * @returns
   */
  async createRegistrarVacaciones(fechaInicio, FechaFin, LINK_IN, idEmpleado) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL RegistrarVacaciones(?,?,?,?)", [
        fechaInicio,
        FechaFin,
        LINK_IN,
        idEmpleado,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getVacacionesPorDNI(DNI, FechaDeInicio, FechaFin) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL ObtenerVacaciones(?,?,?)", [
        DNI,
        FechaDeInicio,
        FechaFin,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getTareoDividido(idContrato, FechaDeInicio, FechaFin) {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL VerRegistroDeTareoDividido(?,?,?)", [
        FechaDeInicio,
        FechaFin,
        idEmpleado,
      ]);
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }
}
module.exports = TareoModel;
