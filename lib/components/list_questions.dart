import 'package:decision_helper2/helpers/helpers.dart';
import 'package:decision_helper2/models/item_model.dart';
import 'package:decision_helper2/models/question_model.dart';
import 'package:decision_helper2/pages/helper_page.dart';
import 'package:decision_helper2/providers/helper_provider.dart';
import 'package:decision_helper2/repositories/item_repository.dart';
import 'package:decision_helper2/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListQuestions extends StatefulWidget {
  ListQuestions({Key? key}) : super(key: key);

  @override
  State<ListQuestions> createState() => _ListQuestionsState();
}

class _ListQuestionsState extends State<ListQuestions> {
  List<Question> questions = [];
  List<TextEditingController> descQuestionController = [];

  @override
  initState() {
    var helperProvider = Provider.of<HelperProvider>(context, listen: false);
    questions = helperProvider.questions;
    //print("HOLA ${questions.length}");
    for (int i = 0; i < questions.length; i++) {
      descQuestionController.add(TextEditingController());
      descQuestionController[i].text = questions[i].question;
      //print("VALORES: ${descQuestionController[i].text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var helperProvider = Provider.of<HelperProvider>(context, listen: false);
    String nameUser = helperProvider.nameUser;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Text(
                'Preguntas del Usuario "$nameUser"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        // if (questions.length > 0)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              // controller: ScrollController(),
              itemCount: questions.length + 1,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Column(children: [
                    if (index < questions.length) TextField(
                        controller: descQuestionController[index],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10,1,10,1),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber)))),
                    if (index < questions.length) Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //EDICION / GRABACION
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.amber)),
                              onPressed: () async {
                                try {
                                  Question editQuestion = questions[index];
                                  editQuestion.question =
                                      descQuestionController[index].text;
                                  Question question = await QuestionRepo()
                                      .editQuestion(editQuestion);
                                  print("MODIFICACON PREGUNTA $question");
                                  Helpers.ScaffoldMessage(
                                      "Pregunta modificada...", context);
                                } catch (error) {
                                  print("Error $error");
                                  Helpers.ScaffoldMessage("Error $error", context);
                                }
                              },
                              child: Icon(Icons.mode_edit,color: Colors.black)),
                        ),
                        // BORRADO DE PREGUNTA E ITEMS POSITIVOS Y NEGATIVOS
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.amber)),
                              onPressed: () async {
                                try {
                                  Map<String,dynamic> info = await Helpers.deleteQuestionAll(questions[index].id);
                                  print("BORRADO DE TODA LA PREGUNTA $info['question']");
                                  setState(() {
                                    questions.removeAt(index);
                                    descQuestionController.removeAt(index);
                                  });
                                  print("Positivos borrados: ${info['nPositives']}");
                                  print("Negativos borrados: ${info['nNegatives']}");
                                  Helpers.ScaffoldMessage(
                                      "Pregunta borrada, Positivos: $info['nPositives'] Negativos: $info['nNegatives']", context);
                                } catch (error) {
                                  print("Error $error");
                                  Helpers.ScaffoldMessage("Error $error", context);
                                }
                              },
                              child: Icon(Icons.cancel,color: Colors.black)),
                        ),
                        // ENTRAR A LA PREGUNTA
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.amber)),
                              onPressed: () async {
                                try {
                                  print("ENTRA A PREGUNTA");
                                  helperProvider.idQuestion = questions[index].id;
                                  helperProvider.descQuestion = questions[index].question;
                                  List<Item> itemsPos = await ItemRepo().getItemsPositivos(questions[index].id);
                                  helperProvider.itemsPos = itemsPos;
                                  List<Item> itemsNeg = await ItemRepo().getItemsNegativos(questions[index].id);
                                  helperProvider.itemsNeg = itemsNeg;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => HelperPage()),
                                  );
                                } catch(error) {
                                  print("Error $error");
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Error $error"),
                                      action: SnackBarAction(
                                        label: "OK",
                                        onPressed: () {},
                                      )));
                                }
                              },
                              child: Icon(Icons.done,color: Colors.black)),
                        )
                      ]
                    ),
                    // NUEVA PREGUNTA
                    if (index == questions.length) Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.amber)),
                                onPressed: () {
                                  print("AÑADIR PREGUNTA");
                                  helperProvider.idQuestion = "";
                                  helperProvider.descQuestion = "";
                                  helperProvider.itemsPos = [].map((element) => Item.fromJson(element)).toList();
                                  helperProvider.itemsNeg = [].map((element) => Item.fromJson(element)).toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => HelperPage()),
                                  );
                                },
                                child: Icon(Icons.add,color: Colors.black)),
                          ),
                        ]
                    ),
                  ]),
                );
              },
            ),
          )
      ],
    );
  }

}
