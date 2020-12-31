<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', href: '#' }]"></b-breadcrumb>

    <div v-if="teams.loading">Loading</div>
    <div v-else>
      <b-row>
        <b-col md="6">
          <div>
          <b-button style="margin-right:5px;" @click="$router.push({ name: 'AdminTeamsCreate'});">New Team</b-button>
          <!-- <b-button @click="showSearch = !showSearch">Search</b-button> -->
          </div>

        </b-col>
        <b-col md="6">
          <pagination :count="teamCount" @clicked="emitevent" />
        </b-col>
      </b-row>

      <div v-if="showSearch">
        <b-input-group>
          <b-form-input></b-form-input>
          <b-input-group-append>
            <b-button>Search</b-button>
          </b-input-group-append>
        </b-input-group>
        <hr>
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
            <tr v-for="team in teams" v-bind:key="team.id">
              <td>{{team.name}}</td>
              <td>{{team.affiliation}}</td>
              <td>{{team.website}}</td>
              <td>{{team.email}}</td>
              <td>{{team.players.length}}</td>
              <td>{{team.points}}</td>
              <td>
                <div>
                  <!-- <RemoveTeam :team="team" /> -->
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminTeamView', query: { name: team.name } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
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
import Pagination from "@/components/general/pagination";
import { teamsQuery, teamsCountQuery } from "@/api/queries/teams";

export default {
  name: "AdminTeam",
  components: {
    Pagination,
  },
  data() {
    return {
      teams: [],
      teamCount: 0,
      page: 1,
      rows: 15,
      showSearch: false,
    }
  },
  apollo: {
    teams: {
      query: teamsQuery('id, name, affiliation, website, points, players { id }'),
      variables() {
        return {
          skip: (this.page - 1) * this.rows,
          first: this.rows,
        };
      },
    },
    teamCount: {
      query: teamsCountQuery()
    }
  },
  methods: {
    emitevent(value) {
      if ("page" in value) {
        this.page = value.page;
      } else if ("rows" in value) {
        this.rows = value.rows;
      }
    },
  }
};
</script>