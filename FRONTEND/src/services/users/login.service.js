import { del, get, post, put } from "../api/api.service";


export const autenticar = async () => {
    try {
      const res = await post({
        url: "user/login",
        data
      });
      if (res?.status === "ERROR") throw res;
      return res;
    } catch (error) {
      throw error;
    }
  };