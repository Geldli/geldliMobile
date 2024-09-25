import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/colors.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});
  final Color leftBarColor = colorsForChoice[1];
  final Color rightBarColor = colorsForChoice[0];
  final Color avgColor = myWhite;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

List<double> valoresAtivos = [6, 5, 10, 0, 20, 10, 40, 10, 50, 30, 50, 70];
List<double> valoresDespesas = [50, 50, 0, 10, 20, 40, 30, 20, 50, 30, 50, 70];

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late double maxY;

  @override
  void initState() {
    super.initState();

    // Calcule o maior valor entre valoresAtivos e valoresDespesas
    double maiorValor = (valoresAtivos + valoresDespesas).reduce((a, b) => a > b ? a : b);
    maxY = maiorValor; // Use diretamente o maior valor

    final items = List.generate(12, (index) {
      return makeGroupData(index, valoresAtivos[index], valoresDespesas[index]);
    });

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maxY, // Defina maxY como o maior valor calculado
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return myWhite;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      // O touchCallback pode permanecer como está
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: maxY / 5, // Divida em 5 partes
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromRGBO(245, 245, 245, 0.926),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    if (value % (maxY / 5) == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(value.toString(), style: style),
      );
    }

    return Container();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        titles[value.toInt()],
        style: TextStyle(
          color: myWhite,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
