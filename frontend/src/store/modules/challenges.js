import { api } from "@/utils/api";

const state = {
  board: { data: [], errors: [], loading: false },
  challenges: { data: [], errors: [], loading: false },
  challenge: { data: [], errors: [], loading: false },
  create: { code: -1, errors: [], loading: false },
  update: { code: -1, errors: [], loading: false }
};

const getters = {
  GET_BOARD: state => {
    return state.board;
  },
  GET_CHALLENGES: state => {
    return state.challenges;
  },
  GET_CHALLENGE: state => {
    return state.challenge;
  },
  GET_CREATE: state => {
    return state.create;
  },
  GET_UPDATE: state => {
    return state.update;
  }
};

const actions = {
  FETCH_BOARD({ commit }) {
    commit("SET_BOARD_LOADING", true);
    api("query{ challenges {id, name points category {name} hints {id} } }")
      .then(response => {
        if (response.errors) {
          commit("SET_BOARD_ERROR", response.errors);
        } else {
          commit("SET_BOARD", response.data.challenges);
        }
        // commit("SET_SOLVES", data.teamSovle);
      })
      .catch(error => {
        commit("SET_BOARD_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_BOARD_LOADING", false);
      });
  },
  FETCH_CHALLENGES({ commit }) {
    commit("SET_CHALLENGES_LOADING", true);
    api(
      "query { challenges{ id, name, points, hidden, hints { id } category { id, name } solvedchallengeSet { id } } }"
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CHALLENGES_ERROR", response.errors);
        } else {
          commit("SET_CHALLENGES", response.data.challenges);
        }
      })
      .catch(error => {
        commit("SET_CHALLENGES_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CHALLENGES_LOADING", false);
      });
  },
  FETCH_CHALLENGE({ commit }, id) {
    commit("SET_CHALLENGE_LOADING", true);
    api(
      `query{ challenge(id:${id}){ id name description encoded points hidden hints{ id description hidden } category{ id name } } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CHALLENGE_ERROR", response.errors);
        } else {
          commit("SET_CHALLENGE", response.data.challenge);
        }
      })
      .catch(error => {
        commit("SET_CHALLENGE_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CHALLENGE_LOADING", false);
      });
  },
  CREATE_CHALLENGE({ commit }, payload) {
    console.log("In store for create challenge");
    commit("SET_CREATE_LOADING", true);
    api(
      `mutation{ addChallenge(name:"${
        payload.name
      }", description:${JSON.stringify(payload.description)}, encoded:${
        payload.encode
      }, points:${payload.points}, flag:"${payload.flag}", algorithm:"${
        payload.algorithm
      }", precomputed:${payload.precomputed}, category:"${
        payload.category
      }", hidden:${payload.hidden}) { code } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CREATE_ERROR", response.errors);
        } else {
          commit("SET_CREATE_CODE", response.data.addChallenge.code);
        }
      })
      .catch(error => {
        commit("SET_CREATE_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CREATE_LOADING", false);
      });
  },
  POST_FLAG({ commit }, id, flag) {
    api(`mutation{ submitflag(challenge:${id}, flag:"${flag}"){ code } }`).then(
      response => {
        console.log(response.data.submitflag);
      }
    );
  }
};

const mutations = {
  ////////
  SET_BOARD_LOADING(state, payload) {
    state.board.loading = payload;
  },
  SET_BOARD_ERROR(state, payload) {
    state.board.errors = payload;
  },
  SET_BOARD(state, payload) {
    state.board.data = payload;
  },
  ////////
  SET_CHALLENGES_LOADING(state, payload) {
    state.challenges.loading = payload;
  },
  SET_CHALLENGES_ERROR(state, payload) {
    state.challenges.errors = payload;
  },
  SET_CHALLENGES(state, payload) {
    state.challenges.data = payload;
  },
  ////////
  SET_CHALLENGE_LOADING(state, payload) {
    state.challenge.loading = payload;
  },
  SET_CHALLENGE_ERROR(state, payload) {
    state.challenge.errors = payload;
  },
  SET_CHALLENGE(state, payload) {
    state.challenge.data = payload;
  },
  SET_CHALLENGE_DEFAULT(state, payload) {
    state.challenge = { code: -1, errors: [], loading: false };
  },
  ////////
  SET_CREATE_DEFAULT(state) {
    state.create = { code: -1, errors: [], loading: false };
  },
  SET_CREATE_CODE(state, payload) {
    state.create.code = payload;
  },
  SET_CREATE_ERROR(state, payload) {
    state.create.errors = payload;
  },
  SET_CREATE_LOADING(state, payload) {
    state.create.loading = payload;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
