
import 'package:decision_helper2/pages/homebody_page.dart';
import 'package:decision_helper2/providers/helper_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HelperProvider())
      ],
      child: MaterialApp(
          // home: !isLogged ? LoginPage() : HomePage()
        home: HomePage()
      ),
    );
  }
}
