const ContratoModel = require("../models/contratos.model");
const contratoDb = new ContratoModel();

class DescuentosController {

    async calcularActoDePrestamo( DNI_IN){
        try {
            const result = contratoDb.createContrato( DNI_IN, FINICIO_IN,FECHAFIN_IN, SUELDO_BASE_IN , CISPP_IN , NHijos_IN );
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

module.exports = DescuentosController;