<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } }, { text: 'Categories', to: { name: 'AdminCategories' } },{ text: 'View', href: '#' }]"></b-breadcrumb>
    <b-card header="Category">
      <!-- <b-alert v-for="(error, index) in update.errors" :key="index" show variant="danger">{{error.message}}</b-alert> -->
      <!-- <b-alert v-if="update.code === 0" show variant="success">Category Updated</b-alert> -->
      
      <div v-if="category">
        <label>Category name:</label>
        <input class="form-control" v-model="category.name" disabled/>
        <label>Category Description:</label>
        <textarea class="form-control" rows="7" v-model="category.description" disabled></textarea>
        <!-- <hr />
        <button class="btn btn-secondary" @click="updateA()">Update</button> -->
      </div>
      <div v-else>Redirect.. You cannot access this page directly</div>
    </b-card>
    <hr>
    <b-card v-if="category" header="Challenges">
      <table id="challenges" class="table table-sm table-hover">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Points</th>
            <th>Hidden</th>
            <th style="text-align: right;">Options</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="challenge in category.challenges" v-bind:key="challenge.id">
            <td>{{challenge.name}}</td>
            <td>{{challenge.description}}</td>
            <td>{{challenge.points}}</td>
            <td v-if="challenge.hidden"><b-icon icon="eye-slash"></b-icon></td>
            <td v-else></td>
            <td>
              <div>
                <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminChallengeEdit', query: { id: challenge.id } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
                <!-- <RemoveTeam :team="team" /> -->
                <!-- <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminTeamEdit', params: { name: team.name } }">Edit</router-link> -->
              </div>
            </td>
          </tr>
        </tbody>
      </table>


    </b-card>
  </div>
</template>

<script>
import { categoryQuery } from "@/api/queries/categories";

export default {
  name: "Category",
  data()  {
    return {
      category: null,
    }
  },
  apollo: {
    category: {
      query: categoryQuery('id name description challenges { id name description points hidden }'),
      variables() {
        return {
          id: this.$route.query.id
        };
      },
    }
  },
  beforeCreate() {
    if (this.$route.query.id === undefined) this.$router.push({ name: "AdminCategories" });
  }
  // methods: {
  //   updateA() {
  //     this.$store.dispatch("categories/UPDATE_CATEGORY", {
  //       id: this.category.id,
  //       name: this.category.name,
  //       description: this.category.description
  //     });
  //   }
  // }
};
</script>