var express = require("express");
var router = express.Router();

const userRouter = require("./login.router");
const candidatoRouter = require("./candidato.router");
const empleadoRouter = require("./empleado.router");
const planillaRouter = require("./planilla.router");
const consolidadoRouter = require("./consolidado.router");

/* GET home page. */
function routerApi(app) {
  app.use("/api/v1", router);
  router.use("/user", userRouter);
  router.use("/candidato", candidatoRouter);
  router.use("/empleado", empleadoRouter);
  router.use("/planilla", planillaRouter);
  router.use("/consolidado", consolidadoRouter);
}

module.exports = routerApi;
