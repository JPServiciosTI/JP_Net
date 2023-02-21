var express = require("express");
const router = express.Router();

const EmpleadoController = require("../controllers/empleados.controller");
const empleadoController = new EmpleadoController();
const ContratoController = require("../controllers/contrato.controller");
const contratoController = new ContratoController();
router.post("/register", async (req, res) => {
  try {
    console.log(req.body.email, req.body.password)
    const info = await empleadoController.create(
        req.body.nombre, 
        req.body.apellidoPaterno,
        req.body.apellidoMaterno,
        req.body.dni,
        req.body.telefono,
        req.body.telefonofijo,        
        req.body.email,
        req.body.contactodeemergencia,
        req.body.numerodeemergencia,
        req.body.idLocalidad,
        req.body.ubigeo,
        req.body.idDireccion,
        req.body.fechadenacimiento,
        req.body.idTipoDeSangre,
        req.body.alergias,
        req.body.idcargo,
        req.body.idfondodepension
        );    
    res.setHeader("Content-Type", "application/json");
    if (info.status == null) {
      res.status(502).end(JSON.stringify(info)).json({
        status: "ERROR",
      });
      return;
    }
    const info2 = await contratoController.create(
        req.body.dni,
        req.body.fechainicialcontrato,
        req.body.fechafincontrato,        
        req.body.sueldobase,
        req.body.cispp,
        req.body.nhijos
        );    
    res.setHeader("Content-Type", "application/json");
    if (info2.status == null) {
      res.status(502).end(JSON.stringify(info)).json({
        status: "ERROR",
      });
      return;
    }


    res.setHeader("Content-Type", "application/json");
    res.end(JSON.stringify(info2));
  } catch (error) {
    console.log("Ruta Error: ", error);
    return {status: res.status(501), id:null};
  }
});

router.put("/updateProcess", async (req, res) => {
    try {
      console.log(req.body.email, req.body.password)
      const info = await candidatoController.updateProcesoDeSeleccion(
          req.body.dni,
          req.body.etapaprevia,
          req.body.etapadellamada,
          req.body.etapadeentrevista,
          req.body.etapadecontratacion,
          );
      res.setHeader("Content-Type", "application/json");
      if (info.status == null) {
        res.status(502).end(JSON.stringify(info)).json({
          status: "ERROR",
        });
        return;
      }
      res.setHeader("Content-Type", "application/json");
      res.end(JSON.stringify(info));
    } catch (error) {
      console.log("Ruta Error: ", error);
      return {status: res.status(501), id:null};
    }
  });

  module.exports = router;