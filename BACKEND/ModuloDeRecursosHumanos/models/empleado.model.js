const connectionDb = require("../database/dbconections");
class EmpleadoModel {
  async createEmpleado(
    NOMBRE_IN,
    APELLIDO_PATERNO_IN,
    APELLIDO_MATERNO_IN,
    DNI_IN,
    TELEFONO_IN,
    TELEFONOFIJO_IN,
    EMAIL_IN,
    CONTACTODEEMERGENCIA_IN,
    NUMERODEEMERGENCIA_IN,
    ID_LOCALIDAD_NACIMIENTO_IN,
    ID_LOCALIDAD_ACTUAL_IN,
    ID_DIRECCION_IN,
    FECHA_DE_NACIMIENTO_IN,
    ID_TIPO_DE_SANGRE_IN,
    ALERGIAS_IN,
    ID_CARGO_IN,
    FONDO_PENSIONES_IN
  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL CrearEmpleado(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          NOMBRE_IN,
          APELLIDO_PATERNO_IN,
          APELLIDO_MATERNO_IN,
          DNI_IN,
          TELEFONO_IN,
          TELEFONOFIJO_IN,
          EMAIL_IN,
          CONTACTODEEMERGENCIA_IN,
          NUMERODEEMERGENCIA_IN,
          ID_LOCALIDAD_NACIMIENTO_IN,
          ID_LOCALIDAD_ACTUAL_IN,
          ID_DIRECCION_IN,
          FECHA_DE_NACIMIENTO_IN,
          ID_TIPO_DE_SANGRE_IN,
          ALERGIAS_IN,
          ID_CARGO_IN,
          FONDO_PENSIONES_IN,
        ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async updateDatosEmpleado(
    NOMBRE_IN,
    APELLIDO_PATERNO_IN,
    APELLIDO_MATERNO_IN,
    DNI_IN,
    TELEFONO_IN,
    TELEFONOFIJO_IN,
    EMAIL_IN,
    CONTACTODEEMERGENCIA_IN,
    NUMERODEEMERGENCIA_IN,
    ID_LOCALIDAD_NACIMIENTO_IN,
    ID_LOCALIDAD_ACTUAL_IN,
    ID_DIRECCION_IN,
    FECHA_DE_NACIMIENTO_IN,
    ID_TIPO_DE_SANGRE_IN,
    ALERGIAS_IN
  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ActualizarEmpleado(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          NOMBRE_IN,
          APELLIDO_PATERNO_IN,
          APELLIDO_MATERNO_IN,
          DNI_IN,
          TELEFONO_IN,
          TELEFONOFIJO_IN,
          EMAIL_IN,
          CONTACTODEEMERGENCIA_IN,
          NUMERODEEMERGENCIA_IN,
          ID_LOCALIDAD_NACIMIENTO_IN,
          ID_LOCALIDAD_ACTUAL_IN,
          ID_DIRECCION_IN,
          FECHA_DE_NACIMIENTO_IN,
          ID_TIPO_DE_SANGRE_IN,
          ALERGIAS_IN,
        ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async deleteEmpleado(    ID_EMPLEADO  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL EliminarEmpleado(?)",
        [ID_EMPLEADO]
      );E
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getEmpleadoForLimit(    ID_EMPLEADO_Inicio,Cantidad  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerEmpleados(?,?)",
        [ ID_EMPLEADO_Inicio||0,Cantidad ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getIdEmpleado(   DNI  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerIdEmpleado(?)",
        [ DNI ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }

  async getEmpleado(   DNI  ) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL ObtenerEmpleado(?)",
        [ DNI ]
      );
      return { status: "ok", id: data[0] };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }
  }
}
module.exports = EmpleadoModel;
