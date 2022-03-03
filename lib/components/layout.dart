import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String title;
  final Widget child;

  const Layout({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: widget.child,
    );
  }
}