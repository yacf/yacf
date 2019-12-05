<template>
  <div>
    <b-alert v-if="this.$store.getters['user/isAdmin']" style="text-align: center;" show>You are an Admin. The challenge board will have limit functionality.</b-alert>
    <div v-if="board.loading">Loading..</div>
    <div v-else>
      <div v-if="board.data">
        <div class="container">
          <!-- <transition name="fade">
            <b-input-group style="padding: 15px">
              <template v-slot:prepend>
                <b-input-group-text style="border-radius: 3px 0 0 3px;">Category</b-input-group-text>
              </template>

              <b-form-select v-model="selected" :options="options"></b-form-select>

              <template v-slot:append>
                <b-dropdown text="Filter" variant="secondary" style="border-radius: 0 3px 3px 0;">
                  <b-dropdown-item>Hide Solved</b-dropdown-item>
                </b-dropdown>
              </template>
            </b-input-group>
          </transition>-->
          <div class="flex-container">
            <div v-for="challenge in board.data" :key="challenge.id">
              <div class="flex-container-div" v-b-modal="challenge.id" style="cursor: pointer;" v-bind:style="[solves.includes(challenge.id) ? {'backgroundColor': '#448aff', 'color': 'white'} : {}]">
                <h5>{{challenge.category.name}}</h5>
                <p>{{challenge.name.substring(0, 10)}}...</p>
                <p>{{challenge.points}}</p>
                <p v-if="challenge.hints.length !== 0">?</p>
              </div>
              <Challenge :chal="challenge" :enter="solves.includes(challenge.id) ? true : false"></Challenge>
            </div>
          </div>
        </div>
      </div>
      <div v-else>Error: No board data...</div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Challenge from "@/components/Challenge.vue";

export default {
  name: "home",
  components: {
    Challenge
  },
  data() {
    return {
      options: [{ value: null, text: "All Categories" }],
      selected: null
    };
  },
  computed: {
    ...mapGetters({
      board: "challenges/GET_BOARD",
      solves: "teams/GET_SOLVES"
    }),
    challenges() {
      if (this.selected !== null) {
        let self = this;
        return this.$store.state.challenges.filter(function(challenge) {
          return challenge.category.name == self.selected;
        });
      } else {
        return this.$store.state.challenges;
      }
    }
  },
  beforeMount() {
    this.$store.dispatch("challenges/FETCH_BOARD");
    this.$store.dispatch("teams/FETCH_SOLVES");
  }
};
</script>
