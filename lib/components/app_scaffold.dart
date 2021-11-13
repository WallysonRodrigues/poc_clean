import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final List<Widget>? actions;
  const AppScaffold({required this.child, this.title, this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: child,
      ),
      appBar: AppBar(
        title: title,
        actions: actions,
      ),
    );
  }
}
