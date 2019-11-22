<template>
  <div class="d-flex" v-bind:class="[menu ? '' : 'toggled']" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-light" id="sidebar-wrapper">
      <div class="sidebar-heading">YACF ADMIN</div>
      <div class="list-group list-group-flush">
        <span class="text-muted" id="sidebar-nav-heading">Operations</span>

        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminMission' }">
          <font-awesome-icon :icon="rocket" id="navbar-icon" />
          <span id="sidebar-nav-value">Mission Control</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminSolves' }">
          <font-awesome-icon :icon="check" id="navbar-icon" />
          <span id="sidebar-nav-value">Solves</span>
        </router-link>

        <span class="text-muted" id="sidebar-nav-heading">Event</span>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminCategories' }">
          <font-awesome-icon :icon="stream" id="navbar-icon" />
          <span id="sidebar-nav-value">Categories</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminChallenges' }">
          <font-awesome-icon :icon="question" id="navbar-icon" />
          <span id="sidebar-nav-value">Challenges</span>
        </router-link>

        <span class="text-muted" id="sidebar-nav-heading">Accounts</span>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminTeams' }">
          <font-awesome-icon :icon="team" id="navbar-icon" />
          <span id="sidebar-nav-value">Teams</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminUsers' }">
          <font-awesome-icon :icon="user" id="navbar-icon" />
          <span id="sidebar-nav-value">Users</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminSurveys' }">
          <font-awesome-icon :icon="poll" id="navbar-icon" />
          <span id="sidebar-nav-value">Surveys</span>
        </router-link>

        <span class="text-muted" id="sidebar-nav-heading">Configuration</span>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminWelcome' }">
          <font-awesome-icon :icon="home" id="navbar-icon" />
          <span id="sidebar-nav-value">Home</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminPages' }">
          <font-awesome-icon :icon="copy" id="navbar-icon" />
          <span id="sidebar-nav-value">Pages</span>
        </router-link>
        <router-link tag="link" class="bg-light" id="sidebar-nav-item" :to="{ name: 'AdminSettings' }">
          <font-awesome-icon :icon="setting" id="navbar-icon" />
          <span id="sidebar-nav-value">Settings</span>
        </router-link>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
      <!-- <button class="btn btn-primary" id="menu-toggle" @click="menu = !menu">Toggle Menu</button> -->

      <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom">
        <button class="btn" id="menu-toggle" style="color:white;" @click="menu = !menu">
          <font-awesome-icon :icon="bars" />
        </button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/scoreboard">Scoreboard</a>
            </li>
          </ul>
        </div>
      </nav>
      <div class="content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script>
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
  name: "Test",
  computed: {
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

  data() {
    return {
      menu: true
    };
  }
};
</script>