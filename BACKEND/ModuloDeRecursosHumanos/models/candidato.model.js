const connectionDb = require("../database/dbconections");
class CandidatoModel {
    async create(NOMBRES,APELLIDO_PATERNO, APELLIDO_MATERNO, DNI,TELEFONO,EMAIL,SALARIOTENTATIVO,Id_CARGO_OPTAR,MESES_EXPERIENCIA,LINK_CV) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL CrearCandidatoNuevo(?,?,?,?,?,?,?,?,?,?)", [NOMBRES,APELLIDO_PATERNO, APELLIDO_MATERNO, DNI,TELEFONO,EMAIL,SALARIOTENTATIVO,Id_CARGO_OPTAR,MESES_EXPERIENCIA,LINK_CV]);
        return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
    
      }  

      async getForLimit(IDINICIO,CANTIDAD) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerCandidatos(?,?)", [IDINICIO,CANTIDAD]);
        return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }  
    
      async delete(IDCandidato) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL EliminarCandidato(?)", [IDCandidato]);
        return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }    

      async update(IDCandidato,EtapaPrevia,EtapaDeLlamada,EtapaEntrevista,EtapaDeContratacion) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ActualizarCandidato(?,?,?,?,?)", [IDCandidato,EtapaPrevia,EtapaDeLlamada,EtapaEntrevista,EtapaDeContratacion]);
        return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }     
}
module.exports = CandidatoModel;

