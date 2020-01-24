<template>
  <div>
    <div class="top-section logo" :style="{backgroundColor: $store.state.theme.primary}">
      <div class="frame">
        <img :src="require('@/assets/img/logo-login.png')" alt="YACF" height="200" />
      </div>
    </div>

    <div class="bottom-section text-center" :style="{backgroundColor: $store.state.theme.secondary}">
      <div class="form-signin">
        <p style="color:white;">{{message}}</p>
        <input class="form-control" placeholder="Username" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" v-model="username" />
        <input type="password" class="form-control" placeholder="Password" v-model="password" v-on:keyup.enter="login()" />

        <button class="btn btn-lg btn-block btn-secondary" @click="login()">Sign in</button>

        <p class="mt-5 mb-3 text-muted">
          <!-- <a @click="$router.push({name: "RegisterUser"});">Register Here</a> -->
          <router-link :to="{name: 'RegisterUser'}">Register Here</router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { api } from "@/utils/api";

export default {
  name: "",
  data() {
    return {
      username: "",
      password: "",
      message: ""
    };
  },
  methods: {
    login() {
      let that = this;
      api(
        `mutation { login(username:"${that.username}", password:"${that.password}") { user { id, isSuperuser, username, firstName, lastName, profile{ team { name } } } } }`
      ).then(response => {
        if (response.data.login) {
          that.$store.commit("user/SET_USER", response.data.login.user);
          that.$router.push({ name: "Home" });
        } else {
          that.message = "Login incorrect";
        }
      });
    }
  }
};
</script>

<style scoped>
h3 {
  color: white;
}
p {
  color: white;
}
input {
  margin-top: 5px;
  background-color: #181b1f;
  border-color: black;
}

/* input:focus {
  margin-top: 5px;
  background-color: #181b1f;
  border-color: purple;
  outline: none;
  -webkit-box-shadow: none !important;
  -moz-box-shadow: none !important;
  box-shadow: none !important;
}

button {
  margin-top: 5px;
  background-color: #181b1f;
  border-color: purple;
  color: purple;
} */
</style>