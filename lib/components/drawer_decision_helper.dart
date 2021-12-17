import 'package:decision_helper2/models/question_model.dart';
import 'package:decision_helper2/pages/helper_page.dart';
import 'package:decision_helper2/pages/homebody_page.dart';
import 'package:decision_helper2/pages/list_questions_page.dart';
import 'package:decision_helper2/pages/login_page.dart';
import 'package:decision_helper2/pages/register_page.dart';
import 'package:decision_helper2/providers/helper_provider.dart';
import 'package:decision_helper2/repositories/question_repository.dart';
import 'package:decision_helper2/services/shared_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerDecisionHelper extends StatefulWidget {
  const DrawerDecisionHelper({Key? key}) : super(key: key);

  @override
  State<DrawerDecisionHelper> createState() => _DrawerDecisionHelperState();
}

class _DrawerDecisionHelperState extends State<DrawerDecisionHelper> {
  bool isLogged = false;

  @override
  void initState() {
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    var token = await SharedPreferencesManager().getToken();
    // print("Recupero el Token: ${token}");

    setState(() {
      if (token != null) {
        isLogged = true;
      } else {
        isLogged = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        // HOME
        ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
            leading: Icon(Icons.home, color: Colors.amber),
            title: Text("Home", style: TextStyle(fontSize: 20))),
        // LOGOUT
        if (isLogged)
          ListTile(
            onTap: () async {
              await SharedPreferencesManager().clearData();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (Route<dynamic> route) => false);
            },
            leading: Icon(Icons.logout, color: Colors.amber),
            title: Text("Logout", style: TextStyle(fontSize: 20)),
          ),
        // HELPER
        if (isLogged)
          ListTile(
              onTap: () async {
                var helperProvider =
                    Provider.of<HelperProvider>(context, listen: false);
                try {
                  List<Question> questions =
                      await QuestionRepo().getQuestions();
                  helperProvider.questions = questions;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListQuestionsPage()),
                  );
                } catch (error) {
                  print("Error $error");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error $error"),
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: () {},
                      )));
                }
              },
              leading: Icon(Icons.call_split, color: Colors.amber),
              title: Text("Helper", style: TextStyle(fontSize: 20))),
        // LOGIN
        if (!isLogged)
          ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              leading: Icon(Icons.login, color: Colors.amber),
              title: Text("Login", style: TextStyle(fontSize: 20))),
        // REGISTER
        ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterPage()),
              );
            },
            leading: Icon(Icons.person_add, color: Colors.amber),
            title: Text("Register", style: TextStyle(fontSize: 20))),
      ]),
    );
  }
}
