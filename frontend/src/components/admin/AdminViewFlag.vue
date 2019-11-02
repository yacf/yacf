<template>
  <div style="float: right;">
    <!-- Modal Component -->
    <button class="btn btn-sm btn-secondary" v-b-modal="'flag'+cid" style="margin-left: 5px;">Flag</button>
    <b-modal v-bind:id="'flag'+cid" v-bind:title="title" ok-title="Close">
      <p>flag:</p>
      {{message}}
    </b-modal>
  </div>
</template>

<script>
import { api } from "@/utils/api.js";

export default {
  name: "AdminViewFlag",
  props: ["cid"],
  data() {
    return {
      confirm: "",
      message: ""
    };
  },
  methods: {}
};
</script>

<style scoped>
.stats {
  color: black;
  text-align: center;
  cursor: pointer;
  margin-bottom: 0;
}
.stats:hover {
  text-decoration: underline;
}
label {
  margin-top: 10px;
  margin-bottom: 0px;
}
</style>