<template>
  <div>
    <!-- Modal Component -->
    <b-modal v-bind:id="chal.id" v-bind:title="chal.category.name + ' ' + chal.points" ok-variant="secondary" @shown="loaddata" ok-only>
      <div v-if="loading">Challenge details are loading, please hold!</div>
      <div v-else>
        <div>
          {{chal.name}}
          <hr />
          <b-tabs content-class="mt-3">
            <b-tab title="Challenge" active>
              <span v-html="challenge.description"></span>
              <div v-if="enter">
                <p>Congrats, you solved the challenge! On to the next one!</p>
              </div>
              <div v-else>
                <b-input-group class="mt-3">
                  <b-form-input v-model="flag" v-on:keyup.enter="handleOk" required placeholder="Enter Flag"></b-form-input>
                  <b-input-group-append>
                    <b-button variant="info" @click="handleOk">Submit</b-button>
                  </b-input-group-append>
                </b-input-group>

                <p>{{message}}</p>
              </div>
            </b-tab>
            <b-tab v-if="challenge.hints.length !== 0" title="Hints">
              <div v-for="hint in challenge.hints" :key="hint.id">
                <h4>{{hint.title}}</h4>
                <p>{{hint.description}}</p>
                <hr />
              </div>
            </b-tab>
            <b-tab title="Stats">
              <p class="stats" @click="$router.push(`/challenge/${categoryInLowerCase}/${challenge.points}`);">View Stats</p>
            </b-tab>
          </b-tabs>
        </div>
      </div>
    </b-modal>
  </div>
</template>

<script>
import { api } from "@/utils/api.js";

export default {
  name: "Challenges",
  props: ["chal", "enter"],
  data() {
    return {
      loading: true,
      challenge: "",
      flag: "",
      solved: false,
      message: ""
    };
  },
  computed: {
    categoryInLowerCase() {
      return this.challenge.category.name.toLowerCase().trim();
    }
  },
  methods: {
    handleOk(evt) {
      console.log("Here is the flag enter: ", this.flag);
      evt.preventDefault();

      let that = this;
      api(
        `mutation{ submitflag(challenge:${this.chal.id}, flag:"${this.flag}"){ code } }`
      ).then(data => {
        console.log("FLAG:", data.submitflag);
        if (data.submitflag.code === 1) {
          that.message = "You solved it!"; //Should get this from the backend
          that.$store.commit("SET_USER_SOLVE", that.chal.id);
        } else {
          that.message = "That's not it! Try again.";
        }
      });
    },
    loaddata() {
      let that = this;
      api(
        `query{ challenge(id:${this.chal.id}){ id, description, points, category { name } hints { id title description } } }`
      ).then(data => {
        that.challenge = data.challenge;
        that.loading = false;
      });
    }
  }
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
</style>