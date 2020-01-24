<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', href: '#' }]"></b-breadcrumb>

    <div v-if="teams.loading">Loading</div>
    <div v-else>
      <div class="newOpt">
        <button class="btn btn-secondary" @click="$router.push({ name: 'AdminTeamsCreate'});">New Team</button>
      </div>

      <b-card header="Teams" header-tag="header">
        <table id="adminteams" class="table table-sm table-hover">
          <thead>
            <tr>
              <th>Team</th>
              <th>Affiliation</th>
              <th>Website</th>
              <th>Admin Email</th>
              <th>Member Count</th>
              <th>Points</th>
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="team in teams.data" v-bind:key="team.id">
              <td>{{team.name}}</td>
              <td>{{team.affiliation}}</td>
              <td>{{team.website}}</td>
              <td>{{team.email}}</td>
              <td>{{team.players.length}}</td>
              <td>{{team.points}}</td>
              <td>
                <div>
                  <RemoveTeam :team="team" />
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminTeamEdit', params: { name: team.name } }">Edit</router-link>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </b-card>
    </div>
  </div>
</template>


<script>
import { mapGetters } from "vuex";
import RemoveTeam from "@/components/admin/remove/team.vue";

export default {
  name: "AdminTeam",
  components: {
    RemoveTeam
  },
  methods: {
    _child_Remove(value) {
      console.log("here", value);
    }
  },
  computed: {
    ...mapGetters({
      teams: "teams/GET_TEAMS"
    })
  },
  beforeMount() {
    this.$store.dispatch("teams/FETCH_ADMIN_TEAMS");
  }
};
</script>