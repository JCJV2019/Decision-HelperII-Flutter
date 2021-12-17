
import 'package:decision_helper2/models/item_model.dart';
import 'package:decision_helper2/models/question_model.dart';
import 'package:flutter/material.dart';

class HelperProvider extends ChangeNotifier {

  List<Question> _questions = [];
  List<Item> _itemsPos = [];
  List<Item> _itemsNeg = [];
  String _idQuestion = "";
  String _idUser = "";
  String _nameUser = "";
  String _descQuestion = "";

  get idQuestion {
    return _idQuestion;
  }

  set idQuestion(value) {
    _idQuestion = value;
  }

  get idUser {
    return _idUser;
  }

  set idUser(value) {
    _idUser = value;
  }

  get nameUser {
    return _nameUser;
  }

  set nameUser(value) {
    _nameUser = value;
  }

  get descQuestion {
    return _descQuestion;
  }

  set descQuestion(value) {
    _descQuestion = value;
  }

  get questions {
    return _questions;
  }

  set questions(value) {
    _questions = value;
  }

  void removeQuestion() {
    print("HOLA1");
    var indexQuestion =  _questions.indexWhere((quest) => quest.id == idQuestion);
    if (indexQuestion >= 0) {
      _questions.removeAt(indexQuestion);
    }
    _itemsPos = [];
    _itemsNeg = [];
    idQuestion = "";
    descQuestion = "";
  }

  get itemsPos {
    return _itemsPos;
  }

  set itemsPos(value) {
    _itemsPos = value;
  }

  get itemsNeg {
    return _itemsNeg;
  }

  set itemsNeg(value) {
    _itemsNeg = value;
  }
}