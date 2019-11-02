<template>
  <div class="offset">
    <div v-if="loading">Yo, we loadin'. Hang tight</div>
    <div v-else>
      <div class="newOpt">
        <button class="btn btn-secondary" @click="$router.push({ name: 'AdminChallengesCreate'});">New Challenge</button>
      </div>

      <table id="adminchallenge" class="table table-striped table-sm">
        <thead>
          <tr>
            <th>ID</th>
            <th>Challenge</th>
            <th>Description</th>
            <th>Points</th>
            <th style="text-align: right;">Options</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="challenge in challenges" v-bind:key="challenge.id">
            <td>{{challenge.id}}</td>
            <td>{{challenge.name}}</td>
            <td>{{challenge.description}}</td>
            <td>{{challenge.points}}</td>
            <td>
              <div>
                <RemoveChallenge :challenge="challenge" />
                <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminChallengeEdit', params: { challenge: challenge } }">Edit</router-link>
                <AdminViewFlag :cid="challenge.id" />
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>


<script>
import { api } from "@/utils/api";
import RemoveChallenge from "@/components/admin/remove/challenge.vue";
import AdminViewFlag from "@/components/admin/AdminViewFlag.vue";

export default {
  name: "AdminChallenge",
  components: { RemoveChallenge, AdminViewFlag },
  data() {
    return {
      loading: true,
      challenges: []
    };
  },
  beforeMount() {
    let that = this;
    api(
      "query { challenges{ id, name, description, points, category { id, name } } }"
    ).then(data => {
      that.challenges = data.challenges;
      that.loading = false;
    });
  }
};
</script>

<style scoped>
.secret {
  color: white;
}
.secret:hover {
  color: black;
}
</style>