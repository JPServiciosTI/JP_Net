var express = require("express");
const router = express.Router();

const PlanillaController = require("../controllers/planilla.controller");
const planillaController = new PlanillaController();

router.get("/periodos", async (req, res) => {
  try {
    const info = await planillaController.obtenerPeriodos();
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
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

router.get("/calculo", async (req, res) => {
  try {
    const info = await planillaController.CalcularPagosATrabajadores(
      "2023-01-16",
      "2023-02-15",
      2
    );
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
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

router.get("/sueldobruto", async (req, res) => {
  try {
    console.log(req.query.DNI, req.query.FechaInicio, req.query.FechaFin);
    const info = await planillaController.obtenerSueldoBruto(
      req.query.DNI,
      req.query.FechaInicio,
      req.query.FechaFin
    );
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
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

router.get("/personas", async (req, res) => {
  try {
    const info = await planillaController.CalcularPagosATrabajadores(
      "2023-01-16",
      "2023-02-15",
      2
    );
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
      res.status(502).end(JSON.stringify(info)).json({
        status: "ERROR",
      });
      return;
    }
  } catch (error) {
    console.log("Ruta Error: ", error);
    return { status: res.status(501), id: null };
  }

  try {
    const info = await planillaController.obtenerPreGeneradoDePlanilla(
      req.query.FechaInicio,
      req.query.FechaFin,
      req.body.Periodo
    );
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
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

router.get("/descuentos", async (req, res) => {
  try {
    //const info = await planillaController.obtenerDescuentos(req.query.idContrato,req.query.Periodo);
    let info = { status: "ok" };
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error" || info.id == null) {
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
