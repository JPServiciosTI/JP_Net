const connectionDb = require("../database/dbconections");
class DescuentoModel{
    async createDescuentoDeLey(  IDPERIODO_IN, IDCONTRATO_IN,INQUINTA_IN, TARDANZA_IN , FALTAS_IN , DESCUENTOFONDO_IN ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL RegistrarDescuentos(?,?,?,?,?,?)",
            [
                IDPERIODO_IN, 
                IDCONTRATO_IN,
                INQUINTA_IN, 
                TARDANZA_IN , 
                FALTAS_IN , 
                DESCUENTOFONDO_IN 
            ]
          );
          return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }


      async getDescuentos( CONTRATOID_IN ,  IDPERIODO_IN ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerDescuentos(?,?)",
            [
              CONTRATOID_IN ,  IDPERIODO_IN 
            ]
          );
          return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }
}

module.exports = DescuentoModel;