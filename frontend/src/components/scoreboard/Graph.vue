<script>
import { api } from "@/utils/api";
import { Line } from "vue-chartjs";

export default {
  extends: Line,
  props: ["chartData"],
  // data() {
  //   return {
  //     graphloading: true,
  //     graphlabels: [],
  //     graphdata: [],
  //     options: {
  //       responsive: true,
  //       spanGaps: true,
  //       maintainAspectRatio: false
  //     }
  //   };
  // },
  computed: {
    getlabels() {
      return this.$store.getters.graphlabels;
    }
  },
  beforeMount() {
    let that = this;
    api("mutation{ graph{ timeline, message } }").then(response => {
      that.$store.commit("SET_GRAPH", {
        data: JSON.parse(response.data.graph.message),
        labels: JSON.parse(response.data.graph.timeline)
      });
      that.graphloading = false;
    });
  },
  mounted() {
    this.renderLineChart();
  },
  methods: {
    renderLineChart: function() {
      this.renderChart(
        {
          labels: this.$store.getters.graphlabels,
          datasets: this.$store.getters.graphdata
        },
        { responsive: true, maintainAspectRatio: false, spanGaps: true }
      );
    }
  },
  watch: {
    getlabels: function() {
      this.$data._chart.update();
      this.renderLineChart();
    }
  }
};
</script>

<style scoped>
</style>