
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          //color: Colors.black38,
            alignment: Alignment.topCenter,
            constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
            child: Column(children: [
              Row(children: const [
                Expanded(
                  child: Text("DECISION HELPER",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 62)),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo.jpg"),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2.0)),
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Como funciona",
                                        style: TextStyle(fontSize: 30)),
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Decision Helper",
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                        " es una herramienta sencilla que te ayudará a tomar las dificiles decisiones de la vida :).")
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Escribe los aspectos positivos, los negativos y puntualos de 1 a 4.")
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Cuando creas haber terminado pide el consejo de "),
                                    TextSpan(text: "Decision Helper",
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                  ]),
                            )),

                      ])),
              SizedBox(height: 30),
              Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2.0)),
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Aspectos Positivos",
                                        style: TextStyle(fontSize: 30)),
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Todos aquellos aspectos o valores que creas que puedan influenciar positivamente el resultado de tu elección.")
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Acuerdate de puntuar cada aspecto de menor a mayor 1-4.")
                                  ]),
                            )),
                      ])),
              SizedBox(height: 30),
              Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2.0)),
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Aspectos Negativos",
                                        style: TextStyle(fontSize: 30)),
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Todos aquellos aspectos o valores que creas que puedan influenciar negativamente el resultado de tu elección.")
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Acuerdate de puntuar cada aspecto de menor a mayor 1-4.")
                                  ]),
                            )),
                      ])),
              SizedBox(height: 30),
              Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2.0)),
                  child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Consejo",
                                        style: TextStyle(fontSize: 30)),
                                  ]),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 38.0, right: 38.0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text:
                                        "Cuando quieras saber el consejo de "),
                                    TextSpan(text: "Decision Helper",
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                        " nuestro algoritmo de IA calculará un Match Learning específico y te aconsejará mediante colores ("),
                                    TextSpan(text: "Verde",
                                        style: TextStyle(color: Colors.green)),
                                    TextSpan(
                                        text:
                                        ","),
                                    TextSpan(text: "Ambar",
                                        style: TextStyle(color: Colors.amber)),
                                    TextSpan(
                                        text:
                                        ","),
                                    TextSpan(text: "Rojo",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text:
                                        ") que dejes en manos de "),
                                    TextSpan(text: "Decision Helper",
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                        " tan importantes decisiones."),
                                  ]),
                            )),
                      ])),
            ])),
      ),
    );
  }
}

