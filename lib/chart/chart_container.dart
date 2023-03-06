import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
     required this.title,
     required this.color,
     required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.75 * 0.65,
        padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
        decoration: BoxDecoration(
          color: color,
          // borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                  // padding: const EdgeInsets.only(top: 10),
                  child: chart,
                ))
          ],
        ),
      ),
    );
  }
}