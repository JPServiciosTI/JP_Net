const DireccionModel = require("../models/direccion.model");
const LocalidadModel = require("../models/localidad.model");
const direcionDb = new DireccionModel();
const localidadDb = new LocalidadModel();

class DireccionController {
  async getIdLocalidadPorUbigeo() {
    try {
      const result = localidadDb.getIdLocalidadPorUbigeo();

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

  async getUltimaDireccion() {
    try {
      const result = direcionDb.getUltimaDireccion();

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

module.exports = DireccionController;