
import 'package:decision_helper2/components/drawer_decision_helper.dart';
import 'package:decision_helper2/components/list_questions.dart';
import 'package:flutter/material.dart';

class ListQuestionsPage extends StatelessWidget {
  const ListQuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerDecisionHelper(),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: ListQuestions()
    );
  }
}
