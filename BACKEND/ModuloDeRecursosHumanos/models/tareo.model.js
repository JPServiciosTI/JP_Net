const connectionDb = require("../database/dbconections");
class TareoModel 
{
    async getTareoPorFecha(FechaDeInicio,FechaFin,idEmpleado){
        try {
            const con = connectionDb.promise();
            const data = await con.query(
              "CALL VerTareadoHistoricoTrabajadorActivo(?,?,?)",[FechaDeInicio,FechaFin,idEmpleado]);
            return { status: "ok", id: data[0]};
          } catch (error) {
            console.log(error);
            return { status: "error" };
          }      
    }



    async getTareoPorFechaEnMinutos(FechaDeInicio,FechaFin,idEmpleado){
      try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL VerTareadoHistoricoTrabajadorCalculadoEnMinutos(?,?,?)",[FechaDeInicio,FechaFin,idEmpleado]);
          return  data[0];
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }      
  }

    async create(FechaIN,HoraIngreso, HoraAlmuerzo, HoraFinDeAlmuerzo, HoraSalida,idEmpleado,idEstacion){
      try {
          const con = connectionDb.promise();
          const data = await con.query(
            "CALL AgregarTareadoComun(?,?,?,?,?,?,?)",[FechaIN,HoraIngreso, HoraAlmuerzo, HoraFinDeAlmuerzo, HoraSalida,idEmpleado,idEstacion]);
          return { status: "ok", id: data[0]};
        } catch (error) {
          console.log(error);
          return { status: "error" };
        }      
  }

  async createLicenciaDeHaber(FechaIN,FechaFin, idEmpleado, LINK){
    
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarLicenciasConGoceDeHaber(?,?,?,?)",[FechaIN,FechaFin, LINK, idEmpleado]);
      return { status: "ok", id: data[0]};
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }  
  }

  async createHoraExtra(LINK_IN,idEmpleado,FechaIN,Cantidad25,Cantidad35){
    
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarHorasExtra(?,?,?,?)",[LINK_IN,idEmpleado,FechaIN,Cantidad25,Cantidad35 ]);
      return { status: "ok", id: data[0]};
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }  
  }

  async getHorasExtras(idEmpleado){
    
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "CALL RegistrarHorasExtra(?,?,?,?)",[LINK_IN,idEmpleado,FechaIN,Cantidad25,Cantidad35 ]);
      return { status: "ok", id: data[0]};
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }  
  }

    
}
module.exports = TareoModel