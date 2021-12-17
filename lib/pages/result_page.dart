
import 'package:flutter/material.dart';

class resultPage extends StatelessWidget {
  Map<String, dynamic> image;

  resultPage({
    Key? key,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Resolución"),
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coeficiente Positivos: ${image["puntuacionP"]}", style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coeficiente Negativos: ${image["puntuacionN"]}", style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(image['message'], style: TextStyle(fontSize: 30)),
              ),
              Container(
                  width:MediaQuery.of(context).size.width,
                  height:400,
                  child:Hero(
                      tag:image,
                      child: Image.asset(image["image"],fit: BoxFit.fitWidth,))

              ),
            ],
          ),
        )
    );
  }
}
