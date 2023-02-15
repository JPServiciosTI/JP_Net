const express = require("express");
const tools = require("../libs/tools");
const connectionDb = require("../database/dbconections");
class LoginModel {
  async getAll() {
    try {
      const con = connectionDb.promise();
      const data = await con.query("CALL ObtenerUsuarios()");
      return { status: "ok", id: data[0] };
    } catch (error) {
      return { status: "error"};
    }

  }
  async authenticate(email, password) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        "SELECT * FROM login WHERE Email = ?", [email] );
        if (tools.compareHash(password, data[0][0].Password)) {
          return { status: "ok", id: data[0][0] };
        }
        return { status: "error" };
    }catch (error) {
      console.log(error);
      return { status: "error" };
    }

  }

  async create(email, password,PersonaID) {
    try {
      const con = connectionDb.promise();
      const data = await con.query(
        " CALL CrearUsuario(?,?,?);", [email,tools.toHash(password),PersonaID]);
      return { status: "ok", id: data };
    } catch (error) {
      console.log(error);
      return { status: "error" };
    }

  }  
}

module.exports = LoginModel;