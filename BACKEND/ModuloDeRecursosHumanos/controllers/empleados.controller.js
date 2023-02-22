const CargoModel = require("../models/cargo.model");
const ContratoModel = require("../models/contratos.model");
const DireccionModel = require("../models/direccion.model");
const EmpleadoModel = require("../models/empleado.model");
const LocalidadModel = require("../models/localidad.model");
const empleadoDb = new EmpleadoModel();
const direcionDb = new DireccionModel();
const cargoDb = new CargoModel();
const localidadDb = new LocalidadModel();
class EmpleadoController{
    async create(    NOMBRE_IN,
        APELLIDO_PATERNO_IN,
        APELLIDO_MATERNO_IN,
        DNI_IN,
        TELEFONO_IN,
        TELEFONOFIJO_IN,
        EMAIL_IN,
        CONTACTODEEMERGENCIA_IN,
        NUMERODEEMERGENCIA_IN,
        UBIGEO_IN,
        ID_LOCALIDAD_ACTUAL_IN,
        idTipoDeVia_IN , 
        NombreDeVia_IN , 
        idTipoDeLocalidad_IN ,
        NombreLocalidad_IN,
        FECHA_DE_NACIMIENTO_IN,
        ID_TIPO_DE_SANGRE_IN,
        ALERGIAS_IN,
        ID_CARGO_IN,
        FONDO_PENSIONES_IN){
        try {
            const resultDireccion = direcionDb.create(   idTipoDeVia_IN , NombreDeVia_IN , idTipoDeLocalidad_IN , NombreLocalidad_IN)
            const data1 = await resultDireccion.catch((err)=>{
                console.log("Controller Error: ", err);});  
            const resultDireccionId = direcionDb.getIdUltimaDireccion();
            const ID_DIRECCION_IN = await resultDireccionId.catch((err)=>{
                    console.log("Controller Error: ", err);});    
            const resultNacimientoId = localidadDb.getIdLocalidadPorUbigeo(UBIGEO_IN);
            const ID_LOCALIDAD_NACIMIENTO_IN = await resultNacimientoId.catch((err)=>{
                            console.log("Controller Error: ", err);});
            console.log("ESPERADO::::",ID_LOCALIDAD_NACIMIENTO_IN)        
            const result = empleadoDb.createEmpleado( NOMBRE_IN,
                APELLIDO_PATERNO_IN,
                APELLIDO_MATERNO_IN,
                DNI_IN,
                TELEFONO_IN,
                TELEFONOFIJO_IN,
                EMAIL_IN,
                CONTACTODEEMERGENCIA_IN,
                NUMERODEEMERGENCIA_IN,
                ID_LOCALIDAD_NACIMIENTO_IN['id'],
                ID_LOCALIDAD_ACTUAL_IN,
                ID_DIRECCION_IN['id'],
                FECHA_DE_NACIMIENTO_IN,
                ID_TIPO_DE_SANGRE_IN,
                ALERGIAS_IN,
                ID_CARGO_IN,
                FONDO_PENSIONES_IN);
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
     

    async getCargos(){
        try {
            const result = cargoDb.get();
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

    async update(    NOMBRE_IN,
        APELLIDO_PATERNO_IN,
        APELLIDO_MATERNO_IN,
        DNI_IN,
        TELEFONO_IN,
        TELEFONOFIJO_IN,
        EMAIL_IN,
        CONTACTODEEMERGENCIA_IN,
        NUMERODEEMERGENCIA_IN,
        ID_LOCALIDAD_NACIMIENTO_IN,
        ID_LOCALIDAD_ACTUAL_IN,
        ID_DIRECCION_IN,
        FECHA_DE_NACIMIENTO_IN,
        ID_TIPO_DE_SANGRE_IN,
        ALERGIAS_IN){
        try {
            const result = empleadoDb.updateDatosEmpleado(    NOMBRE_IN,
                APELLIDO_PATERNO_IN,
                APELLIDO_MATERNO_IN,
                DNI_IN,
                TELEFONO_IN,
                TELEFONOFIJO_IN,
                EMAIL_IN,
                CONTACTODEEMERGENCIA_IN,
                NUMERODEEMERGENCIA_IN,
                ID_LOCALIDAD_NACIMIENTO_IN,
                ID_LOCALIDAD_ACTUAL_IN,
                ID_DIRECCION_IN,
                FECHA_DE_NACIMIENTO_IN,
                ID_TIPO_DE_SANGRE_IN,
                ALERGIAS_IN);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data['id'];
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }

    async getForLimit(   ID_EMPLEADO_Inicio,Cantidad ){
        try {
            const result = empleadoDb.getEmpleadoForLimit(  ID_EMPLEADO_Inicio,Cantidad);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data['id'];
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }


}
module.exports = EmpleadoController;