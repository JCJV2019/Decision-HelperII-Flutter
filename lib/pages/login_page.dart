import 'package:decision_helper2/components/drawer_decision_helper.dart';
import 'package:decision_helper2/helpers/helpers.dart';
import 'package:decision_helper2/models/login_model.dart';
import 'package:decision_helper2/pages/homebody_page.dart';
import 'package:decision_helper2/pages/register_page.dart';
import 'package:decision_helper2/providers/helper_provider.dart';
import 'package:decision_helper2/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController emailControler = TextEditingController(text: "cjordan@gmail.com");
  // TextEditingController passwordControler = TextEditingController(text: "12345");

  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDecisionHelper(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topCenter,
            child: Container(
              //color: Colors.red,
              constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: 300,
                        child: Text("Login Page",
                            style: TextStyle(fontSize: 32),
                            textAlign: TextAlign.start),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: emailControler,
                        keyboardType: TextInputType.emailAddress,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "Email/Username",
                            icon: Icon(Icons.person_outline,
                                color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if (!Helpers.isEmail(text)) {
                            return "Incorrect email format";
                          }
                          return null; // si esta ok
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: passwordControler,
                        obscureText: true,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "password",
                            icon:
                                Icon(Icons.lock_outline, color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if (text.length < 5) {
                            return "password needs >=5 characters length";
                          } else if (text.length > 10) {
                            return "password must be <= 10 characters";
                          }
                          return null; // si esta ok
                        }),
                    SizedBox(height: 10),
                    if (isLoading)
                      CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    if (!isLoading)
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.amber),
                            onPressed: () async {
                              var helperProvider = Provider.of<HelperProvider>(
                                  context,
                                  listen: false);

                              if (_formKey.currentState!.validate()) {
                                print("Form is valid");
                                FocusScope.of(context).unfocus();

                                var email = emailControler.text;
                                var password = passwordControler.text;

                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  Login response =
                                      await AuthRepo().signIn(email, password);

                                  if (response.token != "") {
                                    helperProvider.idUser = response.idUser;
                                    helperProvider.nameUser = response.nameUser;
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    throw Exception(
                                        "Email or Password incorrect.");
                                  }
                                } catch (error) {
                                  print("LOGIN ERROR $error");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text("$error"),
                                          action: SnackBarAction(
                                            label: "OK",
                                            onPressed: () {},
                                          )));
                                }
                              } else {
                                print("Form is not valid");
                              }
                            },
                            child: Text("Sign In")),
                      ),
                    SizedBox(height: 10),
                    Container(
                        child: InkWell(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterPage()),
                              );
                            }))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
