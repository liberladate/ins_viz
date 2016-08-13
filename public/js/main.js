function graph_for_data(file_name, measure_unit) {
  var ctx = $("#graph_area").get(0).getContext("2d");

  function type(d) {
      d.ani = d["Ani"].split('Anul ')[1];
      d.valoare = parseFloat($.trim(d['Valoare']))
      return d;
  }

  function draw(data) {
      var barColor = "rgba(192, 194, 195, 0.7)";
      var graphData = {
      labels: data.map(function(item) {return item.ani}),
      datasets: [
          {
              label: measure_unit,
              backgroundColor: barColor,
              data: data.map(function(item) {return item.valoare})
          }
        ]
      };

      new Chart(ctx, {
          type: 'bar',
          data: graphData,
          options: {
              scales: {
                      yAxes: [{
                          ticks: {
                              min: 0,
                              beginAtZero: true
                          }
                      }],
                      xAxes: [{
                          gridLines: {
                              drawOnChartArea: false
                          }
                      }]
                  }
          }
      })
  }

  d3.csv(file_name, type, function (error, values) {
    draw(values);
  })

}
