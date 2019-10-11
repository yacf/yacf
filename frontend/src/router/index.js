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
      beforeEnter: graud,
      children: [
        {
          path: "/_",
          name: "Home",
          component: () => import("@/views/Home")
        },
        {
          path: "/challenges",
          name: "Challenges",
          component: () => import("@/views/Challenges")
        },
        {
          path: "/challenge/:category/:points",
          name: "Statistics",
          component: () => import("@/views/Statistics")
        },
        {
          path: "/scoreboard",
          name: "Scoreboard",
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
          component: () => import("@/views/Team")
        },
        {
          path: "/admin",
          name: "Admin",
          component: () => import("@/views/Admin"),
          children: [
            {
              path: "/admin/default",
              name: "AdminDefault",
              component: () => import("@/containers/Admin")
            },
            // {
            //   path: "/admin-o/mission",
            //   name: "AdminMission",
            //   component: () => import("@/views/admin/Mission")
            // },
            // {
            //   path: "/admin-o/welcome",
            //   name: "AdminWelcome",
            //   component: () => import("@/views/admin/Welcome")
            // },
            // {
            //   path: "/admin-o/pages",
            //   name: "AdminPages",
            //   component: () => import("@/views/admin/Pages")
            // },

            // {
            //   path: "/admin-o/categories",
            //   name: "AdminCategories",
            //   component: () => import("@/views/admin/Categories")
            // },
            // {
            //   path: "/admin-o/category/edit",
            //   name: "AdminCategoryEdit",
            //   component: () => import("@/views/admin/Edit/Category"),
            //   props: true
            // },
            // {
            //   path: "/admin-o/challenges",
            //   name: "AdminChallenges",
            //   component: () => import("@/views/admin/Challenges")
            // },
            // {
            //   path: "/admin-o/challenge/edit",
            //   name: "AdminChallengeEdit",
            //   component: () => import("@/views/admin/Edit/Challenge"),
            //   props: true
            // },
            // {
            //   path: "/admin-o/teams",
            //   name: "AdminTeams",
            //   component: () => import("@/views/admin/Teams")
            // },
            // {
            //   path: "/admin-o/team/edit",
            //   name: "AdminTeamEdit",
            //   component: () => import("@/views/admin/Edit/Team"),
            //   props: true
            // },
            // {
            //   path: "/admin-o/users",
            //   name: "AdminUsers",
            //   component: () => import("@/views/admin/Users")
            // },
            // {
            //   path: "/admin-o/user/edit",
            //   name: "AdminUserEdit",
            //   component: () => import("@/views/admin/Edit/User"),
            //   props: true
            // },
            // {
            //   path: "/admin-o/solves",
            //   name: "AdminSolves",
            //   component: () => import("@/views/admin/Solves")
            // },
            // {
            //   path: "/admin-o/surveys",
            //   name: "AdminSurveys",
            //   component: () => import("@/views/admin/Surveys")
            // },
            // {
            //   path: "/admin-o/settings",
            //   name: "AdminSettings",
            //   component: () => import("@/views/admin/Settings")
            // },
            {
              path: "/admin-o/scripter",
              name: "AdminScripter",
              component: () => import("@/views/admin/Scripter")
            },
            {
              path: "/admin-o/test",
              name: "Test",
              component: () => import("@/views/admin/Test"),
              props: true
            }
          ],
          beforeEnter: superusergraud
        }
      ]
    },
    {
      path: "/newadminui",
      component: () => import("@/containers/Admin"),
      redirect: { name: "Testi" },
      name: "NewUI",
      beforeEnter: graud,
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
          component: () => import("@/views/admin/Categories")
        },
        {
          path: "/admin/category/edit",
          name: "AdminCategoryEdit",
          component: () => import("@/views/admin/Edit/Category"),
          props: true
        },
        {
          path: "/admin/challenges",
          name: "AdminChallenges",
          component: () => import("@/views/admin/Challenges")
        },
        {
          path: "/admin/challenge/edit",
          name: "AdminChallengeEdit",
          component: () => import("@/views/admin/Edit/Challenge"),
          props: true
        },
        {
          path: "/admin/teams",
          name: "AdminTeams",
          component: () => import("@/views/admin/Teams")
        },
        {
          path: "/admin/team/edit",
          name: "AdminTeamEdit",
          component: () => import("@/views/admin/Edit/Team"),
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
        }
      ]
    },
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
