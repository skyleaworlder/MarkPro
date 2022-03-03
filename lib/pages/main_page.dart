import 'dart:io';
import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:mark_pro/api/log.dart';
import 'package:mark_pro/components/layout.dart';
import 'package:mark_pro/global.dart';
import 'package:mark_pro/utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with UiLoggy {
  static List<String> simpleTodoRespKeys = [
    "today_done", "todo_1d", "todo_3d", "todo_7d"
  ];
  List<PieSimpleInfoItem> pieSimpleInfo = [];
  List<Series<PieSimpleInfoItem, int>> seriesList = [];
  bool isIniting = true;

  @override
  void initState() {
    super.initState();
    initPieInfo();
  }

  @override
  Widget build(BuildContext context) {
    return isIniting
    ? const Center(
      child: CircularProgressIndicator()
    )
    : Layout(
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

  void initPieInfo() async {
    var resp = await simpleTodo({"username": g.username, "token": g.token});
    if (resp == null || resp.statusCode != 200) {
      // TODO: 主界面初始化失败应该有所作为
      return;
    }
    loggy.info("main_page.dart: initPieInfo: response.data: " + resp.data.toString());
    for (var i = 0; i < simpleTodoRespKeys.length; i++) {
      pieSimpleInfo.add(PieSimpleInfoItem(
        simpleTodoRespKeys[i],
        resp.data[simpleTodoRespKeys[i]],
        ColorUtil.fromDartColor(ColorWrap.get(i)),
      ));
    }
    loggy.info("main_page.dart: initPieInfo: pieSimpleInfo: " + pieSimpleInfo.toString());
    // 初始化 series list
    seriesList.add(
      Series<PieSimpleInfoItem, int>(
        id: 'Sales',
        keyFn: (PieSimpleInfoItem i, _) => i.key,
        domainFn: (PieSimpleInfoItem i, _) => i.num,
        measureFn: (PieSimpleInfoItem i, _) => i.num,
        colorFn: (PieSimpleInfoItem i, _) => i.color,
        data: pieSimpleInfo,
        labelAccessorFn: (PieSimpleInfoItem i, _) => i.key,
      )
    );
    setState(() {
      isIniting = false;
    });
    return;
  }
}


class PieSimpleInfoItem {
  final String key;
  final int num;
  final Color color;
  PieSimpleInfoItem(this.key, this.num, this.color);
}