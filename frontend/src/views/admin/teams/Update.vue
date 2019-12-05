<template>
  <div style="padding:20px">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', to: { name: 'AdminTeams' } },{ text: 'Upadate', href: '#' }]"></b-breadcrumb>
    <b-card header="Update Team">
      <div v-if="team.data">
        <label>Team Name</label>
        <input class="form-control" v-model="team.data.name" />
        <label>Affiliation</label>
        <input class="form-control" v-model="team.data.affiliation" />
        <label>Admin Email</label>
        <input class="form-control" v-model="team.data.email" />
        <label>Website</label>
        <input class="form-control" v-model="team.data.website" />
        <label>Access Code</label>
        <input class="form-control" v-model="team.data.accesscode.value" />
        <hr />
        <button class="btn btn-secondary" @click="update()">Update Team</button>
      </div>
      <div v-else>Redirect.. You cannot access this page directly</div>
    </b-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "Team",
  props: ["name"],
  computed: {
    ...mapGetters({
      team: "teams/GET_TEAM"
    })
  },
  beforeMount() {
    this.$store.commit("teams/SET_TEAM_DEFAULT");
    this.$store.dispatch("teams/FETCH_TEAM", { name: this.name });
  },
  methods: {
    update() {
      if (this.team.data.name && this.team.data.email) {
        this.$store.dispatch("teams/UPDATE_TEAM", {
          name: this.team.data.name
        });
      } else {
        this.message = "Required feilds missing.";
      }
    }
  }
};
</script>