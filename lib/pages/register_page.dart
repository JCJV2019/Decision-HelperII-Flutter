
import 'package:decision_helper2/components/drawer_decision_helper.dart';
import 'package:decision_helper2/helpers/helpers.dart';
import 'package:decision_helper2/models/login_model.dart';
import 'package:decision_helper2/pages/login_page.dart';
import 'package:decision_helper2/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController userControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController confirmPasswordControler = TextEditingController();

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
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        width: 300,
                        child: Text("Register Page",
                            style: TextStyle(fontSize: 32),
                            textAlign: TextAlign.start),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: userControler,
                        keyboardType: TextInputType.text,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "Username",
                            icon: Icon(Icons.person_outline,color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if(text.length < 6){
                            return "Username must be more than 5 characters.";
                          }
                          return null; // si esta ok
                        }
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: emailControler,
                        keyboardType: TextInputType.emailAddress,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "Email",
                            icon: Icon(Icons.email,color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if (!Helpers.isEmail(text)) {
                            return "Incorrect email format";
                          }
                          return null; // si esta ok
                        }
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: passwordControler,
                        obscureText: true,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "password",
                            icon: Icon(Icons.lock_outline,color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if(text.length < 5){
                            return "password needs >=5 characters length";
                          } else if(text.length > 10){
                            return "password must be < 10 characters";
                          }
                          return null; // si esta ok
                        }
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: confirmPasswordControler,
                        obscureText: true,
                        decoration: Helpers.buildInputDecoration(
                            hintText: "Confirm password",
                            icon: Icon(Icons.lock_outline,color: Colors.amber)),
                        validator: (text) {
                          text ??= "";
                          if(text.length < 5){
                            return "password needs >=5 characters length";
                          } else if(text.length > 10) {
                            return "password must be < 10 characters";
                          } else if (text != passwordControler.text) {
                            return "passwords are different";
                          }
                          return null; // si esta ok
                        }
                    ),
                    SizedBox(height: 10),
                    if (isLoading)
                      CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    if (!isLoading)
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.amber),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print("Form is valid");
                                FocusScope.of(context).unfocus();

                                var user = userControler.text;
                                var email = emailControler.text;
                                var password = passwordControler.text;

                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Login response = await AuthRepo().signUp(user, email, password);
                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (response.message == "Sing-up Ok") {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (_) => LoginPage()),
                                            (Route<dynamic> route) => false
                                    );
                                  } else {
                                    throw Exception("Email or Password incorrect.");
                                  }

                                } catch(error) {
                                  print("REGISTER ERROR");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text("$error"),
                                      action: SnackBarAction(
                                        label: "OK",
                                        onPressed: () {},
                                      )
                                  ));
                                }

                              } else {
                                print("Form is not valid");
                              }
                            },
                            child: Text("Sign Up")),
                      ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

}
