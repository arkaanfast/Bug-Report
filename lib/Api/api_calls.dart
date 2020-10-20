import 'dart:convert';
import 'dart:io';
import 'package:BugReport/provider/bug_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class ApiCall {
  String url = "https://testing-api-screen.herokuapp.com/api/bug/";

  Future getAllBugs(context) async {
    BugProvider _bugs = Provider.of<BugProvider>(context);
    http.Response response = await http.get(url);
    _bugs.addToBugList(jsonDecode(response.body));
  }

  Future postBug(
      String name, String email, String bug, File image, context) async {
    final dio = Dio();
    String fileName = image.path.split('/').last;
    BugProvider _bugs = Provider.of<BugProvider>(context, listen: false);
    FormData formData = FormData.fromMap({
      "name": "$name",
      "email": "$email",
      "description": "$bug",
      "image": await MultipartFile.fromFile(image.path, filename: fileName)
    });

    Response response = await dio.post(
      url,
      data: formData,
    );
    print(response.data);
    _bugs.addSingleBugToList(response.data);
  }
}
