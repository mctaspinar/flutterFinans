import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import './expense_chart.dart';
import '../models/expense.dart';

class Header extends StatelessWidget {
  final List<Expense> data;
  const Header(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Expense, String>> _series = [
      charts.Series<Expense, String>(
          id: 'Expense',
          domainFn: (Expense expense, _) => expense.category,
          measureFn: (Expense expense, _) => expense.value,
          labelAccessorFn: (Expense expense, _) => '\₺${expense.value}',
          colorFn: (Expense expense, _) =>
              charts.ColorUtil.fromDartColor(expense.color),
          data: data)
    ];

    final primaryColor = Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height * .4,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 14,
            ),
            Container(
              height: mediaQuery.size.height * .25,
              child: ExpenseChart(
                _series,
                animate: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
