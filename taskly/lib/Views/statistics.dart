import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:testt/Controllers/TaskController.dart';

class StatisticsScreen extends StatelessWidget {

  StatisticsScreen({super.key});

  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {

    final doneCount = _taskController.tasks.where((task) => task.isDone).length;
    final pendingCount = _taskController.tasks.where((task) => !task.isDone).length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 163, 228),
        title: Text(
         'Statistics',
         style: TextStyle(
          fontSize: 24,
          color: Colors.black,
         ),
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 144, 115, 190),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Task Completion Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.3,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(value: doneCount.toDouble(), color: Colors.green, title: 'Done'),
                      PieChartSectionData(value: pendingCount.toDouble(), color: Colors.red, title: 'Pending'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text('Task Distribution', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: (_taskController.tasks.length + 2).toDouble(),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: doneCount.toDouble(), color: Colors.green)]),
                      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: pendingCount.toDouble(), color: Colors.red)]),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('Done');
                            case 1:
                              return Text('Pending');
                            default:
                              return Text('');
                          }
                        }),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
