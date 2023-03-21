const connectionDb = require("../database/dbconections");
class CargoModel{
    async get() {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerCargos()", []);
        return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
    
      }  v
}

module.exports = CargoModel;