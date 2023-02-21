var express = require("express");
const router = express.Router();

const CandidatoController = require("../controllers/candidato.controller");
const candidatoController = new CandidatoController();

router.post("/register", async (req, res) => {
  try {
    console.log(req.body.email, req.body.password)
    const info = await candidatoController.create(
        req.body.nombre, 
        req.body.apellidoPaterno,
        req.body.apellidoMaterno,
        req.body.dni,
        req.body.telefono,
        req.body.email,
        req.body.salarioTentativo,
        req.body.cargOptarID,
        req.body.mesesDeExperiencia,
        req.body.linkCV
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

router.put("/updateProcess", async (req, res) => {
    try {
      console.log(          req.body.dni,
        req.body.etapaprevia,
        req.body.etapadellamada,
        req.body.etapadeentrevista,
        req.body.etapadecontratacion)
      const info = await candidatoController.updateProcesoDeSeleccion(
          req.body.dni,
          req.body.etapaprevia,
          req.body.etapadellamada,
          req.body.etapadeentrevista,
          req.body.etapadecontratacion
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

  router.get("/getForLimit", async (req, res) => {
    try {
      console.log(req.body.idmin, req.body.cantidad)
      const info = await candidatoController.getForLimit(req.body.idmin, req.body.cantidad);
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