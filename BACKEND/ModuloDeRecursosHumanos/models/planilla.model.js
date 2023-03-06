const connectionDb = require("../database/dbconections");
class PlanillaModel {

    async calcularPagosDePlanilla(Fecha_Inicio,Fecha_Fin,idContrato) {
        try {
          const con = connectionDb.promise();
          const data = await con.query("CALL VerTareadoHistoricoTrabajadorActivo(?,?,?)",[Fecha_Inicio,Fecha_Fin,idContrato]);
          return { status: "ok", id: data[0] };
        } catch (error) {
          return { status: "error"};
        }
    
      }

      async obtenerPersonalDePlanilla() {
        try {
          const con = connectionDb.promise();
          const data = await con.query("CALL ObtenerUsuarios()");
          return { status: "ok", id: data[0] };
        } catch (error) {
          return { status: "error"};
        }
    
      }

      async getDatosPeriodo() {
        try {
          const con = connectionDb.promise();
          const data = await con.query("CALL ObtenerDatosPeriodo()");
          return { status: "ok", id: data[0] };
        } catch (error) {
          return { status: "error"};
        }
    
      }


      async CrearPago(idTareo,CantidadDePago,idPeriodo ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL CrearPagoDelTareo(?,?,?)",
            [
                idTareo,CantidadDePago,idPeriodo 
            ]
          );
          return { status: "ok"};
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }


      async CalcularSueldoBruto(DNI,Fecha_Inicio,Fecha_Fin ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL CalcularRemuneracionBruta(?,?,?)",
            [
                DNI,Fecha_Inicio,Fecha_Fin
            ]
          );
          return { status: "ok", id: data[0][0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }

      async ObtenerPersonalParaPlanilla(Fecha_Inicio,Fecha_Fin ) {
        try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL ObtenerPlanillaEmpleados(?,?)",
            [
                Fecha_Inicio,Fecha_Fin
            ]
          );
          return { status: "ok", id: data[0] };
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }
      }

}

module.exports = PlanillaModel;