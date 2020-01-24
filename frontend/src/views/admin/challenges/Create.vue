<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', to: { name: 'AdminChallenges' } },{ text: 'Create', href: '#' }]"></b-breadcrumb>

    <b-card header="Create Challenge">
      <b-alert v-if="create.code === 0" show variant="success">Challenge Created</b-alert>

      <label>Challenge name:</label>
      <input class="form-control" v-model="name" />
      <label>Challenge Description (html enabled):</label>
      <textarea class="form-control" rows="7" v-model="description"></textarea>
      <b-form-checkbox v-model="encode" value="true" unchecked-value="false">Base64 Encode</b-form-checkbox>
      <b-form-text>Check this if your challenge is HTML enabled. This will bace64 encode the description to avoid errors with special characters when processing requests.</b-form-text>
      <label>Challenge Points:</label>
      <input class="form-control" type="number" v-model="points" />
      <label>Challenge Flag:</label>
      <input class="form-control" v-model="flag" />
      <label>Flag Hash:</label>
      <select class="form-control" v-model="algorithm">
        <option value="None" v-bind:default="true">None</option>
        <option value="md5">MD5</option>
        <option value="sha224">SHA224</option>
        <option value="sha256">SHA256</option>
      </select>
      <b-form-checkbox v-model="precomputed" value="true" unchecked-value="false">Precomputed</b-form-checkbox>
      <b-form-text>Check this if you already hashed your the flag. Otherwise, the flag will be hashed for you when the challenge is created</b-form-text>
      <label>Challenge Category:</label>
      <select class="form-control" v-model="category">
        <option value="None" v-bind:default="true">None</option>
        <option v-for="category in categories.data" v-bind:value="category.name" v-bind:key="category.id">{{category.name}}</option>
      </select>
      <b-form-checkbox v-model="hidden" value="true" unchecked-value="false">Hidden</b-form-checkbox>
      <hr />
      <p>{{message}}</p>
      <b-alert v-for="(error, index) in create.errors" :key="index" show variant="danger">{{error.message}}</b-alert>

      <button class="btn btn-secondary" @click="addChallenge()">Create</button>
    </b-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "AddCategory",
  data() {
    return {
      name: "",
      description: "",
      encode: false,
      points: "",
      flag: "",
      algorithm: "None",
      precomputed: false,
      category: "None",
      hidden: false,
      message: ""
    };
  },
  computed: {
    ...mapGetters({
      categories: "categories/GET_CATEGORIES",
      create: "challenges/GET_CREATE"
    })
  },
  watch() {
    //that.$router.push({ name: "AdminChallenges" });
  },
  beforeMount() {
    this.$store.commit("challenges/SET_CREATE_DEFAULT");
    this.$store.dispatch("categories/FETCH_CATEGORIES");
  },
  methods: {
    addChallenge() {
      if (
        this.name &&
        this.description &&
        this.points &&
        this.flag &&
        this.algorithm
      ) {
        let description = "";
        this.encode
          ? (description = btoa(unescape(encodeURIComponent(this.description))))
          : (description = this.description);
        this.$store.dispatch("challenges/CREATE_CHALLENGE", {
          name: this.name,
          description: description,
          encode: this.encode,
          points: this.points,
          flag: this.flag,
          algorithm: this.algorithm,
          precomputed: this.precomputed,
          category: this.category,
          hidden: this.hidden
        });
      } else {
        console.log("hello");
        this.$bvToast.toast(`This is toast number BAM!`, {
          title: "BootstrapVue Toast",
          autoHideDelay: 5000,
          appendToast: false
        });

        this.message = "Required feilds missing.";
      }
    }
  }
};
</script>