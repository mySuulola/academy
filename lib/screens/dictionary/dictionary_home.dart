import 'dart:async';
import 'dart:convert';

import 'package:academy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DictionaryHome extends StatefulWidget {
  @override
  _DictionaryHomeState createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  final String _token = "8c533ba113d870752196b8f3663ab3d68fbb4aef";
  final String _url = "https://owlbot.info/api/v4/dictionary/";

  TextEditingController _controller = TextEditingController();
  StreamController _streamController;
  Stream _stream;

  Timer _timer;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");

    try {
      Response response = await get(_url + _controller.text.trim(),
          headers: {"Authorization": "Token $_token"});

      _streamController.add(json.decode(response.body));
    } catch (error) {
      _streamController.add("error");
      print(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        // title: Text('Search Here'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 1.0, 20.0),
                  child: Material(
                    elevation: 0.0,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextFormField(
                        decoration: textInputDecorationLogin.copyWith(
                          hintText: 'Search Here',
                        ),
                        controller: _controller,
                        onChanged: (val) {
                          if (_timer?.isActive ?? false) _timer.cancel();
                          _timer = Timer(const Duration(milliseconds: 2000),
                              () => _search());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () => _search(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text("Enter a search word"),
            );
          }
          if (snapshot.data == "waiting") {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == "error") {
            return Center(
              child: Text("Network Failure, please try again!"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data["definitions"].length,
            itemBuilder: (context, index) {
              return ListBody(
                children: <Widget>[
                  Container(
                    color: Colors.grey[300],
                    child: ListTile(
                      leading: snapshot.data['definitions'][index]
                                  ['image_url'] ==
                              null
                          ? Icon(Icons.search)
                          : CircleAvatar(
                              backgroundImage: NetworkImage(snapshot
                                  .data['definitions'][index]['image_url']),
                            ),
                      title: Text(_controller.text.trim() +
                          " (" +
                          snapshot.data['definitions'][index]['type'] +
                          ") "),
                      trailing: snapshot.data['definitions'][index]['emoji'] !=
                              null
                          ? Text(snapshot.data['definitions'][index]['emoji'])
                          : null,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 38.0, top: 20.0, bottom: 20.0),
                    child:
                        Text(snapshot.data['definitions'][index]['definition']),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
