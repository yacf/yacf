import Vue from "vue";
import Router from "vue-router";

import { base, graud, superusergraud } from "@/router/guards";

Vue.use(Router);

export default new Router({
  mode: "history",
  linkActiveClass: "open active",
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    {
      path: "/",
      component: () => import("@/containers/Default"),
      redirect: { name: "Home" },
      name: "Root",
      children: [
        {
          path: "/_",
          name: "Home",
          component: () => import("@/views/Home")
        },
        {
          path: "/challenges",
          name: "Challenges",
          beforeEnter: graud,
          component: () => import("@/views/Challenges")
        },
        {
          path: "/challenge/:category/:points",
          name: "Statistics",
          beforeEnter: graud,
          component: () => import("@/views/Statistics")
        },
        {
          path: "/scoreboard",
          name: "Scoreboard",
          beforeEnter: graud,
          component: () => import("@/views/Scoreboard")
        },
        {
          path: "/page/:url",
          name: "Page",
          component: () => import("@/views/Page")
        },
        {
          path: "/team/:name",
          name: "Team",
          beforeEnter: graud,
          component: () => import("@/views/Team")
        },
        {
          path: "/profile",
          name: "Profile",
          beforeEnter: graud,
          component: () => import("@/views/Profile")
        }
      ]
    },
    {
      path: "/admin",
      component: () => import("@/containers/Admin"),
      redirect: { name: "AdminMission" },
      name: "Admin",
      beforeEnter: superusergraud,
      children: [
        {
          path: "/admin/mission",
          name: "AdminMission",
          component: () => import("@/views/admin/Mission")
        },
        {
          path: "/admin/solves",
          name: "AdminSolves",
          component: () => import("@/views/admin/Solves")
        },
        {
          path: "/admin/categories",
          name: "AdminCategories",
          component: () => import("@/views/admin/categories/Categories")
        },
        {
          path: "/admin/category/create",
          name: "AdminCategoriesCreate",
          component: () => import("@/views/admin/categories/Create")
        },
        {
          path: "/admin/category/update",
          name: "AdminCategoryEdit",
          component: () => import("@/views/admin/categories/Update"),
          props: true
        },
        {
          path: "/admin/challenges",
          name: "AdminChallenges",
          component: () => import("@/views/admin/challenges/Challenges")
        },
        {
          path: "/admin/challenge/create",
          name: "AdminChallengesCreate",
          component: () => import("@/views/admin/challenges/Create")
        },
        {
          path: "/admin/challenge/update",
          name: "AdminChallengeEdit",
          component: () => import("@/views/admin/challenges/Update"),
          props: true
        },
        {
          path: "/admin/teams",
          name: "AdminTeams",
          component: () => import("@/views/admin/teams/Teams")
        },
        {
          path: "/admin/teams/create",
          name: "AdminTeamsCreate",
          component: () => import("@/views/admin/teams/Create")
        },
        {
          path: "/admin/team/update",
          name: "AdminTeamEdit",
          component: () => import("@/views/admin/teams/Update"),
          props: true
        },
        {
          path: "/admin/users",
          name: "AdminUsers",
          component: () => import("@/views/admin/Users")
        },
        {
          path: "/admin/user/edit",
          name: "AdminUserEdit",
          component: () => import("@/views/admin/Edit/User"),
          props: true
        },
        {
          path: "/admin/surveys",
          name: "AdminSurveys",
          component: () => import("@/views/admin/Surveys")
        },
        {
          path: "/admin/welcome",
          name: "AdminWelcome",
          component: () => import("@/views/admin/Welcome")
        },
        {
          path: "/admin/pages",
          name: "AdminPages",
          component: () => import("@/views/admin/Pages")
        },
        {
          path: "/admin/pages/create",
          name: "AdminCreatePages",
          component: () => import("@/views/admin/Create/Page")
        },
        {
          path: "/admin/pages/edit",
          name: "AdminEditPages",
          props: true,
          component: () => import("@/views/admin/Edit/Page")
        },
        {
          path: "/admin/settings",
          name: "AdminSettings",
          component: () => import("@/views/admin/Settings")
        },
        {
          path: "/admin/logs",
          name: "AdminLogs",
          component: () => import("@/views/admin/Logs")
        }
      ]
    },
    // {
    //   path: "/admindev",
    //   name: "AdminDev",
    //   beforeEnter: base,
    //   component: () => import("@/containers/Dev")
    // },
    {
      path: "/login",
      name: "Login",
      beforeEnter: base,
      component: () => import("@/views/Login")
    },
    {
      path: "/register/user",
      name: "RegisterUser",
      beforeEnter: base,
      component: () => import("@/views/Register/User")
    },
    {
      path: "/admin/register",
      name: "RegisterAdmin",
      beforeEnter: base,
      component: () => import("@/views/admin/register/Admin")
    },
    {
      path: "/register/team",
      name: "RegisterTeam",
      beforeEnter: base,
      component: () => import("@/views/Register/Team")
    },
    {
      path: "*",
      beforeEnter: base,
      component: () => import("@/views/errors/404")
    }
  ]
});
