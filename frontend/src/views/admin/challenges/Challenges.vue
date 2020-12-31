<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', href: '#' }]"></b-breadcrumb>
    <div v-if="challenges.loading">Loading</div>
    <div v-else>
      <b-row>
        <b-col md="6">
          <button class="btn btn-secondary" @click="$router.push({ name: 'AdminChallengesCreate'});">New Challenge</button>
        </b-col>
        <b-col md="6">
          <pagination :count="challengeCount" @clicked="emitevent" />
        </b-col>
      </b-row>
      <b-card header="Challenges">
        <table id="adminchallenge" class="table table-hover table-sm">
          <thead>
            <tr>
              <!-- <th>ID</th> -->
              <th>Category</th>
              <th>Challenge Name</th>
              <th>Points</th>
              <th>Hints</th>
              <th>Hidden</th>
              <th>Solves</th>
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="challenge in challenges" v-bind:key="challenge.id">
              <!-- <td>{{challenge.id}}</td> -->
              <td v-if="challenge.category">{{challenge.category.name}}</td>
              <td v-else>
                <b-badge variant="warning">No Category</b-badge>
              </td>
              <td>{{challenge.name}}</td>
              <td>{{challenge.points}}</td>
              <td>{{challenge.hints.length}}</td>
              <td v-if="challenge.hidden"><b-icon icon="eye-slash"></b-icon></td>
              <td v-else></td>
              <td>{{challenge.solvedchallengeSet.length}}</td>
              <td>
                <div>
                  <!-- <RemoveChallenge :challenge="challenge" />c -->
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminChallengeEdit', query: { id: challenge.id } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
                  <!-- <AdminViewFlag :cid="challenge.id" /> -->
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </b-card>
    </div>
  </div>
</template>


<script>
import Pagination from "@/components/general/pagination";
import { challengesQuery, challengeCountQuery } from "@/api/queries/challenges";

import RemoveChallenge from "@/components/admin/remove/challenge.vue";
import AdminViewFlag from "@/components/admin/AdminViewFlag.vue";

export default {
  name: "AdminChallenge",
  components: { RemoveChallenge, AdminViewFlag, Pagination },
  data () {
    return {
      challenges: [],
      challengeCount: 0,
      page: 1,
      rows: 15,
    }
  },
  apollo: {
    challenges: {
      query: challengesQuery('id category { id name } name points hints { id } hidden solvedchallengeSet { id }'),
      variables() {
        return {
          skip: (this.page - 1) * this.rows,
          first: this.rows,
        };
      },
    },
    challengeCount: {
      query: challengeCountQuery()
    }
  },
  methods: {
    emitevent(value) {
      if ("page" in value) {
        this.page = value.page;
      } else if ("rows" in value) {
        this.rows = value.rows;
      }
    },
  }
};
</script>