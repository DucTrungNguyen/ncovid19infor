import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ncov19infor/models/models.dart';

class PointsLineChart extends StatelessWidget {
//  final List<charts.Series> seriesList;
  final bool animate;
  final List<TimeLine> listTimeLine;
  final id;
  final Color colorChart;
  final String type;

  PointsLineChart( {
    this.animate,
    this.listTimeLine,
    this.id,
    this.colorChart,
    this.type
  });

//  /// Creates a [LineChart] with sample data and no transition.
//  factory PointsLineChart.withSampleData() {
//    return new PointsLineChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }


  @override
  Widget build(BuildContext context) {

    var seriesCases = [
      charts.Series<TimeLine, DateTime>(

        id: id,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeLine timeline, _) => timeline.time,
        measureFn: (TimeLine timeline, _) => timeline.total_cases,
        data:listTimeLine ,
      )

    ];
    var seriesDeaths = [
      charts.Series<TimeLine, DateTime>(

        id: id,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeLine timeline, _) => timeline.time,
        measureFn: (TimeLine timeline, _) => timeline.total_deaths,
        data:listTimeLine ,
      )

    ];
    var seriesRe = [
      charts.Series<TimeLine, DateTime>(

        id: id,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeLine timeline, _) => timeline.time,
        measureFn: (TimeLine timeline, _) => timeline.total_recoveries,
        data:listTimeLine ,
      )

    ];

    return Padding(
      padding: EdgeInsets.all(15),

      child: SizedBox(
        height: 300,
        child: charts.TimeSeriesChart(
          type == 'C' ? seriesCases : (type == 'D' ? seriesDeaths : seriesRe),
            animate: animate,
            defaultRenderer:  charts.LineRendererConfig(

              includeLine: true,
                stacked: true,
                includeArea: true,
                includePoints: true
            )
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.

}

