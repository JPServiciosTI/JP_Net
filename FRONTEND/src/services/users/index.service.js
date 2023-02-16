import { del, get, post, put } from "../api/api.service";

export const createUser = async ({ data }) => {
    try {
      const res = await post({
        url: "/usuario/register",
        data,
      });
      if (res?.status === "ERROR") throw res;
      return res;
    } catch (error) {
      throw error;
    }
  };


  export const getUsers = async () => {
    try {
      const res = await get({
        url: "usuario",
      });
      if (res?.status === "ERROR") throw res;
      res.forEach((user, i) => (user.id = i));
      return res;
    } catch (error) {
      throw error;
    }
  };


  export const updateUser = async ({ data }) => {
    try {
      const res = await put({
        url: "usuario/password",
        data,
      });
  
      if (res?.status === "ERROR") throw res;
      return res;
    } catch (error) {
      throw error;
    }
  };


  export const deleteUser = async ({ data }) => {
    try {
      const res = await del({
        url: `usuario/delete`,
        data,
      });
  
      if (res?.status === "ERROR") throw res;
      return res;
    } catch (error) {
      throw error;
}};