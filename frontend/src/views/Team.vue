<template>
  <div style="padding: 15px;">
    <h3 style="padding-top: 10px;">{{this.$store.state.teams.team.name}}</h3>

    <b-container class="bv-example-row">
      <graph :name="this.$route.params.name" />
      <hr />
      <b-row>
        <b-col>
          <table id="team" class="table table-hover">
            <thead>
              <tr>
                <!-- <th>Order</th> -->
                <th>Challenge</th>
                <th>Points</th>
                <th>Solved At</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="solve in team.data.solved" :key="solve.id" style="cursor: pointer;" @click="$router.push(`/challenge/${solve.challenge.category.name}/${solve.challenge.points}`);">
                <td>{{solve.challenge.name}}</td>
                <td>{{solve.challenge.points}}</td>
                <td>{{solve.timestamp | moment("dd, MM Do YYYY, h:mm:ss a") }}</td>
              </tr>
            </tbody>
          </table>
        </b-col>
        <b-col>
          <table id="team" class="table table-hover">
            <thead>
              <tr>
                <!-- <th>Order</th> -->
                <th>Handle</th>
                <th>Name</th>
                <th>Points</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="player in team.data.players" :key="player.id">
                <td>{{player.user.username}}</td>
                <td>{{player.user.firstName}}</td>
                <td>{{points(player.user.solves)}}</td>
              </tr>
            </tbody>
          </table>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "team",
  beforeMount() {
    this.$store.dispatch("teams/loadStats", this.$route.params.name);
  },
  components: {
    Graph: () => import("@/components/team/Graph")
  },
  computed: {
    ...mapGetters({
      team: "teams/GET_TEAM"
    })
  },
  methods: {
    points(challenges) {
      let total = 0;
      challenges.forEach(element => (total = total + element.challenge.points));
      return total;
    }
  }
};
</script>