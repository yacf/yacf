<template>
  <div style="float: right;">
    <!-- Modal Component -->
    <button class="btn btn-sm btn-danger" v-b-modal="page.id" style="margin-left: 5px;">Remove</button>
    <b-modal v-bind:id="page.id" v-bind:title="title" ok-title="Confirm Remove" ok-variant="danger" @ok="handleOk">
      <p>
        Are you sure you want to
        <strong>delete {{page.name}}</strong>? This action cannot be undone.
      </p>
      <label>Enter Page name for confirmation</label>
      <input class="form-control" v-model="confirm" />
      {{message}}
    </b-modal>
  </div>
</template>

<script>
import { api } from "@/utils/api.js";

export default {
  name: "DeletePage",
  props: ["page"],
  data() {
    return {
      confirm: "",
      message: ""
    };
  },
  computed: {
    title() {
      return "Deleting " + this.page.name;
    }
  },
  methods: {
    handleOk(evt) {
      console.log("Delete");
      evt.preventDefault();

      let self = this;
      if (this.confirm === this.page.name) {
        api(`mutation { deletePage(id:${this.page.id}){ message } }`).then(
          data => {
            self.message = data.deletePage.message;
          }
        );
      } else {
        self.message = "Page was not deleted. Confirmation incorrect";
      }
    }
  }
};
</script>

<style scoped>
.stats {
  color: black;
  text-align: center;
  cursor: pointer;
  margin-bottom: 0;
}
.stats:hover {
  text-decoration: underline;
}
label {
  margin-top: 10px;
  margin-bottom: 0px;
}
</style>