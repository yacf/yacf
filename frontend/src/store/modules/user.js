import { api } from "@/utils/api";

const state = {
  key: { code: -1, errors: [], loading: false },
  createadmin: { code: -1, errors: [], loading: false },
  user: "",
  auth: false
};

const getters = {
  key: state => {
    return state.key;
  },
  get_admin: state => {
    return state.createadmin;
  },
  get_admin_code: state => {
    return state.createadmin.code;
  },
  auth: state => {
    return state.auth;
  },
  user: state => {
    return state.user;
  },
  isAdmin: state => {
    return state.user.isSuperuser ? true : false;
  },
  username: state => {
    return state.user.username;
  },
  displayname: state => {
    return state.user.firstName + " " + state.user.lastName;
  },
  initials: state => {
    if (state.user.firstName && state.user.lastName) {
      return state.user.firstName.charAt(0) + state.user.lastName.charAt(0);
    } else {
      return null;
    }
  },
  userteam: state => {
    if (state.user.profile) {
      return state.user.profile.team ? state.user.profile.team.name : null;
    } else {
      return null;
    }
  }
};

const actions = {
  FETCH_VALIDATE_KEY({ commit }, payload) {
    commit("SET_KEY_RESET");
    api(`mutation { validateregisterkey(key:"${payload.key}"){ code } }`)
      .then(response => {
        if (response.errors) {
          commit("SET_KEY_ERROR", response.errors);
        } else {
          commit("SET_KEY_CODE", response.data.validateregisterkey.code);
        }
      })
      .catch(error => {
        commit("SET_KEY_ERROR", error.response.data.errors);
      });
  },
  CREATE_ADMIN({ commit }, payload) {
    commit("SET_CREATE_ADMIN_RESET");
    commit("SET_CREATE_ADMIN_LOADING", true);
    api(
      `mutation { createadmin(key:"${payload.key}", firstname:"${payload.firstname}", lastname:"${payload.lastname}", username:"${payload.username}", password:"${payload.password}"){ code } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CREATE_ADMIN_ERROR", response.errors);
        } else {
          commit("SET_CREATE_ADMIN_CODE", response.data.createadmin.code);
        }
      })
      .catch(error => {
        commit("SET_CREATE_ADMIN_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CREATE_ADMIN_LOADING", false);
      });
  },

  logout({ commit }) {
    api("mutation { logout{ status } }").then(response => {
      console.log(response.data.logout);
      commit("DESTROY_USER");
    });
  },

  loadUser({ commit }) {
    api(
      "query { me{ id, username, firstName, lastName, profile{ team { id name } } } }"
    ).then(response => {
      console.log(response.data.me);
    });
  }
};

const mutations = {
  SET_CREATE_ADMIN_RESET(state) {
    state.key = { code: -1, errors: [], loading: false };
  },
  SET_CREATE_ADMIN_LOADING(state, payload) {
    state.createadmin.loading = payload;
  },
  SET_CREATE_ADMIN_ERROR(state, payload) {
    state.createadmin.errors = payload;
  },
  SET_CREATE_ADMIN_CODE(state, payload) {
    state.createadmin.code = payload;
  },
  SET_KEY_RESET(state) {
    state.key = { code: -1, errors: [], loading: false };
  },
  SET_KEY_ERROR(state, payload) {
    state.key.errors = payload;
  },
  SET_KEY_CODE(state, payload) {
    state.key.code = payload;
  },
  SET_USER(state, user) {
    state.user = user;
    state.auth = true;
    localStorage.user = JSON.stringify(user);
    localStorage.auth = true;
  },
  DESTROY_USER(state) {
    state.user = "";
    state.auth = false;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
