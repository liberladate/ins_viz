function graph_for_data(file_name, measure_unit) {
  var ctx = $("#graph_area").get(0).getContext("2d");

  function type(d) {
      d.ani = d["Ani"].split('Anul ')[1];
      d.valoare = parseFloat($.trim(d['Valoare']))
      return d;
  }

  function draw(data) {
    var graphData = {
      labels: data.map(function(item) {return item.ani}),
      datasets: [
          {
              label: measure_unit,
              fillColor: "rgba(220,220,220,0.3)",
              strokeColor: "rgba(220,220,220,1)",
              pointColor: "rgba(220,220,220,1)",
              pointStrokeColor: "#fff",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "rgba(220,220,220,1)",
              data: data.map(function(item) {return item.valoare})
          }
        ]
      };

      new Chart(ctx, {
          type: 'line',
          data: graphData,
          options: {
              scales: {
                      yAxes: [{
                          ticks: {
                              min: 0,
                              beginAtZero: true
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
