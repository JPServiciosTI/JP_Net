const CargoModel = require("../models/cargo.model");
const ContratoModel = require("../models/contratos.model");
const DireccionModel = require("../models/direccion.model");
const EmpleadoModel = require("../models/empleado.model");
const LocalidadModel = require("../models/localidad.model");
const TareoModel = require("../models/tareo.model");
const empleadoDb = new EmpleadoModel();
const direcionDb = new DireccionModel();
const cargoDb = new CargoModel();
const localidadDb = new LocalidadModel();
const tareoDb = new TareoModel();
class EmpleadoController {
  async create(
    NOMBRE_IN,
    APELLIDO_PATERNO_IN,
    APELLIDO_MATERNO_IN,
    DNI_IN,
    TELEFONO_IN,
    TELEFONOFIJO_IN,
    EMAIL_IN,
    CONTACTODEEMERGENCIA_IN,
    NUMERODEEMERGENCIA_IN,
    UBIGEO_IN,
    ID_LOCALIDAD_ACTUAL_IN,
    idTipoDeVia_IN,
    NombreDeVia_IN,
    idTipoDeLocalidad_IN,
    NombreLocalidad_IN,
    FECHA_DE_NACIMIENTO_IN,
    ID_TIPO_DE_SANGRE_IN,
    ALERGIAS_IN,
    ID_CARGO_IN,
    FONDO_PENSIONES_IN
  ) {
    try {
      const resultDireccion = direcionDb.create(
        idTipoDeVia_IN,
        NombreDeVia_IN,
        idTipoDeLocalidad_IN,
        NombreLocalidad_IN
      );
      const data1 = await resultDireccion.catch((err) => {
        console.log("Controller Error: ", err);
      });
      const resultDireccionId = direcionDb.getIdUltimaDireccion();
      const ID_DIRECCION_IN = await resultDireccionId.catch((err) => {
        console.log("Controller Error: ", err);
      });
      const resultNacimientoId = localidadDb.getIdLocalidadPorUbigeo(UBIGEO_IN);
      const ID_LOCALIDAD_NACIMIENTO_IN = await resultNacimientoId.catch(
        (err) => {
          console.log("Controller Error: ", err);
        }
      );
      console.log("ESPERADO::::", ID_LOCALIDAD_NACIMIENTO_IN);
      const result = empleadoDb.createEmpleado(
        NOMBRE_IN,
        APELLIDO_PATERNO_IN,
        APELLIDO_MATERNO_IN,
        DNI_IN,
        TELEFONO_IN,
        TELEFONOFIJO_IN,
        EMAIL_IN,
        CONTACTODEEMERGENCIA_IN,
        NUMERODEEMERGENCIA_IN,
        ID_LOCALIDAD_NACIMIENTO_IN["id"],
        ID_LOCALIDAD_ACTUAL_IN,
        ID_DIRECCION_IN["id"],
        FECHA_DE_NACIMIENTO_IN,
        ID_TIPO_DE_SANGRE_IN,
        ALERGIAS_IN,
        ID_CARGO_IN,
        FONDO_PENSIONES_IN
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

  async getCargos() {
    try {
      const result = cargoDb.get();
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

  async update(
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
      const result = empleadoDb.updateDatosEmpleado(
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
      );
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return null;
      });
      return data["id"];
    } catch (error) {
      console.log("Controller Error: ", err);
      return null;
    }
  }

  async getForLimit(ID_EMPLEADO_Inicio, Cantidad) {
    try {
      const result = empleadoDb.getEmpleadoForLimit(
        ID_EMPLEADO_Inicio,
        Cantidad
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

  async getTareoPorFecha(ID_EMPLEADO, FechaDeInicio, FechaFin) {
    console.log("Pasan los Datos", ID_EMPLEADO, FechaDeInicio, FechaFin);

    try {
      const result = tareoDb.getTareoPorFecha(
        FechaDeInicio,
        FechaFin,
        ID_EMPLEADO
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

  async registrarTareoComun(
    DateIN,
    ID_EMPLEADO,
    HoraIngreso,
    HoraAlmuerzo,
    HoraFinDeAlmuerzo,
    HoraSalida,
    IdEstacionDeTrabajo
  ) {
    console.log(
      DateIN,
      ID_EMPLEADO,
      HoraIngreso,
      HoraAlmuerzo,
      HoraFinDeAlmuerzo,
      HoraSalida
    );
    try {
      const result = tareoDb.createComun(
        DateIN,
        HoraIngreso,
        HoraAlmuerzo,
        HoraFinDeAlmuerzo,
        HoraSalida,
        ID_EMPLEADO,
        IdEstacionDeTrabajo
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

  async registrarTareoMina(
    FechaIN,
    idOperacion,
    idEmpleado,
    idCondicionDeTareo
  ) {
    try {
      const result = tareoDb.createTareoMina(
        FechaIN,
        idOperacion,
        idEmpleado,
        idCondicionDeTareo
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

  async registrarLicenciaConDeHaber(
    ID_EMPLEADO,
    FechaDeInicio,
    FechaFin,
    Link
  ) {
    console.log(ID_EMPLEADO);
    try {
      const result = tareoDb.createLicenciaConDeHaber(
        FechaDeInicio,
        FechaFin,
        ID_EMPLEADO,
        Link
      );
      const data = await result.catch((err) => {
        console.log("Controller Error: ", err);
        return null;
      });
      return data;
    } catch (error) {
      console.log("Controller Error: ", error);
      return null;
    }
  }

  async getLicenciaConDeHaber(DNI, FechaDeInicio, FechaFin, Link) {
    try {
      const result = tareoDb.getLicenciaConDeHaber(
        DNI,
        FechaDeInicio,
        FechaFin
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

  async registrarLicenciaSinDeHaber(
    ID_EMPLEADO,
    FechaDeInicio,
    FechaFin,
    Link
  ) {
    console.log(ID_EMPLEADO);
    try {
      const result = tareoDb.createLicenciaSinDeHaber(
        FechaDeInicio,
        FechaFin,
        ID_EMPLEADO,
        Link
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

  async getLicenciaSinDeHaber(DNI, FechaDeInicio, FechaFin) {
    console.log(ID_EMPLEADO);
    try {
      const result = tareoDb.getLicenciaSinDeHaber(
        DNI,
        FechaDeInicio,
        FechaFin
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

  async registrarHoraExtra(
    LINK_IN,
    idEmpleado,
    FechaIN,
    Cantidad25,
    Cantidad35
  ) {
    console.log(idEmpleado);
    try {
      const result = tareoDb.createHoraExtra(
        LINK_IN,
        idEmpleado,
        FechaIN,
        Cantidad25,
        Cantidad35
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

  async registrarDescansoMedico(LINK_IN, idEmpleado, fechaInicio, FechaFin) {
    console.log(idEmpleado);
    try {
      const result = tareoDb.createDescansoMedicosConIdEmpleado(
        LINK_IN,
        idEmpleado,
        fechaInicio,
        FechaFin
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

  async registrarPeriodoVacacional(ID_EMPLEADO, FechaDeInicio, FechaFin, Link) {
    console.log(ID_EMPLEADO);
    try {
      const result = tareoDb.createRegistrarVacaciones(
        FechaDeInicio,
        FechaFin,
        Link,
        ID_EMPLEADO
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

  async getVacacionesDelEmpleado(DNI, FechaDeInicio, FechaFin) {
    console.log(ID_EMPLEADO);
    try {
      const result = tareoDb.getVacacionesPorDNI(DNI, FechaDeInicio, FechaFin);
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
module.exports = EmpleadoController;
