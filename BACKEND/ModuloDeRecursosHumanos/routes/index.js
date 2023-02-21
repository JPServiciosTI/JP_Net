var express = require('express');
var router = express.Router();

const userRouter = require('./login.router');
const candidatoRouter = require("./candidato.router");
const empleadoRouter = require("./empleado.router");

/* GET home page. */
function routerApi(app){
  app.use("/api/v1",router);
  router.use('/user',userRouter);
  router.use('/candidato',candidatoRouter);
  router.use('/empleado',empleadoRouter);
}

module.exports = routerApi;
