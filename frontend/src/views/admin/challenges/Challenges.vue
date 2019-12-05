<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Challenges', href: '#' }]"></b-breadcrumb>
    <div v-if="challenges.loading">Loading</div>
    <div v-else>
      <div class="newOpt">
        <button class="btn btn-secondary" @click="$router.push({ name: 'AdminChallengesCreate'});">New Challenge</button>
      </div>
      <b-card header="Challenges">
        <table id="adminchallenge" class="table table-hover table-sm">
          <thead>
            <tr>
              <th>ID</th>
              <th>Category</th>
              <th>Challenge Name</th>
              <th>Points</th>
              <th>Hints</th>
              <th>Hidden</th>
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="challenge in challenges.data" v-bind:key="challenge.id">
              <td>{{challenge.id}}</td>
              <td v-if="challenge.category">{{challenge.category.name}}</td>
              <td v-else>
                <b-badge variant="warning">No Category</b-badge>
              </td>
              <td>{{challenge.name}}</td>
              <td>{{challenge.points}}</td>
              <td>{{challenge.hints.length}}</td>
              <td>{{challenge.hidden}}</td>
              <td>
                <div>
                  <RemoveChallenge :challenge="challenge" />
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminChallengeEdit', params: { id: challenge.id } }">Edit</router-link>
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
import { mapGetters } from "vuex";
import RemoveChallenge from "@/components/admin/remove/challenge.vue";
import AdminViewFlag from "@/components/admin/AdminViewFlag.vue";

export default {
  name: "AdminChallenge",
  components: { RemoveChallenge, AdminViewFlag },
  computed: {
    ...mapGetters({
      challenges: "challenges/GET_CHALLENGES"
    })
  },
  beforeMount() {
    this.$store.dispatch("challenges/FETCH_CHALLENGES");
  }
};
</script>