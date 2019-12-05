<template>
  <span v-html="content"></span>
</template>

<script>
import { api } from "@/utils/api.js";
export default {
  name: "home",
  data() {
    return {
      loading: true,
      content: ""
    };
  },
  beforeMount() {
    let that = this;
    api("query{ welcomePage{ content } }").then(response => {
      that.content = atob(response.data.welcomePage.content);
      that.loading = false;
    });
  }
};
</script>
