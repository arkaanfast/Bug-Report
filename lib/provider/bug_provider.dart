import 'package:BugReport/models/bugs_model.dart';
import 'package:flutter/material.dart';

class BugProvider extends ChangeNotifier {
  List<BugsModel> bugsList = [];
  void addToBugList(jsonResponse) {
    bugsList = [];
    for (int i = 0; i < jsonResponse.length; ++i) {
      bugsList.add(BugsModel(
          name: jsonResponse[i]["name"],
          email: jsonResponse[i]["email"],
          bug: jsonResponse[i]["description"],
          image: jsonResponse[i]["image"]));
    }
  }

  void addSingleBugToList(jsonResponse) {
    bugsList.add(BugsModel(
        name: jsonResponse["name"],
        email: jsonResponse["email"],
        bug: jsonResponse["description"],
        image: jsonResponse["image"]));
    notifyListeners();
  }
}
