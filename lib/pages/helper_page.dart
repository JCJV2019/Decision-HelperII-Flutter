
import 'package:decision_helper2/components/drawer_decision_helper.dart';
import 'package:decision_helper2/components/helper_body.dart';
import 'package:flutter/material.dart';

class HelperPage extends StatelessWidget {
  const HelperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDecisionHelper(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: HelperBody()
    );
  }
}
