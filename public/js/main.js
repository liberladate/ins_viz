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
              label: "My First dataset",
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
    var myNewChart = new Chart(ctx).Line(graphData, {});
  }

  d3.csv(file_name, type, function (error, values) {
    console.log(values);
    draw(values);
  })

}
