<template>
  <div class="offset">
    <h3>Event</h3>Event time
    <input class="form-control" v-model="time" />
    <h3>Teams</h3>
    <hr />Max Teams
    <input class="form-control" v-model="maxteams" />
    <hr />Max users on team
    <input class="form-control" v-model="maxuserforteam" />
    <h3>Accounts</h3>
    <hr />Password Complexity
    <hr />Open Registration
    <h3>Extras</h3>
    <hr />Plugins
  </div>
</template>

<script>
export default {
  name: "AdminSettings",
  data() {
    return {
      time: "",
      maxteams: 0,
      maxuserforteam: 1
    };
  }
};
</script>