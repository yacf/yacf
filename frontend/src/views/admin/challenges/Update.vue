<template>
  <div style="padding:20px">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', to: { name: 'AdminChallenges' } },{ text: 'Upadate', href: '#' }]"></b-breadcrumb>

    <b-card header="Update Challenge">
      <b-tabs content-class="mt-3">
        <b-tab title="Challenge" active>
          --- {{challenge}}
          <div v-if="challenge.data">
            <label>Challenge name:</label>
            <input class="form-control" v-model="challenge.data.name" />
            <label>Challenge Description (html enabled):</label>
            <textarea class="form-control" rows="10" v-model="challenge.data.description"></textarea>
            <label>Challenge Points:</label>
            <input class="form-control" v-model="challenge.data.points" />
            <label>Challenge Flag:</label>
            <input class="form-control" v-model="flag" />
            <label>Challenge Category:</label>
            <select class="form-control" v-model="challenge.data.category.name">
              <option v-bind:default="challenge.data.category.name">{{challenge.data.category.name}}</option>
              <option value="None">None</option>
              <option v-for="category in categories.data" v-bind:value="category.name" v-bind:key="category.id">{{category.name}}</option>
            </select>
            <p>{{message}}</p>
            <hr />
            <button class="btn btn-secondary" @click="update()">Update</button>
          </div>
          <div v-else>Redirect.. You cannot access this page directly</div>
        </b-tab>
        <b-tab title="Hints">Coming soon. Available in django admin</b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>


<script>
import { api } from "@/utils/api";
import { mapGetters } from "vuex";
import RemoveChallenge from "@/components/admin/remove/challenge.vue";

export default {
  name: "AdminChallenge",
  props: ["id"],
  components: {
    RemoveChallenge
  },
  data() {
    return {
      message: "",
      flag: ""
    };
  },
  computed: {
    ...mapGetters({
      challenge: "challenges/GET_CHALLENGE",
      categories: "categories/GET_CATEGORIES"
    })
  },
  beforeMount() {
    this.$store.commit("challenges/SET_CHALLENGE_DEFAULT");
    this.$store.dispatch("challenges/FETCH_CHALLENGE", this.id);
    this.$store.dispatch("categories/FETCH_CATEGORIES");
  }
};
</script>