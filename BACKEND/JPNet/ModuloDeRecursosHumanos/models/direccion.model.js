const connectionDb = require("../database/dbconections");
class DireccionModel{
    async create( idTipoDeVia_IN , NombreDeVia_IN ,idTipoDeLocalidad_IN , NombreLocalidad_IN ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL CrearDireccion(?,?,?,?)",
            [
                idTipoDeVia_IN , NombreDeVia_IN ,idTipoDeLocalidad_IN , NombreLocalidad_IN
            ]
          );
          return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }

      async getIdUltimaDireccion( ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerUltimaDireccion()",[]);
          return { status: "ok", id: data[0][0][0]['idDireccion'] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }

      async getUltimaDireccion( ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerUltimaDireccion()",[]);
          return { status: "ok", id: data[0][0]};
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }
}
module.exports = DireccionModel;