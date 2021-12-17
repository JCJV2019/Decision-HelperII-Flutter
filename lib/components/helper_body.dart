

import 'package:decision_helper2/helpers/helpers.dart';
import 'package:decision_helper2/models/item_model.dart';
import 'package:decision_helper2/models/question_model.dart';
import 'package:decision_helper2/pages/list_questions_page.dart';
import 'package:decision_helper2/pages/result_page.dart';
import 'package:decision_helper2/providers/helper_provider.dart';
import 'package:decision_helper2/repositories/item_repository.dart';
import 'package:decision_helper2/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelperBody extends StatefulWidget {
  const HelperBody({Key? key}) : super(key: key);

  @override
  _HelperBodyState createState() => _HelperBodyState();
}

class _HelperBodyState extends State<HelperBody> {
  List<Item> itemsPos = [];
  List<Item> itemsNeg = [];
  TextEditingController descQuestion = TextEditingController();
  TextEditingController descNewItem = TextEditingController();
  int _points = 0;
  String _strpoints = "1";
  List<TextEditingController> descItemsPosController = [];
  List<TextEditingController> pointsItemsPosController = [];
  List<TextEditingController> descItemsNegController = [];
  List<TextEditingController> pointsItemsNegController = [];
  bool descQuestionEnabled = true;
  bool questionRecorded = false;

  @override
  initState() {
    var helperProvider = Provider.of<HelperProvider>(context, listen: false);
    descQuestion.text = helperProvider.descQuestion;
    if (descQuestion.text != "") {
      descQuestionEnabled = false;
    }
    itemsPos = helperProvider.itemsPos;
    itemsNeg = helperProvider.itemsNeg;
    //print("idQuestion: ${helperProvider.idQuestion}");
    for (int i = 0; i < itemsPos.length; i++) {
      descItemsPosController.add(TextEditingController());
      descItemsPosController[i].text = itemsPos[i].desc;
      pointsItemsPosController.add(TextEditingController());
      pointsItemsPosController[i].text = itemsPos[i].point;
      //print("VALORES POS : ${descItemsPosController[i].text}");
    }
    for (int i = 0; i < itemsNeg.length; i++) {
      descItemsNegController.add(TextEditingController());
      descItemsNegController[i].text = itemsNeg[i].desc;
      pointsItemsNegController.add(TextEditingController());
      pointsItemsNegController[i].text = itemsNeg[i].point;
      //print("VALORES NEG : ${descItemsNegController[i].text}");
    }
    questionRecorded = descQuestion.text != "" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    var helperProvider = Provider.of<HelperProvider>(context, listen: false);

    return ListView(children: [
      // TITULO PANTALLA
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Text(
              '¿Que duda tienes?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      // PREGUNTA Y BORRAR
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 10.0),
            child: TextField(
                enabled: descQuestionEnabled,
                controller: descQuestion,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)))),
          ),
        ),
        if (questionRecorded) Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              heroTag: "btnDelete",
              onPressed: () async {
                try {
                    var idQuestion = helperProvider.idQuestion;
                    Map<String,dynamic> info = await Helpers.deleteQuestionAll(idQuestion);
                    print("BORRADO DE TODA LA PREGUNTA ${info['question']}");
                    print("Positivos borrados: ${info['nPositives']}");
                    print("Negativos borrados: ${info['nNegatives']}");
                    helperProvider.removeQuestion();
                    // Helpers.ScaffoldMessage(
                    //     "Pregunta borrada, Positivos: ${info['nPositives']} Negativos: ${info['nNegatives']}", context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ListQuestionsPage()),
                    );
                } catch (error) {
                  print("Error $error");
                  Helpers.ScaffoldMessage("Error $error", context);
                }
              },
              child: Icon(Icons.delete, color: Colors.black),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              elevation: 0,
              backgroundColor: Colors.amber,
            ),
          ),
        ),
      ]),
      // ASPECTO NUEVO TITULO
      Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 22.0),
        child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 20,
            child: Text(
              'Descripción de aspecto:',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            )),
      ),
      // ASPECTO NUEVO TEXTO
      Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: TextField(
            controller: descNewItem,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)))),
      ),
      // PUNTUACION RADIO BUTTONS
      radioPoints(),
      // BOTONES DE AÑADIR ASPECTO POSITIVO Y ASPECTO NEGATIVO
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 150,
              child: FloatingActionButton(
                heroTag: "btnAspectPos",
                onPressed: () async {
                  if (descQuestion.text != "" && descNewItem.text != "") {
                    try {
                      if (!questionRecorded) {
                        //print("DescQuestion ${descQuestion.text}");
                        //print("DescNewItem ${descNewItem.text}");
                        // Grabamos la Pregunta
                        var newQ = {
                          "_id": "--",
                          "question": descQuestion.text,
                          "user": helperProvider.idUser
                        };
                        Question newQuestion = Question.fromJson(newQ);
                        Question question =
                            await QuestionRepo().addQuestion(newQuestion);
                        questionRecorded = true;
                        helperProvider.idQuestion = question.id;
                        print("AÑADIMOS PREGUNTA $question");
                      }
                      // Grabamos el item
                      var newI = {
                        "_id": "--",
                        "desc": descNewItem.text,
                        "point": _strpoints,
                        "question": helperProvider.idQuestion,
                        "user": helperProvider.idUser
                      };
                      Item newItem = Item.fromJson(newI);
                      //print("Longitud ${itemsPos.length}");
                      Item item = await ItemRepo().addPositivo(newItem);
                      setState(() {
                        itemsPos.add(item);
                        var newLength = itemsPos.length;
                        descItemsPosController.add(TextEditingController());
                        descItemsPosController[newLength-1].text = item.desc;
                        pointsItemsPosController.add(TextEditingController());
                        pointsItemsPosController[newLength-1].text = item.point;
                        descNewItem.text = "";
                        _points = 0;
                        _strpoints = "1";
                      });
                      //print("Longitud ${itemsPos.length}");
                      print("AÑADIMOS ITEM POSITIVO $item");
                      Helpers.ScaffoldMessage(
                          "Aspecto positivo añadido...", context);
                    } catch (error) {
                      print("Error $error");
                      Helpers.ScaffoldMessage("Error $error", context);
                    }
                  } else {
                    Helpers.ScaffoldMessage(
                        "Se ha de rellenar la descripción de la Pregunta y del Aspecto...",
                        context);
                  }
                },
                child: Text("Aspecto Positivo",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                elevation: 0,
                backgroundColor: Colors.amber,
              ),
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: FloatingActionButton(
                heroTag: "btnAspectNeg",
                onPressed: () async {
                  if (descQuestion.text != "" && descNewItem.text != "") {
                    try {
                      if (!questionRecorded) {
                        //print("DescQuestion ${descQuestion.text}");
                        //print("DescNewItem ${descNewItem.text}");
                        // Grabamos la Pregunta
                        var newQ = {
                          "_id": "--",
                          "question": descQuestion.text,
                          "user": helperProvider.idUser
                        };
                        Question newQuestion = Question.fromJson(newQ);
                        Question question =
                            await QuestionRepo().addQuestion(newQuestion);
                        questionRecorded = true;
                        helperProvider.idQuestion = question.id;
                        print("AÑADIMOS PREGUNTA $question");
                      }
                      // Grabamos el item
                      var newI = {
                        "_id": "--",
                        "desc": descNewItem.text,
                        "point": _strpoints,
                        "question": helperProvider.idQuestion,
                        "user": helperProvider.idUser
                      };
                      Item newItem = Item.fromJson(newI);
                      //print("Longitud ${itemsNeg.length}");
                      Item item = await ItemRepo().addNegativo(newItem);
                      setState(() {
                        itemsNeg.add(item);
                        var newLength = itemsNeg.length;
                        descItemsNegController.add(TextEditingController());
                        descItemsNegController[newLength-1].text = item.desc;
                        pointsItemsNegController.add(TextEditingController());
                        pointsItemsNegController[newLength-1].text = item.point;
                        descNewItem.text = "";
                        _points = 0;
                        _strpoints = "1";
                      });
                      //print("Longitud ${itemsNeg.length}");
                      print("AÑADIMOS ITEM NEGATIVO $item");
                      Helpers.ScaffoldMessage(
                          "Aspecto negativo añadido...", context);
                    } catch (error) {
                      print("Error $error");
                      Helpers.ScaffoldMessage("Error $error", context);
                    }
                  } else {
                    Helpers.ScaffoldMessage(
                        "Se ha de rellenar la descripción de la Pregunta y del Aspecto...",
                        context);
                  }
                },
                child: Text("Aspecto Negativo",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                elevation: 0,
                backgroundColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
      // LISTA DE ASPECTOS POSITIVOS Y NEGATIVOS
      Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Aspectos Positivos", style: TextStyle(fontSize: 28)),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: itemsPos.length,
            itemBuilder: (_, index) {
              return ListTile(
                  title: Column(children: [
                Row(children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 1.0, right: 1.0),
                      child: TextField(
                          keyboardType: TextInputType.name,
                          controller: descItemsPosController[index],
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber)))),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 1.0, right: 2.0),
                      child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          controller: pointsItemsPosController[index],
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.amber)))),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 1.0),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: FloatingActionButton(
                            heroTag: "btnPosUp"+index.toString(),
                            onPressed: () {
                              var pointNum = int.parse(pointsItemsPosController[index].text);
                              if (pointNum < 4) {
                                pointNum++;
                                pointsItemsPosController[index].text = pointNum.toString();
                              }
                            },
                            child: Icon(Icons.expand_less, color: Colors.black),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                            elevation: 0,
                            backgroundColor: Colors.amber,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 1.0),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: FloatingActionButton(
                            heroTag: "btnPosDown"+index.toString(),
                            onPressed: () {
                              var pointNum = int.parse(pointsItemsPosController[index].text);
                              if (pointNum > 1) {
                                pointNum--;
                                pointsItemsPosController[index].text = pointNum.toString();
                              }
                            },
                            child: Icon(Icons.expand_more, color: Colors.black),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                            elevation: 0,
                            backgroundColor: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),

                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  //EDICION / GRABACION POSITIVOS
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () async {
                          try {
                            //print("INDEX $index Longitud ${itemsPos.length}");
                            Item editItemPos = itemsPos[index];
                            editItemPos.desc =
                                descItemsPosController[index].text;
                            editItemPos.point = pointsItemsPosController[index].text;
                            Item itemPos =
                                await ItemRepo().editPositivo(editItemPos);
                            //print("INDEX $index Longitud ${itemsPos.length}");
                            print("MODIFICACON ITEM POSITIVO $itemPos");
                            Helpers.ScaffoldMessage(
                                "Aspecto positivo modificado...", context);
                          } catch (error) {
                            print("Error $error");
                            Helpers.ScaffoldMessage("Error $error", context);
                          }
                        },
                        child: Icon(Icons.mode_edit, color: Colors.black)),
                  ),
                  // BORRADO DE ITEM POSITIVO
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () async {
                          try {
                            //print("INDEX $index Longitud ${itemsPos.length}");
                            Item itemPos = await ItemRepo()
                                .deletePositivo(itemsPos[index].id);
                            setState(() {
                              var indexOld = index;
                              itemsPos.removeAt(indexOld);
                              descItemsPosController.removeAt(indexOld);
                              pointsItemsPosController.removeAt(indexOld);
                            });
                            //print("INDEX $index Longitud ${itemsPos.length}");
                            print("BORRADO ITEM POSITIVO $itemPos");
                            Helpers.ScaffoldMessage(
                                "Aspecto positivo borrado...", context);
                          } catch (error) {
                            print("Error $error");
                            Helpers.ScaffoldMessage("Error $error", context);
                          }
                        },
                        child: Icon(Icons.cancel, color: Colors.black)),
                  ),
                ]),
              ]));
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Aspectos Negativos", style: TextStyle(fontSize: 28)),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: itemsNeg.length,
            itemBuilder: (_, index) {
              return ListTile(
                  title: Column(children: [
                    Row(children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 1.0, right: 1.0),
                          child: TextField(
                              keyboardType: TextInputType.name,
                              controller: descItemsNegController[index],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.amber)))),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 1.0, right: 2.0),
                          child: TextField(
                            readOnly: true,
                              keyboardType: TextInputType.name,
                              controller: pointsItemsNegController[index],
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.amber)))),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0, right: 1.0),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: FloatingActionButton(
                                heroTag: "btnNegUp"+index.toString(),
                                onPressed: () {
                                  var pointNum = int.parse(pointsItemsNegController[index].text);
                                  if (pointNum < 4) {
                                    pointNum++;
                                    pointsItemsNegController[index].text = pointNum.toString();
                                  }
                                },
                                child: Icon(Icons.expand_less, color: Colors.black),
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                elevation: 0,
                                backgroundColor: Colors.amber,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0, right: 1.0),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: FloatingActionButton(
                                heroTag: "btnNegDown"+index.toString(),
                                onPressed: () {
                                  var pointNum = int.parse(pointsItemsNegController[index].text);
                                  if (pointNum > 1) {
                                    pointNum--;
                                    pointsItemsNegController[index].text = pointNum.toString();
                                  }
                                },
                                child: Icon(Icons.expand_more, color: Colors.black),
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                elevation: 0,
                                backgroundColor: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  //EDICION / GRABACION NEGATIVOS
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () async {
                          try {
                            Item editItemNeg = itemsNeg[index];
                            editItemNeg.desc =
                                descItemsNegController[index].text;
                            editItemNeg.point = pointsItemsNegController[index].text;
                            Item itemNeg =
                                await ItemRepo().editNegativo(editItemNeg);
                            print("MODIFICACON ITEM NEGATIVO $itemNeg");
                            Helpers.ScaffoldMessage(
                                "Aspecto negativo modificado...", context);
                          } catch (error) {
                            print("Error $error");
                            Helpers.ScaffoldMessage("Error $error", context);
                          }
                        },
                        child: Icon(Icons.mode_edit, color: Colors.black)),
                  ),
                  // BORRADO DE ITEM NEGATIVO
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () async {
                          try {
                            //print("INDEX $index Longitud ${itemsNeg.length}");
                            Item itemNeg = await ItemRepo()
                                .deleteNegativo(itemsNeg[index].id);
                            setState(() {
                              var indexOld = index;
                              itemsNeg.removeAt(indexOld);
                              descItemsNegController.removeAt(indexOld);
                              pointsItemsNegController.removeAt(indexOld);
                            });
                            //print("INDEX $index Longitud ${itemsNeg.length}");
                            print("BORRADO ITEM NEGATIVO $itemNeg");
                            Helpers.ScaffoldMessage(
                                "Aspecto negativo borrado...", context);
                          } catch (error) {
                            print("Error $error");
                            Helpers.ScaffoldMessage("Error $error", context);
                          }
                        },
                        child: Icon(Icons.cancel, color: Colors.black)),
                  ),
                ]),
              ]));
            }),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 10.0),
          child: ElevatedButton(
            child: Text('CONSEJO', style: TextStyle(color: Colors.black)),
            onPressed: () {
              var response = consejo();
              Navigator.of(context).push(
                  MaterialPageRoute(builder:(_)=>resultPage(image: response))
              );
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ])
    ]);
  }

  Padding radioPoints() {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 12.0),
      child: Row(
        children: [
          Text(
            "Asignar valor:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Radio(
            activeColor: Colors.amber,
            value: 0,
            groupValue: _points,
            onChanged: (int? value) {
              setState(() {
                _points = value ?? 0;
                _strpoints = (_points+1).toString();
              });
            },
          ),
          Radio(
            activeColor: Colors.amber,
            value: 1,
            groupValue: _points,
            onChanged: (int? value) {
              setState(() {
                _points = value ?? 0;
                _strpoints = (_points+1).toString();
              });
            },
          ),
          Radio(
            activeColor: Colors.amber,
            value: 2,
            groupValue: _points,
            onChanged: (int? value) {
              setState(() {
                _points = value ?? 0;
                _strpoints = (_points+1).toString();
              });
            },
          ),
          Radio(
            activeColor: Colors.amber,
            value: 3,
            groupValue: _points,
            onChanged: (int? value) {
              setState(() {
                _points = value ?? 0;
                _strpoints = (_points+1).toString();
              });
            },
          ),
          Text("$_strpoints", style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }

  Map<String, dynamic> consejo() {
    double sumaP = 0.0;
    double sumaN = 0.0;
    Map<String, dynamic> semaforo = {};
    List<Map<String, dynamic>> resp =
    [
     {"image":"assets/images/idontnow.gif", "message": "I don't now!"},
     {"image":"assets/images/justdoit.gif", "message": "Just do it!"},
     {"image":"assets/images/dontdoit.gif", "message": "Don't do it that!"}
    ];

    itemsPos.forEach((element) {
      sumaP += int.parse(element.point);
    });

    itemsNeg.forEach((element) {
      sumaN += int.parse(element.point);
    });

    double mediaG = (itemsPos.length + itemsNeg.length) / 2;
    double mediaP = sumaP / mediaG;
    double mediaN = sumaN / mediaG;
    double puntuacionP = double.parse(((mediaP / (sumaP + sumaN)) * 100).toStringAsFixed(2));
    double puntuacionN = double.parse(((mediaN / (sumaP + sumaN)) * 100).toStringAsFixed(2));

    double diferencia = puntuacionP - puntuacionN;
    if (diferencia.abs() > 1) {
      if (diferencia > 0) { semaforo = resp[1]; } else { semaforo = resp[2]; }
    } else {
      semaforo = resp[0];
    }
    semaforo['puntuacionP'] = puntuacionP;
    semaforo['puntuacionN'] = puntuacionN;
    return semaforo;
  }
}
