import 'dart:async';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
//import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final String btc;
  final String eth;
  final String bnb;
  final double limit;
  const ChartWidget({
    super.key,
    required this.btc,
    required this.eth,
    required this.bnb,
    required this.limit,
  });

  final Color btcColor = Colors.blue;
  final Color ethColor = Colors.pink;
  final Color bnbColor = Colors.green;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  final limitCount = 100;
  final btcPoints = <FlSpot>[];
  final ethPoints = <FlSpot>[];
  final bnbPoints = <FlSpot>[];

  double xValue = 0;
  double step = 0.05;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setState(() {
        btcPoints.clear();
        ethPoints.clear();
        bnbPoints.clear();
        for (double i = xValue; i < xValue + 10; i += 0.1) {
          btcPoints.add(FlSpot(i, math.sin(i) * double.parse(widget.btc)));
          ethPoints.add(FlSpot(i, math.cos(i) * double.parse(widget.eth)));
          bnbPoints.add(FlSpot(i, math.cos(i) * double.parse(widget.bnb)));
        }
      });
      xValue += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ethPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'BTC: ${widget.btc}',
                style: TextStyle(
                  color: widget.btcColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ETH: ${widget.eth}',
                style: TextStyle(
                  color: widget.ethColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'BNB: ${widget.bnb}',
                style: TextStyle(
                  color: widget.bnbColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: LineChart(
                    LineChartData(
                      minY: -widget.limit,
                      maxY: widget.limit,
                      minX: btcPoints.first.x,
                      maxX: btcPoints.last.x,
                      lineTouchData: const LineTouchData(enabled: false),
                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        lines(btcPoints, widget.btcColor),
                        lines(ethPoints, widget.ethColor),
                        lines(bnbPoints, widget.bnbColor),
                      ],
                      titlesData: const FlTitlesData(
                        show: false,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData lines(List<FlSpot> points, Color color) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [color.withOpacity(0), color],
        stops: const [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
