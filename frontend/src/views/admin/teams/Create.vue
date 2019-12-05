<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', to: { name: 'AdminTeams' } },{ text: 'Create', href: '#' }]"></b-breadcrumb>

    <b-card header="Create Team">
      <b-alert v-for="(error, index) in create.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
      <b-alert v-if="create.code === 0" show variant="success">Team Created</b-alert>

      <label>Team name:</label>
      <input class="form-control" v-model="name" />
      <label>Affiliation:</label>
      <input class="form-control" v-model="affiliation" />
      <label>Primary Email:</label>
      <input class="form-control" v-model="email" />
      <label>Access Code:</label>
      <input class="form-control" v-model="code" />
      <b-form-text>A random access code will be generated if not defined.</b-form-text>
      <p>{{message}}</p>
      <hr />
      <button class="btn btn-secondary" @click="addTeam()">Create</button>
    </b-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "AddTeam",
  data() {
    return {
      name: "",
      affiliation: "",
      email: "",
      code: "",
      message: ""
    };
  },
  computed: {
    ...mapGetters({
      create: "teams/GET_CREATE"
    })
  },
  beforeMount() {
    this.$store.commit("teams/SET_CREATE_DEFAULT");
  },
  methods: {
    addTeam() {
      if (this.name && this.email) {
        this.$store.dispatch("teams/CREATE_TEAM", {
          name: this.name,
          affiliation: this.affiliation,
          email: this.email,
          code: this.code
        });
      } else {
        this.message = "Required feilds missing.";
      }
    }
  }
};
</script>

<style scoped>
</style>