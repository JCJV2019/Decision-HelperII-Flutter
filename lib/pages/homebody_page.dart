
import 'package:decision_helper2/components/drawer_decision_helper.dart';
import 'package:decision_helper2/components/exit_apply.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDecisionHelper(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: ExitApply()
    );
  }
}
