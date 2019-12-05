import { api } from "@/utils/api.js";
import store from "@/store/index";

export function base(to, from, next) {
  // Get Server settings
  // store.dispatch("theme/GET_THEME");
  next();
}

export function graud(to, from, next) {
  // store.dispatch("theme/GET_THEME");
  api(
    "query{ me { id, isSuperuser, username, firstName, lastName, profile{ team { name } } } }"
  ).then(response => {
    if (response.data.me !== null) {
      store.commit("user/SET_USER", response.data.me);
      next();
    } else {
      console.log("[ROUTE]: Authenication failed, going to login");
      next("/login");
    }
  });
}

export function superusergraud(to, from, next) {
  api(
    "query{ me { id, isSuperuser, username, firstName, lastName, profile{ team { name } } } }"
  ).then(response => {
    if (response.data.me !== null) {
      store.commit("user/SET_USER", response.data.me);
      response.data.me.isSuperuser ? next() : next("/");
      next();
    } else {
      console.log("[ROUTE]: Authenication failed, going to login");
      next("/login");
    }
  });
}
