import { api } from "@/utils/api";

/*
    Teams: Used for all teams for name, points, flag stats
    Team : Used for deeper analytics for the statistic page.
*/
const state = {
  teams: { data: [], errors: [], loading: false },
  team: { data: [], errors: [], loading: false },
  create: { code: -1, errors: [], loading: false },
  update: { code: -1, errors: [], loading: false },
  solves: [],
  rank: [],
  max: 0
};

const getters = {
  GET_TEAMS: state => {
    return state.teams;
  },
  GET_TEAM: state => {
    return state.team;
  },
  GET_CREATE: state => {
    return state.create;
  },
  ranks: state => {
    return state.teams.data.sort(function(a, b) {
      return b.points - a.points;
    });
  },
  GET_TEAM_RANK: state => {
    return state.rank;
  },
  GET_TEAM_SOLVE: state => {
    return state.team.solved;
  },
  GET_MAX_POINTS: state => {
    return state.max;
  },
  GET_SOLVES: state => {
    return state.solves;
  }
};

const actions = {
  FETCH_TEAMS({ commit }) {
    commit("SET_TEAMS_LOADING", true);
    api(
      `query{ teams(hidden:false) {id, name, affiliation, website, points, correctFlags, wrongFlags} totalPoints }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_TEAMS_ERROR", response.errors);
        } else {
          commit("SET_TEAMS", response.data.teams);
          commit("SET_MAX_POINTS", response.data.totalPoints);
        }
      })
      .catch(error => {
        commit("SET_TEAMS_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_TEAMS_LOADING", false);
      });
  },
  FETCH_ADMIN_TEAMS({ commit }) {
    commit("SET_TEAMS_LOADING", true);
    api(
      `query{ teams {id, name, affiliation, website, points, players { id } } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_TEAMS_ERROR", response.errors);
        } else {
          commit("SET_TEAMS", response.data.teams);
        }
      })
      .catch(error => {
        commit("SET_TEAMS_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_TEAMS_LOADING", false);
      });
  },
  FETCH_TEAM({ commit }, payload) {
    commit("SET_TEAM_LOADING", true);
    api(
      `query{ teamName(name:"${payload.name}") {id, name, affiliation, website, points, correctFlags, wrongFlags accesscode { value } } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_TEAM_ERROR", response.errors);
        } else {
          commit("SET_TEAM", response.data.teamName);
        }
      })
      .catch(error => {
        commit("SET_TEAM_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_TEAM_LOADING", false);
      });
  },
  FETCH_SOLVES({ commit }) {
    api("query { teamSovle{ challenge{ id } } }").then(response => {
      let ids = [];
      response.data.teamSovle.forEach(element =>
        ids.push(element.challenge.id)
      );
      commit("SET_SOLVES", ids);
    });
  },
  CREATE_TEAM({ commit }, payload) {
    commit("SET_CREATE_LOADING", true);
    api(
      `mutation { addteam(name:"${payload.name}", affiliation:"${payload.affiliation}", email:"${payload.email}", accesscode:"${payload.code}"){ code } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CREATE_ERROR", response.errors);
        } else {
          commit("SET_CREATE_CODE", response.data.addteam.code);
        }
      })
      .catch(error => {
        commit("SET_CREATE_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CREATE_LOADING", false);
      });
  },
  //////////////////
  UPDATE_TEAM({ commit }, payload) {
    console.log(payload);
    // commit("SET_UPDATE_LOADING", true);
    // api(
    //   `mutation { updateteam(id:${payload.id}, name:"${payload.name}", affiliation:"${payload.affiliation}", email:"${payload.email}", website:"${payload.website}", accesscode:"${payload.accesscode}"){ code } }`
    // )
    //   .then(response => {
    //     if (response.errors) {
    //       commit("SET_UPDATE_ERROR", response.errors);
    //     } else {
    //       commit("SET_UPDATE_CODE", response.data.updateteam.code);
    //     }
    //   })
    //   .catch(error => {
    //     commit("SET_UPDATE_ERROR", error.response.data.errors);
    //   })
    //   .finally(function() {
    //     commit("SET_UPDATE_LOADING", false);
    //   });
  },

  //////////////////
  LoadTeamRank({ commit }) {
    api(
      "query{ team {id, name, points, correctFlags, wrongFlags } totalPoints }"
    ).then(response => {
      commit("SET_TEAM_RANK", response.data.team);
      commit("SET_MAX_POINTS", response.data.totalPoints);
    });
  },

  searchTeams({ commit }, payload) {
    api(
      `query{ searchteam(query:"${payload}") { id, name, affiliation, website, points, correctFlags, wrongFlags} }`
    ).then(response => {
      commit("SET_TEAMS", response.data.searchteam);
      commit("SET_MAX_POINTS", response.data.totalPoints);
    });
  },
  loadStats({ commit }, payload) {
    api(
      `query{ teamName(name:"${payload}"){ id, name, points, players { user { username firstName solves { challenge { points } } } }, solved{ id, timestamp, challenge { id, name, points, category{ name } } } } }`
    ).then(response => {
      commit("SET_TEAM", response.data.teamName);
    });
  }
};

const mutations = {
  SET_TEAMS(state, payload) {
    state.teams.data = payload;
  },
  SET_TEAMS_ERROR(state, payload) {
    state.teams.errors = payload;
  },
  SET_TEAMS_LOADING(state, payload) {
    state.teams.loading = payload;
  },
  SET_TEAM(state, payload) {
    state.team.data = payload;
  },
  SET_TEAM_DEFAULT(state) {
    state.team = { data: [], errors: [], loading: false };
  },
  SET_TEAM_ERROR(state, payload) {
    state.team.errors = payload;
  },
  SET_TEAM_LOADING(state, payload) {
    state.team.loading = payload;
  },
  ////
  /*
    ----- TEAM CREATE --------
  */
  SET_CREATE_DEFAULT(state) {
    state.create = { code: -1, errors: [], loading: false };
  },
  SET_CREATE_ERROR(state, payload) {
    state.create.errors = payload;
  },
  SET_CREATE_CODE(state, payload) {
    state.create.code = payload;
  },
  SET_CREATE_LOADING(state, payload) {
    state.create.loading = payload;
  },
  /*
  ---- End TEAM CREATE -----
*/
  /*
  ----- TEAM UPDATE --------
*/
  SET_UPDATE_DEFAULT(state) {
    state.update = { code: -1, errors: [], loading: false };
  },
  SET_UPDATE_ERROR(state, payload) {
    state.update.errors = payload;
  },
  SET_UPDATE_CODE(state, payload) {
    state.update.code = payload;
  },
  SET_UPDATE_LOADING(state, payload) {
    state.update.loading = payload;
  },
  /*
  ---- End TEAM UPDATE -----
*/
  SET_TEAM_RANK(state, team) {
    state.rank = team;
  },
  SET_MAX_POINTS(state, points) {
    state.max = points;
  },
  SET_SOLVES(state, payload) {
    state.solves = payload;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
