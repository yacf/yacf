<template>
  <div class="offset">
    <b-breadcrumb :items="[{ text: 'Mission', to: { name: 'AdminMission' } }, { text: 'Categories', to: { name: 'AdminCategories' } },{ text: 'Create', href: '#' }]"></b-breadcrumb>
    <b-card header="Create Category">
      <b-alert v-for="(error, index) in create.errors" :key="index" show variant="danger">{{error.message}}</b-alert>
      <b-alert v-if="create.code === 0" show variant="success">Category Created</b-alert>

      <label>Category name:</label>
      <input class="form-control" v-model="name" />
      <label>Category Description:</label>
      <textarea class="form-control" rows="7" v-model="description"></textarea>
      <!-- <b-form-checkbox id="checkbox-1" v-model="hidden" name="checkbox-1" value="true" unchecked-value="false">Hidden</b-form-checkbox> -->
      <hr />
      <button v-if="!create.loading" class="btn btn-secondary" @click="addCategory()">Create</button>
      <button v-else class="btn btn-secondary" disabled>Loading..</button>
    </b-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "AddCategory",
  data() {
    return {
      name: "",
      description: "",
      hidden: false
    };
  },
  beforeMount() {
    this.$store.commit("categories/SET_CREATE_DEFAULT");
  },
  computed: {
    ...mapGetters({
      create: "categories/GET_CREATE"
    })
  },
  methods: {
    addCategory() {
      if (this.name && this.description) {
        this.$store.dispatch("categories/CREATE_CATEGORY", {
          name: this.name,
          description: this.description
        });
      }
    }
  }
};
</script>