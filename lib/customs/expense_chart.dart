import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const ExpenseChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(seconds: 1),
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 18,
        strokeWidthPx: 0,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPadding: 0,
              showLeaderLines: false,
              outsideLabelStyleSpec: charts.TextStyleSpec(
                fontSize: 14,
                color: charts.MaterialPalette.white,
              ))
        ],
      ),
      behaviors: [
        charts.DatumLegend(
            position: charts.BehaviorPosition.end,
            outsideJustification: charts.OutsideJustification.start,
            horizontalFirst: false,
            desiredMaxColumns: 1,
            cellPadding: EdgeInsets.only(right: 10, bottom: 10, top: 10),
            entryTextStyle: charts.TextStyleSpec(
              fontSize: 14,
              color: charts.MaterialPalette.white,
            ))
      ],
    );
  }
}
