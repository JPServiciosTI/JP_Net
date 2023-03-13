const ContratoModel = require("../models/contratos.model");
const CandidatoModel = require("../models/candidato.model");
const candidatoDb = new CandidatoModel();

class CandidatoController{
    async create(                
        NOMBRE_IN,
        APELLIDO_PATERNO_IN,
        APELLIDO_MATERNO_IN,
        DNI_IN,
        TELEFONO_IN,
        EMAIL_IN,
        SALARIOTENTATIVO_IN,
        ID_CARGO_A_OPTAR_IN,
        ID_MESES_EXPERIENCIA_IN,
        ID_LINK_CV_IN){
        try {
            const result = candidatoDb.create(    
                NOMBRE_IN,
                APELLIDO_PATERNO_IN,
                APELLIDO_MATERNO_IN,
                DNI_IN,
                TELEFONO_IN,
                EMAIL_IN,
                SALARIOTENTATIVO_IN,
                ID_CARGO_A_OPTAR_IN,
                ID_MESES_EXPERIENCIA_IN,
                ID_LINK_CV_IN);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data;
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }
     

    async updateProcesoDeSeleccion(  IDCandidato,EtapaPrevia,EtapaDeLlamada,EtapaEntrevista,EtapaDeContratacion){
        try {
            const result = candidatoDb.update( IDCandidato,EtapaPrevia,EtapaDeLlamada,EtapaEntrevista,EtapaDeContratacion);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data;
        } catch (error) {
            console.log("Controller Error: ", error);
            return null;
        }
    }
 
    async getForLimit(   ID_EMPLEADO_Inicio,Cantidad ){
        try {
            const result = candidatoDb.getForLimit(  ID_EMPLEADO_Inicio,Cantidad);
            const data = await result.catch((err)=>{
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
module.exports = CandidatoController;