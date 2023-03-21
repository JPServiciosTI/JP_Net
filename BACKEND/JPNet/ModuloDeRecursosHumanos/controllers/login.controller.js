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

class LoginController { 
     
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

    async authenticate(email,password){
        console.log(email,password);
        try {
            const result = loginDb.authenticate(email,password);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return { status: "error", id: null };
            })
            if(data.id==null){
                return { status: "error", id: null };
            }
            return data;
        } catch (error) {
            console.log("Controller Error: ", error);
            return { status: "error", id: null };
        }
    }

    async authenticate(email,password){
        try {
            const result = loginDb.authenticate(email,password);
            const data = await result.catch((err)=>{
                console.log("Controller Error: ", err);
                return { status: "error", id: null };
            })
            if(data.id==null){
                return { status: "error", id: null };
            }
            return data;
        } catch (error) {
            console.log("Controller Error: ", error);
            return { status: "error", id: null };
        }
    }


}
module.exports = LoginController;
