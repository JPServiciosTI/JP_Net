import React, { useState } from "react";
import { useHistory } from 'react-router-dom';
import { useCookies } from "react-cookie";
import { post } from "../../../services/api/api.service";
import { Route } from 'react-router-dom';
import './formlogin.css'
function LoginForm() {
  const [cookies, setCookie, removeCookie] = useCookies([
    "jp_net_time",
    "jp_net_user",
    "jp_net_email",
  ]);

  const [timesection, setTimeSection] = useState(
    cookies["jp_net_time"] || null
  );
  const [user, setUser] = useState(cookies["jp_net_user"] || null);


  const handleFinish = async (values) => {
    try {
      console.log("Datos> ", values);
      const registro = await post({
        url: "user/login",
        data: {
          Email: values.email,
          Password: values.password,
        },
      });
      if (registro.id === undefined) {
        return null;
      } else {
        setCookie("jp_net_time", 60);
        setCookie("jp_net_user", registro.id);
        setUser(registro.Nombre);
        setTimeSection(60);
        <Route path="/dashboard"/>

      }
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <section>
      <div class="signup">
        <div class="signup-connect"></div>
        <div class="signup-classic">
          <h3>JP NET</h3>
          <h2>Iniciar Sesión</h2>
          <form class="form" onSubmit={handleFinish}>
            <input
              class="username"
              type="text"
              placeholder="Nombre de usuario"
              required
            />
            <input

              class="username"
              type="password"
              placeholder="Contraseña"
              required
            />

            <button type="submit" class="btn">
              Ingresar
            </button>
          </form>
        </div>
      </div>
    </section>
  );
}

export { LoginForm };
