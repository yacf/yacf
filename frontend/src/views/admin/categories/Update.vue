<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } }, { text: 'Categories', to: { name: 'AdminCategories' } },{ text: 'Update', href: '#' }]"></b-breadcrumb>
    <b-card header="Update Category">
      <b-alert v-for="(error, index) in update.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
      <b-alert v-if="update.code === 0" show variant="success">Category Updated</b-alert>
      <div v-if="category">
        <label>Category name:</label>
        <input class="form-control" v-model="category.name" />
        <label>Category Description:</label>
        <textarea class="form-control" rows="7" v-model="category.description"></textarea>
        <hr />
        <button class="btn btn-secondary" @click="updateA()">Update</button>
      </div>
      <div v-else>Redirect.. You cannot access this page directly</div>
    </b-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "Category",
  props: ["category"],
  computed: {
    ...mapGetters({
      update: "categories/GET_UPDATE"
    })
  },
  beforeMount() {
    this.$store.commit("categories/SET_UPDATE_DEFAULT");
  },
  methods: {
    updateA() {
      this.$store.dispatch("categories/UPDATE_CATEGORY", {
        id: this.category.id,
        name: this.category.name,
        description: this.category.description
      });
    }
  }
};
</script>