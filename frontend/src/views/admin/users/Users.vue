<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Users', href: '#' }]"></b-breadcrumb>

    <template v-if="this.$apollo.queries.users.loading">Loading...</template>
    <template v-else>
      {{search}}
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
          <pagination :count="userCount" @clicked="emitevent" />
        </b-col>
      </b-row>
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
            <tr v-for="user in users" v-bind:key="user.id">
              <td>{{user.username}}</td>
              <td>{{user.firstName}}</td>
              <td>{{user.lastName}}</td>
              <td>{{user.email}}</td>
              <td v-if="user.profile.team">{{user.profile.team.name}}</td>
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
      page: 1,
      rows: 15,
      search: null
    };
  },
  apollo: {
    users: {
      query: usersQuery('id username firstName lastName email isSuperuser profile { team { name } }'),
      variables() {
        return {
          skip: (this.page - 1) * this.rows,
          first: this.rows,
          // search: this.search
        };
      },
    },
    userCount: {
      query: userCountQuery()
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