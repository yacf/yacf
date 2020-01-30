<template>
  <div id="app">
    <b-navbar toggleable="md" type="dark" variant="dark">
      <b-navbar-toggle target="main_nav_collapse"></b-navbar-toggle>

      <b-navbar-brand @click="$router.push({ name: 'Home'});" style="cursor: pointer;">{{settings.name}} {{this.$store.getters['user/brand']}}</b-navbar-brand>

      <b-collapse is-nav id="main_nav_collapse">
        <b-navbar-nav>
          <template v-if="new Date() > new Date(settings.start)">
            <b-nav-item v-if="auth && !settings.privacy" @click="$router.push({ name: 'Scoreboard'});">Scoreboard</b-nav-item>
            <b-nav-item v-if="auth" @click="$router.push({ name: 'Challenges'});">Challenges</b-nav-item>
          </template>
          <b-nav-item v-for="page in pages" :key="page.id" @click="$router.push({ name: 'Page', params: { 'url': page.url }});">{{page.name}}</b-nav-item>
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto">
          <b-nav-item v-if="superuser" @click="$router.push({ name: 'AdminMission'});">Admin Dashboard</b-nav-item>
          <b-nav-item v-else @click="$router.push(`/team/${$store.getters['user/userteam']}`);">{{this.$store.getters['user/userteam']}}</b-nav-item>

          <template v-if="auth">
            <b-nav-item-dropdown right>
              <template slot="button-content">
                <span>{{username}}</span>
              </template>
              <!-- <b-dropdown-item @click="$router.push(`/profile`);">Profile</b-dropdown-item> -->
              <b-dropdown-item @click="logout">Signout</b-dropdown-item>
            </b-nav-item-dropdown>
          </template>
          <template v-else>
            <b-navbar-nav>
              <b-nav-item @click="$router.push({ name: 'Login'});">Login</b-nav-item>
            </b-navbar-nav>
          </template>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <router-view></router-view>
    <!-- <div class="navbar fixed-bottom">
      <div>
        <span class="text-muted" style="font-size: 12px;">
          &#169;
          <a href="http://yacf.io" target="_blank">YACF</a> 2017-2019 | Currently v1.0.2 Code licensed MIT
        </span>
      </div>
    </div>-->
  </div>
</template>

<script>
import { api } from "@/utils/api";
import { mapGetters } from "vuex";

export default {
  name: "DefaultContainer",
  data() {
    return {
      pages: [],
      settings: {
        name: "",
        privacy: "",
        start: "",
        end: ""
      }
    };
  },
  computed: {
    ...mapGetters({
      theme: "theme/GET_THEME"
    }),
    auth() {
      return localStorage.auth ? localStorage.auth : false;
    },
    username() {
      return localStorage.user ? JSON.parse(localStorage.user).firstName : null;
    },
    superuser() {
      return localStorage.user
        ? JSON.parse(localStorage.user).isSuperuser
        : false;
    }
  },
  created() {
    let self = this;
    api("query { pages{ id url name } }").then(response => {
      self.pages = response.data.pages;
    });
    api("query { event{ id name private start end } }").then(response => {
      console.log(response.data.event);
      self.settings.name = response.data.event.name;
      self.settings.privacy = response.data.event.private;
      self.settings.start = response.data.event.start;
      self.settings.end = response.data.event.end;
    });
  },
  methods: {
    logout() {
      console.log("At logout");
      localStorage.clear();
      this.$store.dispatch("user/logout");
      this.$router.push("/login");
    }
  }
};
</script>