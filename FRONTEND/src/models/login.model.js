import * as yup from "yup";
import { EMPTY } from "./errors/es";

export const loginFields = {
    username: "email",
    password: "password",
  };

  const LoginModel = yup.object().shape({
    [loginFields.username]: yup.string().required(EMPTY.USERNAME),
    [loginFields.password]: yup.string().required(EMPTY.PASSWORD),
  });
  
  export default LoginModel;