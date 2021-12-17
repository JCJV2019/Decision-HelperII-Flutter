
import 'package:decision_helper2/components/home_body.dart';
import 'package:flutter/material.dart';

class ExitApply extends StatelessWidget {
  const ExitApply({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("¿Seguro que quieres salir?"),
                  actions: [
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                        child: Text("NO")
                    ),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                        child: Text("SI")
                    ),
                  ],
                );
              }
          );
          return value == true;
        },
        child: HomeBody()
    );
  }
}
