<template>
  <div class="offset">
    <h3>Edit Page</h3>
    <label>Page Name:</label>
    <input class="form-control" v-model="page.name" />
    <label>Page URL:</label>
    <input class="form-control" v-model="page.url" />
    <label>Page Content:</label>
    <MonacoEditor height="500" theme="vs" language="html" v-model="page.content" :options="options"></MonacoEditor>
    <p>{{message}}</p>
    <button class="btn btn-secondary" @click="updatePage()">Update Page</button>
  </div>
</template>

<script>
import { api } from "@/utils/api";
import MonacoEditor from "monaco-editor-vue";

export default {
  name: "UpdatePage",
  components: { MonacoEditor },
  props: {
    id: {
      default: 0
    }
  },
  data() {
    return {
      page: {
        id: null,
        name: "",
        url: "",
        content: ""
      },
      message: "",
      options: {}
    };
  },
  created() {
    if (this.id === 0) {
      this.$router.push({ name: "AdminPages" });
    } else {
      let self = this;
      api(`query { page(id:${this.id}){ id name url content } }`).then(data => {
        self.page = data.page;
      });
    }
  },
  methods: {
    updatePage() {
      console.log("updating page");

      let self = this;
      api(
        `mutation { updatepage(id:${this.page.id}, url:"${this.page.url}", name:"${this.page.name}", content:"${this.page.content}") { message } }`
      ).then(data => {
        self.message =
          data.updatepage.message + "- Refresh page to see changes";
      });
    }
  }
};
</script>