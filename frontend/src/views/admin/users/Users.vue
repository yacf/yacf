<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Users', href: '#' }]"></b-breadcrumb>
    <b-row>
      <b-col md="3">
        <b-input-group prepend="Search">
          <b-form-input v-model="search"></b-form-input>
          <b-input-group-append>
            <b-button><b-icon icon="arrow-right"></b-icon></b-button>
          </b-input-group-append>
        </b-input-group>
      </b-col>
      <b-col md="9">
        <pagination :count="users.totalCount" @clicked="emitevent" />
      </b-col>
    </b-row>

      <div style="text-align: right;" v-if="!this.$apollo.queries.users.loading">
        Viewing: {{(this.page.id - 1) * this.rows + 1}}-{{(this.page.id - 1) * this.rows + this.rows}} of {{users.totalCount}}
      </div>

    <template v-if="this.$apollo.queries.users.loading">Loading...</template>
    <template v-else>
      <b-card header="Users" header-tag="header">
        <table id="adminteams" class="table table-sm table-hover">
          <thead>
            <tr>
              <th>Username</th>
              <th>Firstname</th>
              <th>Lastname</th>
              <th>Email</th>
              <th>Team</th>
              <th>Privilege</th>
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="user in users.edges" v-bind:key="user.id">
              <td>{{user.node.id}}-{{user.node.username}}</td>
              <td>{{user.node.firstName}}</td>
              <td>{{user.node.lastName}}</td>
              <td>{{user.node.email}}</td>
              <td v-if="user.node.profile.team">{{user.node.profile.team.name}}</td>
              <td v-else>
                <b-badge variant="warning">No Team</b-badge>
              </td>
              <td>
                <b-badge v-if="user.isSuperuser" variant="danger">Superuser</b-badge>
              </td>
              <td>
                <div>
                  <!-- <RemoveTeam :team="team"/> -->
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminUserView', query: { id: user.id } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
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
import { usersQuery, userCountQuery } from "@/api/queries/users";

export default {
  name: "AdminUsers",
  components: { Pagination },
  data() {
    return {
      users: {
        totalCount: null
      },
      page: {
        id: 1,
        cursor: null
      },
      rows: 15,
      search: null
    };
  },
  apollo: {
    users: {
      query: usersQuery('totalCount edges { node { id username firstName lastName email isSuperuser profile { team { name } } } }'),
      variables() {
        return {
          first: this.rows,
          after: this.page.cursor,
          search: this.search
        };
      },
    }
  },
  methods: {
    emitevent(value) {
      if ("page" in value) {
        console.log(value)
        this.page.id = value.page;
        console.log((value.page-1)*this.rows)
        this.page.cursor = btoa(`arrayconnection:${(value.page-1)*this.rows-1}`);
      } else if ("rows" in value) {
        this.rows = value.rows;
      }
    },
  }
};
</script>