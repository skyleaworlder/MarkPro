import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:mark_pro/api/log.dart';
import 'package:mark_pro/components/layout.dart';
import 'package:mark_pro/utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var random = Random();
    var data = <PieSales>[];
    for (var i = 0; i < 6; i++) {
      data.add(PieSales(
        i, random.nextInt(100),
        ColorUtil.fromDartColor(ColorWrap.get(i))
      ));
    }

    var seriesList = [
      Series<PieSales, int>(
        id: 'Sales',
        domainFn: (PieSales sales, _) => sales.year,
        measureFn: (PieSales sales, _) => sales.sales,
        colorFn: (PieSales sales, _) => sales.color,
        data: data,
        labelAccessorFn: (PieSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
    return Layout(
      title: "MarkPro",
      child: Container(
        color: Colors.white,
        child: PieChart(
          seriesList,
          animate: true,
          defaultRenderer: ArcRendererConfig<Object>(
            arcRatio: 0.3,
          ),
        ),
      ),
    );
  }
}

class PieSales {
  final int year;
  final int sales;
  final Color color;
  PieSales(this.year, this.sales, this.color);
}