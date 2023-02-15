var express = require('express');
var router = express.Router();

const userRouter = require('./users.router');

/* GET home page. */
function routerApi(app){
  app.use("/api/v1",router);
  router.use('/user',userRouter);
}

module.exports = routerApi;
