<script>
import { api } from "@/utils/api";
import { Bar } from "vue-chartjs";

export default {
  extends: Bar,
  data() {
    return {
      graphloading: true,
      chartdata: {
        labels: [],
        datasets: [
          {
            label: "Solves",
            backgroundColor: "#d4ecda",
            data: []
          },
          {
            label: "Failures",
            backgroundColor: "#f8d7da",
            data: []
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true
              }
            }
          ]
        }
      }
    };
  },
  computed: {
    getlabels() {
      return this.$store.getters.graphlabels;
    }
  },
  beforeMount() {
    let self = this;
    api(
      "query { categories{ name challenges{ solvedchallengeSet{ id } failureSet { id } } } }"
    ).then(response => {
      response.data.categories.forEach(function(element) {
        self.chartdata.labels.push(element.name);

        var solves = 0;
        var failures = 0;
        element.challenges.forEach(function(solveset) {
          solves += solveset.solvedchallengeSet.length;
          failures += solveset.failureSet.length;
        });
        self.chartdata.datasets[0].data.push(solves);
        self.chartdata.datasets[1].data.push(failures);
      });

      self.graphloading = false;
      self.renderChart(this.chartdata, this.options);
    });
  },
  //   mounted() {
  //     // this.renderLineChart();
  //     this.renderChart(this.chartdata, this.options);
  //   },
  methods: {
    renderLineChart: function() {
      this.renderChart(
        {
          labels: this.graphlabels,
          datasets: this.graphdata
        },
        { responsive: true, maintainAspectRatio: false }
      );
    }
  }
  //   watch: {
  //     getlabels: function() {
  //       this.$data._chart.update();
  //       this.renderLineChart();
  //     }
  //   }
};
</script>

<style scoped>
</style>