<template>
  <div>
    <b-alert v-if="this.$store.getters['user/isAdmin']" style="text-align: center;" show>You are an Admin. The challenge board will have limit functionality.</b-alert>

    <div class="container">
      <div v-if="this.$store.getters['user/userteam'] || this.$store.getters['user/isAdmin']">
        <transition name="fade">
          <div v-if="this.$store.state.board">
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

            <div class="flex-container">
              <div v-for="challenge in challenges" :key="challenge.id">
                <div class="flex-container-div" v-b-modal="challenge.id" style="cursor: pointer;" v-bind:style="[isSoved(challenge.id) ? {'backgroundColor': '#448aff', 'color': 'white'} : {}]">
                  <h5>{{challenge.category.name}}</h5>
                  <p>{{challenge.name.substring(0, 10)}}...</p>
                  <p>{{challenge.points}}</p>
                  <p v-if="challenge.hints.length !== 0">?</p>
                </div>
                <Challenge :chal="challenge" :enter="isSoved(challenge.id) ? true : false"></Challenge>
              </div>
            </div>
          </div>
        </transition>
        <div v-if="!this.$store.state.board">
          <main>
            <div class="la-ball-clip-rotate-multiple la-dark la-3x">
              <div></div>
              <div></div>
            </div>
          </main>
        </div>
      </div>
      <div v-else>You are not apart of a team</div>
    </div>
  </div>
</template>

<script>
import { api } from "@/utils/api";

// import Challenges from "@/components/Challenges.vue";
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
  mounted() {
    //TODO: Load this back into a component
    this.$store.dispatch("loadChallengeBoard");
    this.$store.dispatch("loadNewChallengeBoard");

    let self = this;
    api(
      "query { categories{ id, name, description, challenges { id } } }"
    ).then(data => {
      data.categories.forEach(function(element) {
        self.options.push({ value: element.name, text: element.name });
      });
    });
  },
  methods: {
    isSoved(id) {
      return this.$store.state.solves.includes(id);
    }
  }
};
</script>
