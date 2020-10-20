import 'dart:io';

import 'package:BugReport/Api/api_calls.dart';
import 'package:BugReport/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendBug extends StatefulWidget {
  @override
  _SendBugState createState() => _SendBugState();
}

class _SendBugState extends State<SendBug> {
  String name;

  String email;

  String bug;

  File image;

  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  _imgFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post a Bug"),
          backgroundColor: Colors.cyan,
        ),
        body: loading
            ? Loading()
            : Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          onChanged: (val) {
                            name = val;
                          },
                          validator: (val) => val.isEmpty ? "Enter name" : null,
                          decoration: InputDecoration(
                              hintText: "Name",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0))),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          onChanged: (val) {
                            email = val;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter email";
                            }
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(val)) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0))),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          onChanged: (val) {
                            bug = val;
                          },
                          validator: (val) => val.isEmpty ? "Enter bug" : null,
                          decoration: InputDecoration(
                              hintText: "Bug",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0))),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 140.0,
                              child: RaisedButton(
                                  color: Colors.cyan,
                                  onPressed: () {
                                    _imgFromGallery();
                                  },
                                  child: Text("Post an Image",
                                      style: TextStyle(color: Colors.white))),
                            ),
                            RaisedButton(
                                color: Colors.cyan,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    ApiCall()
                                        .postBug(
                                            name, email, bug, image, context)
                                        .then(
                                            (value) => Navigator.pop(context));
                                  }
                                },
                                child: Text("Send Bug Report",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
