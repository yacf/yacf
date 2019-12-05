import { api } from "@/utils/api";

const state = {
  categories: { data: [], errors: [], loading: false },
  create: { code: -1, errors: [], loading: false },
  update: { code: -1, errors: [], loading: false }
};

const getters = {
  GET_CATEGORIES: state => {
    return state.categories;
  },
  GET_CREATE: state => {
    return state.create;
  },
  GET_UPDATE: state => {
    return state.update;
  }
};

const actions = {
  FETCH_CATEGORIES({ commit }) {
    commit("SET_CATEGORIES_LOADING", true);
    api("query{ categories {id, name, description, challenges { id } } }")
      .then(response => {
        if (response.errors) {
          commit("SET_CATEGORIES_ERROR", response.errors);
        } else {
          commit("SET_CATEGORIES", response.data.categories);
        }
      })
      .catch(error => {
        commit("SET_CATEGORIES_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CATEGORIES_LOADING", false);
      });
  },
  CREATE_CATEGORY({ commit }, payload) {
    commit("SET_CREATE_LOADING", true);
    api(
      `mutation{ addcategory(name:"${payload.name}",description:"${payload.description}") { code } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_CREATE_ERROR", response.errors);
        } else {
          commit("SET_CREATE_CODE", response.data.addcategory.code);
        }
      })
      .catch(error => {
        commit("SET_CREATE_ERROR", error.response.data.errors);
      })
      .finally(function() {
        commit("SET_CREATE_LOADING", false);
      });
  },
  UPDATE_CATEGORY({ commit }, payload) {
    console.log(payload);
    api(
      `mutation { updateCategory(id:${payload.id}, name:"${payload.name}", description:"${payload.description}"){ code } }`
    )
      .then(response => {
        if (response.errors) {
          commit("SET_UPDATE_ERROR", response.errors);
        } else {
          commit("SET_UPDATE_CODE", response.data.updateCategory.code);
        }
      })
      .catch(error => {
        commit("SET_UPDATE_ERROR", error.response.data.errors);
      });
  }
};

const mutations = {
  SET_CATEGORIES_ERROR(state, payload) {
    state.categories.errors = payload;
  },
  SET_CATEGORIES(state, payload) {
    state.categories.data = payload;
  },
  SET_CATEGORIES_LOADING(state, payload) {
    state.categories.loading = payload;
  },
  /*
    ----- Categories CREATE --------
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
    ---- End Categories CREATE -----
  */
  /*
    ----- Categories UPDATE --------
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
  }
  /*
    ---- End Categories UPDATE -----
  */
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
