<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Logs', href: '#' }]"></b-breadcrumb>

    <div v-if="loginLogs.loading">Loading</div>
    <div v-else>
      <b-card header="Logs" header-tag="header">
        <b-tabs content-class="mt-3">
          <b-tab title="User Login" active>
            <table id="adminteams" class="table table-sm table-hover">
              <thead>
                <tr>
                  <th>Username</th>
                  <th>Time</th>
                  <th>IP Adddress</th>
                  <th>Agent</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="login in loginLogs.data" v-bind:key="login.id">
                  <td>{{login.user.username}}</td>
                  <td>{{login.time | moment("MM/DD/YYYY, h:mm:ss a") }}</td>
                  <td>{{login.address}}</td>
                  <td>{{login.agent}}</td>
                </tr>
              </tbody>
            </table>
          </b-tab>
          <b-tab title="Other">Coming soon</b-tab>
        </b-tabs>
      </b-card>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "AdminLogs",
  computed: {
    ...mapGetters({
      loginLogs: "logs/GET_LOGIN_LOGS"
    })
  },
  beforeMount() {
    this.$store.dispatch("logs/GET_LOGIN_LOGS");
  }
};
</script>