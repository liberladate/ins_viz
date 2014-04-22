function graph_for_data(file_name, measure_unit) {

    function range_for_ani(values) {
        return [values[0].ani, values[values.length - 1].ani];
    }

    function min(values) {
        return d3.min(values, function (d) {
            return d.valoare;
        });
    }

    function max(values) {
        return d3.max(values, function (d) {
            return d.valoare;
        });
    }

    function type(d) {
        d.ani = parse(d["Ani"].split('Anul ')[1]);
        d.valoare = parseFloat($.trim(d['Valoare']))
        return d;
    }

    var margin = {top: 80, right: 80, bottom: 80, left: 80};

    var width = 960 - margin.left - margin.right;
    var height = 500 - margin.top - margin.bottom;

    var parse = d3.time.format("%Y").parse

    var x = d3.time.scale().range([0, width]);
    var y = d3.scale.linear().range([height, 0]);

    var xAxis = d3.svg.axis().scale(x).tickSize(-height).tickSubdivide(true);
    var yAxis = d3.svg.axis().scale(y).ticks(2).orient("right");

    var area = d3.svg.area()
        .interpolate("monotone")
        .x(function (d) {
            return x(d.ani);
        })
        .y0(height)
        .y1(function (d) {
            return y(d.valoare);
        });


    var line = d3.svg.line()
        .interpolate("monotone")
        .x(function (d) {
            return x(d.ani);
        })
        .y(function (d) {
            return y(d.valoare);
        });

    d3.csv(file_name, type, function (error, values) {

        console.log(values);
        x.domain(range_for_ani(values));
        y.domain([min(values), max(values)]).nice();

        // Add an SVG element with the desired dimensions and margin.
        var svg = d3.select("#graph_area").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        // Add the area path.
        svg.append("path")
            .attr("class", "area")
            .attr("clip-path", "url(#clip)")
            .attr("d", area(values));

        // Add the x-axis.
        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        // Add the y-axis.
        svg.append("g")
            .attr("class", "y axis")
            .attr("transform", "translate(" + width + ",0)")
            .call(yAxis);

        // Add the line path.
        svg.append("path")
            .attr("class", "line")
            .attr("clip-path", "url(#clip)")
            .attr("d", line(values));

        svg.append("text")
            .attr("x", width + 6)
            .attr("y", -6)
            .attr("font-size", "16px")
            .style("text-anchor", "end")
            .text(measure_unit);


    });

}

