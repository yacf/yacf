<template>
  <div style="padding:20px">
    <!-- <h3>Configure Welcome</h3> -->

    <div>
      
      <b-card header="Welcome Page" header-tag="header">
        <b-tabs content-class="mt-3">
          <b-tab title="Configure" active>
            <MonacoEditor height="500" theme="vs" language="html" :options="options" v-model="content"></MonacoEditor>
            <span>(html enabled)</span>
            <hr />
            <div class="alert alert-warning" role="alert">
              <h6 class="alert-heading">Warning</h6>
              <p>The YACF landing page content is exposed publicly. No authentication is required for this.</p>
            </div>
            <button class="btn btn-secondary" style="margin-top: 10px;" @click="addWelcome()">Submit</button>
            <p>{{status}}</p>
          </b-tab>
          <b-tab title="Preview">
            <span v-html="content"></span>
          </b-tab>
        </b-tabs>
      </b-card>
    </div>
    
  </div>
</template>

<script>
import MonacoEditor from "monaco-editor-vue";
import { api } from "@/utils/api.js";

export default {
  name: "",
  components: {
    MonacoEditor
  },
  data() {
    return {
      content: "",
      status: "",
      options: {
        //Monaco Editor Options
      }
    };
  },
  beforeMount() {
    let self = this;
    api("query{ welcomePage{ content } }").then(response => {
      self.content = decodeURIComponent(escape(atob(response.data.welcomePage.content)));
    });
  },
  methods: {
    addWelcome() {
      let self = this;
      api(
        `mutation{ welcome(content:"${btoa(
          unescape(encodeURIComponent(this.content))
        )}"){ status } }`
      ).then(response => {
        self.status = response.data.welcome.status;
      });
    }
  }
};
</script>

<style scoped>
</style>