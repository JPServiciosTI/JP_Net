const connectionDb = require("../database/dbconections");
class ContratoModel{
    async createContrato(  DNI_IN, FINICIO_IN,FECHAFIN_IN, SUELDO_BASE_IN , CISPP_IN , NHijos_IN ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL CrearContratoVigente(?,?,?,?,?,?)",
            [
                DNI_IN, FINICIO_IN,FECHAFIN_IN, SUELDO_BASE_IN , CISPP_IN , NHijos_IN 
            ]
          );
          return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }
}

module.exports = ContratoModel;