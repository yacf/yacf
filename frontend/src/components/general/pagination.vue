<template>
  <div>
    <b-dropdown :text="displaySize" style="float: right; margin-left: 5px; width: 110px;" class="display-select">
      <b-dropdown-item @click="rows = 15">15</b-dropdown-item>
      <b-dropdown-item @click="rows = 25">25</b-dropdown-item>
      <b-dropdown-item @click="rows = 50">50</b-dropdown-item>
      <b-dropdown-item @click="rows = 100">100</b-dropdown-item>
    </b-dropdown>
    <b-pagination :total-rows="count" v-model="page" :per-page="rows" style="float: right;" />
  </div>
</template>

<script>
export default {
  name: "Pagination",
  props: {
    count: {
      required: true,
    },
  },
  data() {
    return {
      page: 1,
      rows: 15,
    };
  },
  computed: {
    displaySize() {
      return "Rows: " + this.rows;
    },
  },
  watch: {
    page: function () {
      this.$emit("clicked", { page: this.page });
    },
    rows: function () {
      this.$emit("clicked", { rows: this.rows });
    },
  },
};
</script>