import { api } from "@/utils/api";

const state = {
  login: { data: [], errors: [], loading: false }
};

const getters = {
  GET_LOGIN_LOGS: state => {
    return state.login;
  }
};

const actions = {
  GET_LOGIN_LOGS({ commit }) {
    commit("SET_LOGIN_LOGS_LOADING", true);
    api("query { loginTracker{ user { username } id time address agent } }")
      .then(response => {
        if (response.errors) {
          commit("SET_LOGIN_LOGS_ERROR", response.errors);
        } else {
          commit("SET_LOGIN_LOGS", response.data.loginTracker);
        }
      })
      .catch(error => {
        commit("SET_LOGIN_LOGS_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_LOGIN_LOGS_LOADING", false);
      });
  }
};

const mutations = {
  SET_LOGIN_LOGS(state, payload) {
    state.login.data = payload;
  },
  SET_LOGIN_LOGS_ERROR(state, payload) {
    state.login.errors = payload;
  },
  SET_LOGIN_LOGS_LOADING(state, payload) {
    state.login.loading = payload;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
