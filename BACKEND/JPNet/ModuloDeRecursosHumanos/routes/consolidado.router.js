var express = require("express");
const router = express.Router();

const ConsolidadoController = require("../controllers/consolidado.controller");
const consolidadoController = new ConsolidadoController();

router.get("/consolidado", async (req, res) => {
  try {
    const info = await consolidadoController.getConsolidadoDePlanilla(
      req.query.periodo
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
    return { status: res.status(501), id: null };
  }
});

router.get("/preboleta", async (req, res) => {
  try {
    const info = await consolidadoController.getPreboletaPorDNI(
      req.query.periodo,
      req.query.DNI
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
    return { status: res.status(501), id: null };
  }
});
module.exports = router;
