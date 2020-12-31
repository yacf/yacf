<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } },{ text: 'Categories', href: '#' }]"></b-breadcrumb>
    <b-alert v-for="(error, index) in categories.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
    <div v-if="categories.loading">Loading</div>
    <div v-else>
      <b-row>
        <b-col md="6">
          <div>
            <button class="btn btn-secondary" @click="$router.push({ name: 'AdminCategoriesCreate'});">New Category</button>
          </div>
        </b-col>
        <b-col md="6">
          <pagination :count="categoriesCount" @clicked="emitevent" />
        </b-col>
      </b-row>
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
            <tr v-for="category in categories" v-bind:key="category.id">
              <td>{{category.name}}</td>
              <td>{{category.description}}</td>
              <!-- <td>Blah</td> -->
              <td>
                <div>
                  <!-- <RemoveCategory :category="category" /> -->
                  <router-link tag="button" class="btn btn-secondary btn-sm" style="float: right" :to="{ name: 'AdminCategoryEdit', query: { id: category.id } }"><b-icon icon="arrow-up-right"></b-icon></router-link>
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
import { categoriesQuery, categoriesCountQuery } from "@/api/queries/categories";
import RemoveCategory from "@/components/admin/remove/category.vue";

export default {
  name: "AdminCategory",
  components: {
    Pagination,
    RemoveCategory
  },
  data() {
    return {
      categories: [],
      categoriesCount: 0,
      page: 1,
      rows: 25,
    }
  },
  apollo: {
    categories: {
      query: categoriesQuery('id name description'),
      variables() {
        return {
          skip: (this.page - 1) * this.rows,
          first: this.rows,
        };
      },
    },
    categoriesCount: {
      query: categoriesCountQuery()
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