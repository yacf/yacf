<template>
  <div class="d-flex" v-bind:class="[menu ? '' : 'toggled']" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-light" id="sidebar-wrapper">
      <div class="sidebar-heading">YACF Administrator</div>
      <div class="list-group list-group-flush">
        <span class="text-muted" id="sidebar-nav-heading">Operations</span>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="dash" />
          <span id="sidebar-nav-value">Mission Control</span>
        </a>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="check" />
          <span id="sidebar-nav-value">Solves</span>
        </a>

        <span class="text-muted" id="sidebar-nav-heading">Event</span>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="stream" />
          <span id="sidebar-nav-value">Categories</span>
        </a>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="question" />
          <span id="sidebar-nav-value">Challenges</span>
        </a>

        <span class="text-muted" id="sidebar-nav-heading">Accounts</span>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="team" />
          <span id="sidebar-nav-value">Teams</span>
        </a>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="user" />
          <span id="sidebar-nav-value">Users</span>
        </a>

        <span class="text-muted" id="sidebar-nav-heading">Configuration</span>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="home" />
          <span id="sidebar-nav-value">Home</span>
        </a>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="copy" />
          <span id="sidebar-nav-value">Pages</span>
        </a>
        <a href="#" class="bg-light" id="sidebar-nav-item">
          <font-awesome-icon :icon="setting" />
          <span id="sidebar-nav-value">Settings</span>
        </a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
      <!-- <button class="btn btn-primary" id="menu-toggle" @click="menu = !menu">Toggle Menu</button> -->

      <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom">
        <button class="btn btn-secondary" id="menu-toggle" @click="menu = !menu">
          <font-awesome-icon :icon="bars" />
        </button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item active">
              <a class="nav-link" href="#">
                Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
          </ul>
        </div>
      </nav>

      <div class="offset" style="overflow-y:scroll; height:100vh">
        <b-card-group deck>
          <b-card title="Teams">
            <h1>{{teams}}</h1>
          </b-card>
          <b-card title="Users">
            <h1>{{users}}</h1>
          </b-card>
          <b-card title="Challenges">
            <h1>{{challenges}}</h1>
          </b-card>
          <b-card title="Solves">
            <h1>{{solves.length}}</h1>
          </b-card>
        </b-card-group>

        <hr />
        <b-card header="Progress Graph">
          <Graph />
        </b-card>
        <hr />
        <b-card-group deck>
          <b-card header="Solves">
            <b-alert variant="success" v-for="solve in solves" :key="solve.id" show>({{solve.id}}) {{solve.team.name}} - {{solve.challenge.name}} - {{solve.timestamp}}</b-alert>
          </b-card>
          <b-card header="Failures">
            <b-alert variant="danger" v-for="failure in failures" :key="failure.id" show>({{failure.id}}) {{failure.team.name}} - {{failure.challenge.name}} - {{failure.timestamp}}</b-alert>
          </b-card>
        </b-card-group>
      </div>
    </div>
    <!-- /#page-content-wrapper -->
  </div>
</template>

<script>
import {
  faTachometerAlt,
  faUsers,
  faUser,
  faCheckDouble,
  faStream,
  faQuestionCircle,
  faHome,
  faCopy,
  faCheck,
  faCog,
  faBars
} from "@fortawesome/free-solid-svg-icons";
import { api } from "@/utils/api";
export default {
  name: "Test",
  components: {
    Graph: () => import("@/components/scoreboard/Graph")
  },
  computed: {
    dash() {
      return faTachometerAlt;
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
    }
  },

  data() {
    return {
      menu: true,
      challenges: 0,
      teams: 0,
      users: 0,
      solves: 0,
      failures: []
    };
  },
  created() {
    let self = this;
    api("query { challenges{ id } }").then(data => {
      self.challenges = data.challenges.length;
    });
    api("query { teams{ id } }").then(data => {
      self.teams = data.teams.length;
    });
    api("query { users{ id } }").then(data => {
      self.users = data.users.length;
    });
    api(
      "query { solves { id team { name } challenge { name } timestamp } }"
    ).then(data => {
      self.solves = data.solves;
    });
    api(
      "query { failures { id team { name } challenge { name } timestamp } }"
    ).then(data => {
      self.failures = data.failures;
    });
  }
};
</script>

<style scoped>
/*!
 * Start Bootstrap - Simple Sidebar (https://startbootstrap.com/template-overviews/simple-sidebar)
 * Copyright 2013-2019 Start Bootstrap
 * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap-simple-sidebar/blob/master/LICENSE)
 */
body {
  overflow-x: hidden;
}

#sidebar-wrapper {
  min-height: 100vh;
  margin-left: -15rem;
  -webkit-transition: margin 0.25s ease-out;
  -moz-transition: margin 0.25s ease-out;
  -o-transition: margin 0.25s ease-out;
  transition: margin 0.25s ease-out;
}

#sidebar-wrapper .sidebar-heading {
  padding: 0.875rem 1.25rem;
  font-size: 1.2rem;
  border-right: 1px solid black;
  color: azure;
  background-color: #272b2f;
}
#sidebar-nav-heading {
  font-weight: bold;
  font-size: 0.75rem;
  text-transform: uppercase;
  position: relative;
  display: block;
  padding: 0.75rem 1.25rem;
  padding-bottom: 0;
}

#sidebar-nav-separator {
  margin: 0;
}

#sidebar-nav-item {
  position: relative;
  display: block;
  padding: 0.75rem 1.25rem;
  width: 100%;
  color: #495057;
  text-align: inherit;
}

#sidebar-nav-value {
  padding-left: 10px;
}

#sidebar-wrapper .list-group {
  width: 15rem;
}

#page-content-wrapper {
  min-width: 100vw;
}

#wrapper.toggled #sidebar-wrapper {
  margin-left: 0;
}

@media (min-width: 768px) {
  #sidebar-wrapper {
    margin-left: 0;
  }

  #page-content-wrapper {
    min-width: 0;
    width: 100%;
  }

  #wrapper.toggled #sidebar-wrapper {
    margin-left: -15rem;
  }
}
</style>