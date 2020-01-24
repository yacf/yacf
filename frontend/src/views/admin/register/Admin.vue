<template>
  <div class="container">
    <b-row class="justify-content-center">
      <b-col md="6" sm="8">
        <b-card no-body class="mx-4">
          <b-card-body class="p-4">
            <b-form>
              <h1>Register</h1>
              <b-alert v-for="(error, index) in _key.errors" :key="index" show variant="danger">{{error.message}}</b-alert>

              <template v-if="_key.code !== 0">
                <p class="text-muted">Enter Registration Key</p>
                <b-form-input type="text" class="form-control" placeholder="Key" v-model="key" v-on:keyup.enter="validate()" autofocus />

                <b-button variant="danger" block @click="validate">Validate Key</b-button>
              </template>

              <template v-else>
                <b-alert v-for="(error, index) in _admin.errors" :key="index" show variant="danger">{{error.message}}</b-alert>

                <p class="text-muted">Create your account</p>

                <b-form-input type="text" class="form-control" placeholder="Username" v-model="username" autocomplete="username" />
                <b-form-input type="text" class="form-control" placeholder="First Name" v-model="firstname" autocomplete="firstname" />
                <b-form-input type="text" class="form-control" placeholder="Last Name" v-model="lastname" autocomplete="lastname" />
                <b-form-input type="password" class="form-control" placeholder="Password" v-model="password1" autocomplete="password1" />
                <b-form-input type="password" class="form-control" placeholder="Repeat password" v-model="password2" autocomplete="password2" />
                <b-button variant="danger" block @click="create">Create Account</b-button>
              </template>
            </b-form>
          </b-card-body>
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "Register",
  data() {
    return {
      key: "",
      username: "",
      firstname: "",
      lastname: "",
      password1: "",
      password2: "",
      message: ""
    };
  },
  computed: {
    ...mapGetters({
      _key: "user/key",
      _admin: "user/get_admin",
      _code: "user/get_admin_code"
    })
  },
  watch: {
    _code(new_code, old_code) {
      new_code === 0 ? this.$router.push({ name: "AdminMission" }) : null;
    }
  },
  methods: {
    validate() {
      this.$store.dispatch("user/FETCH_VALIDATE_KEY", { key: this.key });
    },
    create() {
      if (this.password1 !== this.password2) {
        this.message = "Passwords do not match";
      } else if (
        this.username &&
        this.firstname &&
        this.lastname &&
        this.password1
      ) {
        this.$store.dispatch("user/CREATE_ADMIN", {
          key: this.key,
          firstname: this.firstname,
          lastname: this.lastname,
          username: this.username,
          password: JSON.stringify(this.password1)
        });
      } else {
        this.message = "Missing required feilds";
      }
    }
  }
};
</script>