<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Teams', href: '#' }]"></b-breadcrumb>
    <b-row>
      <b-col md="3">
        <div>
          <b-input-group prepend="Search">
            <b-form-input v-model="search"></b-form-input>
          </b-input-group>
        </div>
      </b-col>
      <b-col md="9">
        <pagination :count="teams.totalCount" @clicked="emitevent" />
      </b-col>
    </b-row>

    <div style="text-align: right;" v-if="!this.$apollo.queries.teams.loading">
      Viewing: {{pageview}}
    </div>

    <template v-if="this.$apollo.queries.teams.loading">Loading...</template>
    <template v-else>
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
            <tr v-for="team in teams.edges" v-bind:key="team.id">
              <td>{{team.node.name}}</td>
              <td>{{team.node.affiliation}}</td>
              <td>{{team.node.website}}</td>
              <td>{{team.node.email}}</td>
              <td>{{team.node.players.length}}</td>
              <td>{{team.node.points}}</td>
              <td>
                <div>
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminTeamView', query: { name: team.node.name } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
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
import Pagination from "@/components/general/pagination";
import { teamsQuery, teamsCountQuery } from "@/api/queries/teams";

export default {
  name: "AdminTeam",
  components: {
    Pagination,
  },
  data() {
    return {
      page: 1,
      rows: 15,
      search: null,
      teams: {
        totalCount: null
      },
      page: {
        id: 1,
        cursor: null
      },
    }
  },
  apollo: {
    teams: {
      query: teamsQuery('totalCount edges { node { id, name, affiliation, website, points, players { id } } }'),
      variables() {
        return {
          first: this.rows,
          after: this.page.cursor,
          search: this.search
        };
      },
    }
  },
  computed: {
    pageview: function () {
     let lower = (this.page.id - 1) * this.rows + 1;
     let upper =  (this.page.id - 1) * this.rows + this.rows;
     if (upper > this.teams.totalCount) upper = this.teams.totalCount;
     return `${lower}-${upper} of ${this.teams.totalCount}`
    }
  },
  methods: {
    emitevent(value) {
      if ("page" in value) {
        this.page.id = value.page;
        this.page.cursor = btoa(`arrayconnection:${(value.page-1)*this.rows-1}`);
      } else if ("rows" in value) {
        this.rows = value.rows;
      }
    },
  }
};
</script>