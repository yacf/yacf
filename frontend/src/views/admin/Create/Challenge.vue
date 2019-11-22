<template>
  <div class="offset">
    <b-card header="New Challenge">
      <h3>Add Challenge</h3>
      <label>Challenge name:</label>
      <input class="form-control" v-model="name" />
      <label>Challenge Description (html enabled):</label>
      <textarea class="form-control" rows="7" v-model="description"></textarea>
      <label>Challenge Points:</label>
      <input class="form-control" v-model="points" />
      <label>Challenge Flag:</label>
      <input class="form-control" v-model="flag" />
      <label>Flag Hash:</label>
      <select class="form-control" v-model="algorithm">
        <option value="None" v-bind:default="true">None</option>
        <option value="md5">MD5</option>
        <option value="sha224">SHA224</option>
        <option value="sha256">SHA356</option>
      </select>
      <label>Challenge Category:</label>
      <select class="form-control" v-model="category">
        <option value="None" v-bind:default="true">None</option>
        <option
          v-for="category in categories"
          v-bind:value="category.name"
          v-bind:key="category.id"
        >{{category.name}}</option>
      </select>
      <b-form-checkbox
        id="checkbox-1"
        v-model="hidden"
        name="checkbox-1"
        value="true"
        unchecked-value="false"
      >Hidden</b-form-checkbox>

      <p>{{message}}</p>
      <button class="btn btn-secondary" @click="addChallenge()">Add Challenge</button>
    </b-card>
  </div>
</template>

<script>
import { api } from "@/utils/api";

export default {
  name: "AddCategory",
  data() {
    return {
      categories: [],
      name: "",
      description: "",
      points: "",
      flag: "",
      algorithm: "None",
      category: "None",
      hidden: false,
      message: ""
    };
  },
  beforeMount() {
    let that = this;
    api("query { categories{ name } }").then(data => {
      that.categories = data.categories;
    });
  },
  methods: {
    addChallenge() {
      var query = "";
      var chal = btoa(unescape(encodeURIComponent(this.content)));

      if (this.category == "None" || this.category == "") {
        query = `mutation{ addChallenge(name:"${this.name}", description:"${chal}", points:${this.points}, flag:"${this.flag}", algorithm:${this.algorithm} hidden:${this.hidden}) { message } }`;
      } else {
        query = `mutation{ addChallenge(name:"${this.name}", description:"${chal}", points:${this.points}, flag:"${this.flag}", hidden:${this.hidden}, category:"${this.category}") { message } }`;
      }

      let that = this;
      api(query).then(data => {
        that.message = data.addChallenge.message;
      });
    }
  }
};
</script>

<style scoped>
</style>