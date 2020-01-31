import { api } from "@/utils/api";

const state = {
  login: { data: [], errors: [], loading: false },
  submit: { data: [], errors: [], loading: false }
};

const getters = {
  GET_LOGIN_LOGS: state => {
    return state.login;
  },
  GET_SUBMIT_LOGS: state => {
    return state.submit;
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
  },
  // // query { flagTracker{ id time solve { challenge { category { name } name } user{ username } } address agent } }
  GET_SUBMIT_LOGS({ commit }) {
    commit("SET_SUBMIT_LOGS_LOADING", true);
    api("query { flagTracker{ id time solve { challenge { category { name } name } user{ username } } address agent } }")
      .then(response => {
        if (response.errors) {
          commit("SET_SUBMIT_LOGS_ERROR", response.errors);
        } else {
          commit("SET_SUBMIT_LOGS", response.data.flagTracker);
        }
      })
      .catch(error => {
        commit("SET_SUBMIT_LOGS_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_SUBMIT_LOGS_LOADING", false);
      });
  },
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
  },
  ////////////
  SET_SUBMIT_LOGS(state, payload) {
    state.submit.data = payload;
  },
  SET_SUBMIT_LOGS_ERROR(state, payload) {
    state.submit.errors = payload;
  },
  SET_SUBMIT_LOGS_LOADING(state, payload) {
    state.submit.loading = payload;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
