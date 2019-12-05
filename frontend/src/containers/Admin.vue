<template>
  <div id="app">
    <b-navbar toggleable="md" type="dark" variant="dark">
      <b-navbar-toggle target="main_nav_collapse"></b-navbar-toggle>

      <b-navbar-brand @click="$router.push({ name: 'Home'});" style="cursor: pointer;">
        <img src="/static/img/logo.png" alt="YACF" height="25" />
      </b-navbar-brand>

      <b-collapse is-nav id="main_nav_collapse">
        <b-navbar-nav></b-navbar-nav>

        <b-navbar-nav class="ml-auto">
          <b-nav-item v-if="superuser" @click="$router.push({ name: 'Home'});">Home</b-nav-item>
          <b-nav-item v-else @click="$router.push(`/team/${$store.getters['user/userteam']}`);">{{this.$store.getters['user/userteam']}}</b-nav-item>

          <template v-if="auth">
            <b-nav-item-dropdown right>
              <template slot="button-content">
                <span>{{username}}</span>
              </template>
              <b-dropdown-item @click="$router.push(`/profile`);">Profile</b-dropdown-item>
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

    <b-navbar toggleable="md" type="dark" variant="dark">
      <b-navbar-toggle target="main_nav_collapse"></b-navbar-toggle>

      <b-collapse is-nav id="main_nav_collapse">
        <b-navbar-nav>
          <b-nav-item @click="$router.push({ name: 'AdminMission'});">
            <font-awesome-icon :icon="rocket" id="navbar-icon" style="margin-right:7px;" />Misson Control
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminSolves'});">
            <font-awesome-icon :icon="check" id="navbar-icon" style="margin-right:7px;" />Solves
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminCategories'});">
            <font-awesome-icon :icon="stream" id="navbar-icon" style="margin-right:7px;" />Categories
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminChallenges'});">
            <font-awesome-icon :icon="question" id="navbar-icon" style="margin-right:7px;" />Challenges
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminTeams'});">
            <font-awesome-icon :icon="team" id="navbar-icon" style="margin-right:7px;" />Teams
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminUsers'});">
            <font-awesome-icon :icon="user" id="navbar-icon" style="margin-right:7px;" />Users
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminSurveys'});">
            <font-awesome-icon :icon="poll" id="navbar-icon" style="margin-right:7px;" />Surveys
          </b-nav-item>
          <!-- <b-nav-item @click="$router.push({ name: 'AdminWelcome'});">
            <font-awesome-icon :icon="home" id="navbar-icon" style="margin-right:7px;" />Home Page
          </b-nav-item>-->
          <b-nav-item @click="$router.push({ name: 'AdminPages'});">
            <font-awesome-icon :icon="copy" id="navbar-icon" style="margin-right:7px;" />Pages
          </b-nav-item>
          <b-nav-item @click="$router.push({ name: 'AdminSettings'});">
            <font-awesome-icon :icon="setting" id="navbar-icon" style="margin-right:7px;" />Settings
          </b-nav-item>

          <!-- <b-nav-item v-if="auth" @click="$router.push({ name: 'Challenges'});">Challenges</b-nav-item> -->
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

import {
  faRocket,
  faUsers,
  faUser,
  faCheckDouble,
  faStream,
  faQuestionCircle,
  faHome,
  faCopy,
  faCheck,
  faCog,
  faBars,
  faPollH
} from "@fortawesome/free-solid-svg-icons";

export default {
  name: "DefaultContainer",
  data() {
    return {
      pages: [],
      settings: {
        name: "",
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
    },
    rocket() {
      return faRocket;
    },
    check() {
      return faCheckDouble;
    },
    team() {
      return faUsers;
    },
    user() {
      return faUser;
    },
    stream() {
      return faStream;
    },
    question() {
      return faQuestionCircle;
    },
    home() {
      return faHome;
    },
    copy() {
      return faCopy;
    },
    setting() {
      return faCog;
    },
    bars() {
      return faBars;
    },
    poll() {
      return faPollH;
    }
  },
  created() {
    let self = this;
    api("query { pages{ id url name } }").then(response => {
      self.pages = response.data.pages;
    });
    api("query { event{ id name start end } }").then(response => {
      self.settings.name = response.data.event.name;
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

<style>
body {
  background-color: #f3f3f3;
}
#app {
  background-color: #f3f3f3;
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
}
#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
.footer {
  position: relative;
  margin-top: -150px; /* negative value of footer height */
  height: 150px;
  clear: both;
  padding-top: 20px;
}
</style>
