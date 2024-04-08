import 'dart:convert';

import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier{

  List<String>? get categories => _categories;
  List<String>?  _categories;

  setCategories(List<String> categoriesModel){
    print("category models $categoriesModel");
    _categories = categoriesModel;
    notifyListeners();
  }


  getCategories() async {

  }

}