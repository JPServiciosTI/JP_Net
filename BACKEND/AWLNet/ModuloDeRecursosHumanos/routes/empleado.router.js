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



const multer = require('multer');
const mimeTypes = require("mime-types");


const storage = multer.diskStorage({
  destination: 'upload/',
  filename: function(req,file,cb){
    cb("",Date.now()+file.originalname+"." + mimeTypes.extension(file.mimetype));
  }
  
})

const upload = multer({
  storage: storage
})

router.get("/image", (req,res)=>{
  console.log(__dirname);
})


router.get("/files",upload.single('image') ,(req,res)=>{
  res.send('Tudo bem');
})


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

router.post("/register/tareo/comun", async (req, res) => {
  console.log("AQUI",      req.body.fecha,
  req.body.idEmpleado,
  req.body.horaIngreso,
  req.body.horaInicioAlmuerzo,
  req.body.horaFinAlmuerzo,
  req.body.horaSalida,
  req.body.idEstacionDeTrabajo)
  try {
    const info = await empleadoController.registrarTareoComun(
      req.body.fecha,
      req.body.idEmpleado,
      req.body.horaIngreso,
      req.body.horaInicioAlmuerzo,
      req.body.horaFinAlmuerzo,
      req.body.horaSalida,
      req.body.idEstacionDeTrabajo
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

router.post("/register/tareo/mina", async (req, res) => {
  try {
    const info = await empleadoController.registrarTareoMina(
      req.body.fecha,
      req.body.idOperacion,
      req.body.idEmpleado,
      1
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

router.get("/register/horaextra" , async (req, res) => {
try {
    //	YYYY-MM-DD
    const info = await empleadoController.registrarHoraExtra(
      req.body.idEmpleado,
      req.body.Fecha,
      req.body.Cantidad25,
      req.body.Cantidad35,
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
 } }
);

router.post("/register/licenciacongoce", async (req, res) => {
  try {
    const info = await empleadoController.registrarLicenciaConDeHaber(
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

router.post("/register/licenciasingoce", async (req, res) => {
  try {
    console.log(
      req.body.idEmpleado,
      req.body.fechaInicio,
      req.body.fechaFin,
      req.body.linkDocumento
    );
    const info = await empleadoController.registrarLicenciaSinDeHaber(
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

router.post("/register/descansosmedicos", async (req, res) => {
  try {
    const info = await empleadoController.registrarDescansoMedico(
      req.body.linkDocumento,
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

router.post("/register/vacaciones", async (req, res) => {
  try {
    const info = await empleadoController.registrarPeriodoVacacional(
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

router.post("/register/tareo/feriadotrabajado", async (req, res) => {
  try {
    const info = await empleadoController.registrarTareoMina(
      req.body.fecha,
      1,
      req.body.idEmpleado,
      8
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

router.post("/register/tareo/descansotrabajado", async (req, res) => {
  try {
    const info = await empleadoController.registrarTareoMina(
      req.body.fecha,
      1,
      req.body.idEmpleado,
      7
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
