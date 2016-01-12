Chart.types.Line.extend({
    name: "LineYLegend",
    draw: function () {
        Chart.types.Line.prototype.draw.apply(this, arguments);

        var ctx = this.chart.ctx;
        ctx.save();
        // text alignment and color
        ctx.textAlign = "center";
        ctx.textBaseline = "bottom";
        ctx.fillStyle = this.options.scaleFontColor;
        ctx.font = "20px Arial"
        // position
        var x = this.scale.xScalePaddingLeft * 0.4;
        var y = this.chart.height / 2;
        // change origin
        ctx.translate(x, y)
        // rotate text
        ctx.rotate(-90 * Math.PI / 180);
        ctx.fillText(this.datasets[0].label, 0, 0);
        ctx.restore();
    }
});

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
    var myNewChart = new Chart(ctx).LineYLegend(graphData, { scaleLabel: "         <%=value%>"});
  }

  d3.csv(file_name, type, function (error, values) {
    draw(values);
  })

}
