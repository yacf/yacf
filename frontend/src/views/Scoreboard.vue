<template>
  <div style="padding:15px;">
    <b-card header="Progress Graph">
      <Graph />
    </b-card>
    <!-- <hr />
    <div v-if="!this.$store.getters['user/isAdmin']">
      <b-card header="Team Placement">
        <TeamPlacement />
      </b-card>
    </div>-->
    <hr />
    <b-card header="Scoreboard">
      <Scoreboard />
    </b-card>
  </div>
</template>

<script>
export default {
  name: "scoreboard",
  components: {
    Graph: () => import("@/components/scoreboard/Graph"),
    TeamPlacement: () => import("@/components/scoreboard/TeamPlacement"),
    Scoreboard: () => import("@/components/scoreboard/Scoreboard")
  }
};
</script>