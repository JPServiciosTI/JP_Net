const DireccionModel = require("../models/direccion.model");

const direcionDb = new DireccionModel();
class DireccionController {
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