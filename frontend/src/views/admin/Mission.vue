<template>
  <div class="offset">
    <b-card-group deck>
      <b-card title="Teams">
        <h1>{{teams}}</h1>
      </b-card>
      <b-card title="Users">
        <h1>{{users}}</h1>
      </b-card>
      <b-card title="Challenges">
        <h1>{{challenges}}</h1>
      </b-card>
      <b-card title="Solves">
        <h1>{{solveslen}}</h1>
      </b-card>
    </b-card-group>

    <hr />
    <b-card header="Progress Graph">
      <Graph />
    </b-card>
    <hr />
    <b-card-group deck>
      <b-card header="Last 10 Solves">
        <b-alert variant="success" v-for="solve in solves" :key="solve.id" show>
          ({{solve.id}}) {{solve.team.name}} - {{solve.challenge.name}}
          <span style="text-align: right; float: right">{{solve.timestamp | moment("MMMM Do YYYY, h:mm:ss a") }}</span>
        </b-alert>
      </b-card>
      <b-card header="Last 10 Failures">
        <b-alert variant="danger" v-for="failure in failures" :key="failure.id" show>
          ({{failure.id}}) {{failure.team.name}} - {{failure.challenge.name}}
          <span style="text-align: right; float: right">{{failure.timestamp | moment("MMMM Do YYYY, h:mm:ss a") }}</span>
        </b-alert>
      </b-card>
    </b-card-group>
  </div>
</template>


<script>
import { api } from "@/utils/api";

export default {
  name: "MissionControl",
  components: {
    Graph: () => import("@/components/scoreboard/Graph")
  },
  data() {
    return {
      challenges: 0,
      teams: 0,
      users: 0,
      solves: 0,
      solveslen: 0,
      failures: []
    };
  },
  created() {
    let self = this;
    api("query { challenges{ id } }").then(response => {
      self.challenges = response.data.challenges.length;
    });
    api("query { teams(hidden:false){ id } }").then(response => {
      self.teams = response.data.teams.length;
    });
    api("query { userCount }").then(response => {
      self.users = response.data.userCount;
    });
    api(
      "query { solves { id } }"
    ).then(response => {
      self.solveslen = response.data.solves.length;
    });
    api(
      "query { solves(first:10, skip:0) { id team { name } challenge { name } timestamp } }"
    ).then(response => {
      self.solves = response.data.solves;
    });
    api(
      "query { failures(first:10, skip:0) { id team { name } challenge { name } timestamp } }"
    ).then(response => {
      self.failures = response.data.failures;
    });
  },
  methods: {}
};
</script>

<style scoped>
</style>