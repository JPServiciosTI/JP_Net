var express = require("express");
const router = express.Router();

const LoginController = require("../controllers/login.controller");
const loginController = new LoginController;

router.post("/login", async (req, res) => {
  try {
    console.log("AQEUSF",req.body.email, req.body.password)
    const info = await loginController.authenticate(req.body.email, req.body.password);
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


router.get("/getall", async (req, res) => {
  try {
    const info = await loginController.getAll();
    res.setHeader("Content-Type", "application/json");
    if (info == null) {
      res.status(502).end(JSON.stringify(info)).json({
        status: "ERROR",
      });
      return;
    }
    res.setHeader("Content-Type", "application/json");
    res.end(JSON.stringify(info));
  } catch (error) {
    console.log("Ruta Error: ", error);
    return res.status(501);
  }
});



router.post("/create", async (req, res) => {
  try {
    console.log(req.body.email,req.body.password);
    const info = await loginController.create(req.body.email,req.body.password,1);
    console.log(info);
    res.setHeader("Content-Type", "application/json");
    if (info == null) {
      res.status(502).end(JSON.stringify(info)).json({
        status: "ERROR",
      });
      return;
    }
    res.setHeader("Content-Type", "application/json");
    res.end(JSON.stringify(info));
  } catch (error) {
    console.log("Ruta Error: ", error);
    return res.status(501);
  }
});


module.exports = router;
