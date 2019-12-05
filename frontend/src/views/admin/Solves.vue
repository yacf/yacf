<template>
  <div class="offset">
    <b-card header="Solves Graph">
      <Graph />
    </b-card>
    <hr />
    <b-card-group deck>
      <b-card header="Solves">
        <b-alert variant="success" v-for="solve in solves" :key="solve.id" show>
          ({{solve.id}}) {{solve.team.name}} - {{solve.challenge.name}}
          <span style="text-align: right; float: right">{{solve.timestamp | moment("MMMM Do YYYY, h:mm:ss a") }}</span>
        </b-alert>
      </b-card>
      <b-card header="Failures">
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
  name: "AdminSovles",
  components: {
    Graph: () => import("@/components/graphs/solves")
  },
  data() {
    return {
      solves: [],
      failures: []
    };
  },
  created() {
    let self = this;
    api(
      "query { solves { id team { name } challenge { name } timestamp } }"
    ).then(response => {
      self.solves = response.data.solves;
    });
    api(
      "query { failures { id team { name } challenge { name } timestamp } }"
    ).then(response => {
      self.failures = response.data.failures;
    });
  }
};
</script>