<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Users', to: { name: 'AdminUsers' } },{ text: 'View', href: '#' }]"></b-breadcrumb>
    <template v-if="this.$apollo.queries.user.loading">Loading...</template>
    <template v-else>
      <b-card header="User">
          <label>Username:</label>
          <input class="form-control" v-model="user.username" disabled/>
          <label>First Name:</label>
          <input class="form-control" v-model="user.firstName" disabled/>
          <label>Last Name:</label>
          <input class="form-control" v-model="user.lastName" disabled/>
          <label>Email:</label>
          <input class="form-control" v-model="user.email" disabled/>
          <hr>
          <label>Team:</label>
          <template v-if="user.profile.team">
          <input class="form-control" v-model="user.profile.team.name" disabled/>
          <label>Team Affiliation:</label>
          <input class="form-control" v-model="user.profile.team.affiliation" disabled/>
          </template>
          <template v-else>
            No team
          </template>
          <hr>
          <label>Date Joined:</label>
          <input class="form-control" v-model="user.dateJoined" disabled/>
          <label>Last Login:</label>
          <input class="form-control" v-model="user.lastLogin" disabled/>
          <hr>
          <b-form-checkbox v-model="user.isActive" :value="false" :unchecked-value="true" disabled> Disabled </b-form-checkbox>
      </b-card>
    </template>
    <hr>
  </div>
</template>

<script>
import { userQuery } from "@/api/queries/users";

export default {
  name: "AdminUserView",
  data() {
    return {
    };
  },
  apollo: {
    user: {
      query: userQuery('id username firstName lastName email profile { id verified team { id name affiliation } } isActive dateJoined lastLogin'),
      variables() {
        return {
          id: this.$route.query.id
        };
      },
    }
  },
  // beforeCreate() {
  //   if (this.$route.query.id === undefined) this.$router.push({ name: "AdminUsers" });
  // }
};
</script>

<style scoped>
</style>