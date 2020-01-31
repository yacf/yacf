<template>
  <div style="padding:20px">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', to: { name: 'AdminChallenges' } },{ text: 'Upadate', href: '#' }]"></b-breadcrumb>
    <b-alert v-for="(error, index) in update.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
    <!-- <b-alert  show variant="success">Challenge Updated</b-alert> -->

    <template v-if="update.code === 0 ? success(): 0"></template>
    <template v-if="update.errors.length !== 0 ? failure(): 0"></template>

    <b-card header="Update Challenge">
      
      <b-tabs content-class="mt-3">
        <b-tab title="Challenge" active>
          <div v-if="challenge.data">
            <label>Challenge name:</label>
            <input class="form-control" v-model="challenge.data.name" />
            <label>Challenge Description (html enabled):</label>
            <textarea class="form-control" rows="10" v-model="challenge.data.description"></textarea>
            <label>Challenge Points:</label>
            <input class="form-control" v-model="challenge.data.points" />
            <label>Challenge Category:</label>
            <select class="form-control" v-model="challenge.data.category.name">
              <option v-bind:default="challenge.data.category.name">{{challenge.data.category.name}}</option>
              <option value="None">None</option>
              <option v-for="category in categories.data" v-bind:value="category.name" v-bind:key="category.id">{{category.name}}</option>
            </select>
            <hr />
            <button class="btn btn-secondary" @click="updateA()">Update</button>
          </div>
          <div v-else>Redirect.. You cannot access this page directly</div>
        </b-tab>
        <b-tab title="Hints">Coming soon. Available in django admin <br><br>--- {{challenge}}</b-tab>
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
      visable: true
    }
  },
  computed: {
    ...mapGetters({
      challenge: "challenges/GET_CHALLENGE",
      categories: "categories/GET_CATEGORIES",
      update: "challenges/GET_UPDATE"
    })
  },
  beforeMount() {
    this.$store.commit("challenges/SET_CHALLENGE_DEFAULT");
    this.$store.dispatch("challenges/FETCH_CHALLENGE", this.id);
    this.$store.dispatch("categories/FETCH_CATEGORIES");
  },
  methods: {

success(variant = null) {
        this.$bvToast.toast('Challenge updated', {
          title: "Challenge Updated",
          variant: variant,
          solid: true
        })
        this.$store.commit("challenges/SET_UPDATE_DEFAULT");

    },
    failure(variant = null) {
      console.log(this.update.errors)
        this.$bvToast.toast('bad', {
          title: `Variant ${variant || 'default'}`,
          variant: variant,
          solid: true
        })

    },
    updateA() {
      this.$store.dispatch("challenges/UPDATE_CHALLENGE", {
        id: this.challenge.data.id,
        name: this.challenge.data.name,
        description: this.challenge.data.description,
        category: this.challenge.data.category.name,
        points: this.challenge.data.points,
        show: true//this.challenge.data.show
      });
    },
  }
};
</script>
