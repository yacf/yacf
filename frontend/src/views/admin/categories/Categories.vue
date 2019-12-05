<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Categories', href: '#' }]"></b-breadcrumb>
    <b-alert v-for="(error, index) in categories.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
    <div v-if="categories.loading">Loading</div>
    <div v-else>
      <div class="newOpt">
        <button class="btn btn-secondary" @click="$router.push({ name: 'AdminCategoriesCreate'});">New Category</button>
      </div>
      <b-card header="Categories" header-tag="header">
        <table id="admincategories" class="table table-sm table-hover">
          <thead>
            <tr>
              <th>Category</th>
              <th>Description</th>
              <!-- <th>Number of Challenges</th> -->
              <th style="text-align: right;">Options</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="category in categories.data" v-bind:key="category.id">
              <td>{{category.name}}</td>
              <td>{{category.description}}</td>
              <!-- <td>Blah</td> -->
              <td>
                <div>
                  <RemoveCategory :category="category" />
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminCategoryEdit', params: { category: category } }">Edit</router-link>
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
import RemoveCategory from "@/components/admin/remove/category.vue";

export default {
  name: "AdminCategory",
  components: {
    RemoveCategory
  },
  computed: {
    ...mapGetters({
      categories: "categories/GET_CATEGORIES"
    })
  },
  beforeMount() {
    this.$store.dispatch("categories/FETCH_CATEGORIES");
  }
};
</script>