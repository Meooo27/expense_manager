import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/expense_model.dart';

class BarChartExpense extends StatefulWidget {
  const BarChartExpense(this.arr, {super.key});
  final List<ExpenseModel> arr;

  @override
  State<StatefulWidget> createState() {
    return _BarChartState();
  }
}

class _BarChartState extends State<BarChartExpense> {
  late int index;
  Map<String, List<ExpenseModel>> mapModels = {};

  @override
  Widget build(BuildContext context) {
    index = 0;
    mapModels.clear();

    for (var model in widget.arr) {
      mapModels.putIfAbsent(model.category.title, () => []);
      mapModels[model.category.title]!.add(model);
    }

    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: widget.arr.length.toDouble(),
      ),
    );
  }

  BarTouchData get barTouchData =>
      BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text = mapModels.entries.elementAt(value.toInt()).value.first.category.title;
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient =>
      LinearGradient(
        colors: [Colors.blue, Colors.lightBlueAccent],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups =>
      mapModels.entries.map((model) =>
          BarChartGroupData(
            x: index++,
            barRods: [BarChartRodData(toY: model.value.length.toDouble(), gradient: _barsGradient)],
            showingTooltipIndicators: [0],
          )
      ).toList();
}

