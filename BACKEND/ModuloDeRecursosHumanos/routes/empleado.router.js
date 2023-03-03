const fileURLTPath = require("url");
var express = require("express");
const router = express.Router();

const EmpleadoController = require("../controllers/empleados.controller");
const empleadoController = new EmpleadoController();

const ContratoController = require("../controllers/contrato.controller");
const contratoController = new ContratoController();

const DireccionController = require("../controllers/direccion.controller");
const direccionController = new DireccionController();

const cargarArchivosController = require("../controllers/cargarArchivos.controller");

const fs = require("fs/promises");
const path = require("path");


router.post("/register", async (req, res) => {
  try {
    console.log(req.body.email, req.body.password);
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
      req.body.ubigeo,
      req.body.idLocalidadActual,
      req.body.idTipodeVia,
      req.body.nombreDeVia,
      req.body.idTipoDeLocalidad,
      req.body.nombreLocalidad,
      req.body.fechadenacimiento,
      req.body.idTipoDeSangre,
      req.body.alergias,
      req.body.idcargo,
      req.body.idfondodepension
    );
    res.setHeader("Content-Type", "application/json");
    if (info.status == null || info.status == "error") {
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
    return { status: res.status(501), id: null };
  }
});

router.put("/update", async (req, res) => {
  try {
    console.log(req.body.email, req.body.password);
    const info = await empleadoController.update(
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
      req.body.alergias
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

router.get("/direccion/ultimate", async (req, res) => {
  try {
    const info = await direccionController.getUltimaDireccion();
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

router.get("/cargos", async (req, res) => {
  try {
    const info = await empleadoController.getCargos();
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

router.get("/getforlimit", async (req, res) => {
  try {
    const info = await empleadoController.getForLimit(req.body.idEmpleado, 10);
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

router.post("/gettareo", async (req, res) => {
  try {
    console.log(
      req.params.idEmpleado,
      req.params.fechaInicio,
      req.params.fechaFin
    );
    const info = await empleadoController.getTareoPorFecha(
      req.body.idEmpleado,
      req.body.fechaInicio,
      req.body.fechaFin
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

router.post("/register/tareo", async (req, res) => {
  try {
    let now = new Date();
    //	YYYY-MM-DD
    let fecha = now.getFullYear() + "-" + now.getMonth() + "-" + now.getDay();
    const info = await empleadoController.registrarTareo(
      fecha,
      req.body.idEmpleado,
      req.body.horaIngreso,
      req.body.horaInicioAlmuerzo,
      req.body.horaFinAlmuerzo,
      req.body.horaSalida
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

router.post("/register/horaextra", async (req, res) => {
  try {
    let now = new Date();
    //	YYYY-MM-DD
    let fecha = now.getFullYear() + "-" + now.getMonth() + "-" + now.getDay();
    const info = await empleadoController.registrarLicenciaDeHaber(
      req.body.idEmpleado,
      req.body.horaInicio,
      req.body.horaFin,
      req.body.linkDocumento
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

router.post("/register/licenciacongoce", async (req, res) => {
  try {
    const info = await empleadoController.registrarLicenciaDeHaber(
      req.body.idEmpleado,
      req.body.fechaInicio,
      req.body.fechaFin,
      req.body.linkDocumento
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

module.exports = router;
