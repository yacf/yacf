<template>
  <div style="padding:20px">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', to: { name: 'AdminTeams' } },{ text: 'View', href: '#' }]"></b-breadcrumb>
    <template v-if="this.$apollo.queries.teamName.loading">Loading...</template>
    <template v-else>
      <b-card header="Team">
        <b-row>
          <b-col md="6">
            <label>Team Name</label>
            <input class="form-control" v-model="teamName.name" disabled/>
            <label>Affiliation</label>
            <input class="form-control" v-model="teamName.affiliation" disabled/>
            <label>Admin Email</label>
            <input class="form-control" v-model="teamName.email" disabled/>
            <label>Website</label>
            <input class="form-control" v-model="teamName.website" disabled/>
            <label>Access Code</label>
            <input class="form-control" v-model="teamName.accesscode.value" disabled/>
          </b-col>
          <b-col md="6">
            <img :src="'/server/'+teamName.picture">
          </b-col>
        </b-row>

        <div v-if="teamName">

          <hr />
          <!-- <button class="btn btn-secondary" @click="update()">Update Team</button> -->
        </div>
        <div v-else>Redirect.. You cannot access this page directly</div>
      </b-card>
      <hr>
      <b-card header="Members">
        <table id="teammembers" class="table table-sm table-hover">
          <thead>
            <tr>
              <th>Username</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Email</th>
              <th>Last Login</th>
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="player in teamName.players" v-bind:key="player.id">
              <td>{{player.user.username}}</td>
              <td>{{player.user.firstName}}</td>
              <td>{{player.user.lastName}}</td>
              <td>{{player.user.email}}</td>
              <td v-if="player.user.lastLogin">{{player.user.lastLogin | moment("MMMM Do YYYY, h:mm:ss a")}}</td>
              <td v-else>Never</td>
              <td>
                <div>
                  <!-- <RemoveTeam :team="team" /> -->
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminUserView', query: { id: player.user.id } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </b-card>
    </template>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { teamNameQuery } from "@/api/queries/teams";


export default {
  name: "Team",
  data() {
    return {
      teamName: ""
    }
  },
  apollo: {
    teamName: {
      query: teamNameQuery('id name affiliation website picture accesscode { value } players { id user { id username firstName lastName email lastLogin } } '),
      variables() {
        return {
          name: this.$route.query.name
        };
      },
    }
  },
  // methods: {
  //   update() {
  //     if (this.team.data.name && this.team.data.email) {
  //       this.$store.dispatch("teams/UPDATE_TEAM", {
  //         name: this.team.data.name
  //       });
  //     } else {
  //       this.message = "Required feilds missing.";
  //     }
  //   }
  // }
};
</script>