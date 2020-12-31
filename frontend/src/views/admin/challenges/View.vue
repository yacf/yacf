<template>
  <div style="padding:20px">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', to: { name: 'AdminChallenges' } },{ text: 'View', href: '#' }]"></b-breadcrumb>
    <!-- <b-alert v-for="(error, index) in update.errors" :key="index" show variant="danger">{{error.message}}</b-alert> -->
    <!-- <b-alert  show variant="success">Challenge Updated</b-alert> -->

    <!-- <template v-if="update.code === 0 ? success(): 0"></template>
    <template v-if="update.errors.length !== 0 ? failure(): 0"></template> -->
    <div v-if="this.$apollo.queries.challenge.loading || this.$apollo.queries.categories.loading">
      Loading
    </div>
    <div v-else>
      <b-card header="Challenge">
        <b-row>
          <b-col md="6">
            <div v-if="challenge">
              <label>Challenge name:</label>
              <input class="form-control" v-model="challenge.name" disabled/>
              
              <label>Challenge Points:</label>
              <input class="form-control" type="number" v-model="challenge.points" disabled />
              <label>Challenge Category:</label>
              <select class="form-control" v-model="challenge.category.name" disabled>
                <option v-bind:default="challenge.category.name">{{challenge.category.name}}</option>
                <option value="None">None</option>
                <option v-for="category in categories" v-bind:value="category.name" v-bind:key="category.id">{{category.name}}</option>
              </select>
              <label>Flag:</label>
              <b-input-group>
                <b-form-input v-model="challenge.flag.value" :type="flagview" disabled></b-form-input>
                <b-input-group-append>
                  <b-button @click="flagview === 'password' ? flagview = 'text' : flagview = 'password'">Show</b-button>
                </b-input-group-append>
              </b-input-group>
            </div>
          </b-col>
          <b-col md="6">
            <label>Challenge Description (html enabled):</label>
            <textarea class="form-control" rows="10" v-model="challenge.description" disabled></textarea>
          </b-col>
        </b-row>
          <!-- <hr />
          <button class="btn btn-secondary" @click="updateA()">Update</button> -->
      </b-card>
      <hr>
      <b-card header="Options">
        <b-row>
          <b-col md="6">
            <h6>Timed Delay</h6>
            <hr>
            <!-- <b-form-checkbox v-model="timed" value="true" unchecked-value="false" > Delayed Release </b-form-checkbox>
              <div v-if="timed === 'true'"> -->
                <label>Release date:</label>
                <b-form-datepicker v-model="delaydate" class="mb-2" disabled></b-form-datepicker>
                <label>Release time:</label>
                <b-form-timepicker v-model="delaytime" locale="en" disabled></b-form-timepicker>
              <!-- </div> -->
            <br>
            <h6>Visability</h6>
            <hr>
            <b-form-checkbox v-model="challenge.hidden" :value="true" :unchecked-value="false" disabled> Hidden </b-form-checkbox>
            
          </b-col>
          <b-col md="6">
            <h6>Flag</h6>
            <hr>
            <!-- {{challenge.flag}} -->
            <b-form-checkbox v-model="challenge.flag.hashed" :value="true" :unchecked-value="false" disabled> SHA256 Hashed </b-form-checkbox>
            <b-form-checkbox v-model="challenge.flag.caseSensitive" :value="true" :unchecked-value="false" disabled> Case Sensitive Submits </b-form-checkbox>
            <b-form-checkbox v-model="challenge.flag.resubmit" :value="true" :unchecked-value="false" disabled> Allow Resubmits </b-form-checkbox>
            <br>
            <h6>Point Depreciation</h6>
            <hr>
            Currently in development.
          </b-col>
        </b-row>
      </b-card>
      <hr>
      <b-card header="Hints">
        <div v-if="challenge.hints.length">
          <table id="challengehints" class="table table-hover table-sm">
            <thead>
              <tr>
                <!-- <th>ID</th> -->
                <th>Name</th>
                <th>Description</th>
                <th>Hidden</th>
                <!-- <th>Release Time</th> -->
                <!-- <th style="text-align: right;">Options</th> -->
              </tr>
            </thead>
            <tbody>
              <tr v-for="hint in challenge.hints" v-bind:key="hint.id">
                <td>{{hint.title}}</td>
                <td>{{hint.description}}</td>
                <td>{{hint.hidden}}</td>
                <!-- <td>{{hint.hidden}}</td> -->
                <!-- <td>
                  <div>
                    <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminChallengeEdit', query: { id: challenge.id } }">></router-link>
                  </div>
                </td> -->
              </tr>
            </tbody>
          </table>



        </div>
        <div v-else>
          No hints
        </div>
      </b-card>
    </div>
  </div>
</template>


<script>
import { categoriesQuery } from "@/api/queries/categories";
import { challengeQuery } from "@/api/queries/challenges";
// import { mapGetters } from "vuex";
// import RemoveChallenge from "@/components/admin/remove/challenge.vue";

export default {
  name: "AdminChallenge",
  // props: {
  //   id: {
  //     required: true
  //   }
  // },
  // components: {
  //   RemoveChallenge
  // },
  data() {
    return {
      categories: null,
      challenge: {
        category: null,
        hints: null
      },
      flagview: 'password',
      timed: null,
      hidden: null,
      visable: true
    }
  },
  apollo: {
    challenge: {
      query: challengeQuery('id name description points flag { value hashed caseSensitive resubmit } category { id name } hints { id title description hidden } releaseTime hidden'),
      variables() {
        return {
          id: this.$route.query.id
        };
      },
    },
    categories: {
      query: categoriesQuery('id name')
    },
  },
  computed: {
    delaydate: function () {
      if (this.challenge.releaseTime) { 
        let time = new Date(this.challenge.releaseTime)
        return `${time.getFullYear()}-${time.getMonth()+1}-${time.getUTCDate()}`
      } else {
        return null
      }
    },
    delaytime: function () {
      if (this.challenge.releaseTime) {
        let time = new Date(this.challenge.releaseTime)
        return `${time.getHours()}:${time.getMinutes()}:${time.getSeconds()}`
      } else {
        return null
      }

    }
  },
  beforeCreate() {
    if (this.$route.query.id === undefined) this.$router.push({ name: "AdminChallenges" });
  }
};
</script>
