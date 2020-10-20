import 'package:BugReport/Api/api_calls.dart';
import 'package:BugReport/provider/bug_provider.dart';
import 'package:BugReport/screens/send_bug.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListBugs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BugProvider _bugs = Provider.of<BugProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("List of all Bugs"),
          backgroundColor: Colors.cyan,
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SendBug()));
              },
              child: Text("Post Bug"),
              textColor: Colors.brown,
            )
          ],
        ),
        body: FutureBuilder(
            future: ApiCall().getAllBugs(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: _bugs.bugsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: _bugs.bugsList[index].image != null
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: _bugs.bugsList[index].image,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Icon(Icons.not_interested),
                            title: Text(
                              "Name: ${_bugs.bugsList[index].name}",
                              style: TextStyle(fontSize: 22.0),
                            ),
                            subtitle: Text(
                              "Bug: ${_bugs.bugsList[index].bug}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
