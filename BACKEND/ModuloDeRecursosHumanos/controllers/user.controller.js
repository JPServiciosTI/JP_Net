/**
 * Librerias
 */
const express = require("express");
const router = express.Router();

/**
 * Modelos
 */

const LoginModel = require ("../models/login.model");
const loginDb = new LoginModel();

class UserController { 
    async login(email,password){
        try {
            const result = loginDb.authenticate(email,password);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data;
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }


     
    async getAll(){
        try {
            const result = loginDb.getAll();
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data['id'];
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }
     
    
    async create(email,password,PersonaID){
        try {
            const result = loginDb.create(email,password,PersonaID);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return null;
            });
            return data;
        } catch (error) {
            console.log("Controller Error: ", err);
            return null;
        }
    }


}
module.exports = UserController;
