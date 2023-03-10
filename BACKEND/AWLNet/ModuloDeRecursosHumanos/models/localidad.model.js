const connectionDb = require("../database/dbconections");
class LocalidadModel 
{
    async getLocalidades(){

    }

    async getIdLocalidadPorUbigeo(UbigeoIN){
        try {
            const con = connectionDb.promise();
            const data = await con.query(
              "CALL ObtenerIdPorUbigeo(?)",[UbigeoIN]);
            return { status: "ok", id: data[0][0][0]['idLocalidad']};
          } catch (error) {
            console.log(error);
            return { status: "error" };
          }       
    }


}
module.exports = LocalidadModel;