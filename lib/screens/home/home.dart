import 'package:academy/models/user.dart';
import 'package:academy/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'dart:convert';

// stle

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future allNews;

  @override
  void initState() {
    super.initState();
    allNews = fetchNews();
  }

  Future fetchNews() async {
    final response = await get(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f3cf2516cb8846199ef5f7cebfa1454f');

    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return decode;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Container(
              child: Scaffold(
            backgroundColor: Colors.brown[50],
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/people.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Hi, ${snapshot.hasData ? snapshot.data.name : "Guest"}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.brown,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height) / 4.2,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Text(
                              'Word of the Day',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('Carte blanche(n)'),
                              subtitle: Padding(
                                padding: const EdgeInsets.only( right: 8.0),
                                child: Text(
                                    'Complete Freedom or Authority to act'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: Text('TOP NEWS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                            height: (MediaQuery.of(context).size.height) / 2,
                            child: FutureBuilder(
                              future: allNews,
                              builder: (context, newsSnapshot) {
                                if (newsSnapshot.hasData) {
                                  return ListView.builder(
                                    itemCount:
                                        newsSnapshot.data["articles"].length,
                                    itemBuilder: (context, index) {
                                      return ListBody(
                                        children: <Widget>[
                                          Container(
                                            color: Colors.white,
                                            child: ListTile(
                                              leading:
                                                  newsSnapshot.data['articles']
                                                                  [index]
                                                              ['urlToImage'] ==
                                                          null
                                                      ? null
                                                      : CircleAvatar(
                                                          backgroundImage: NetworkImage(
                                                              newsSnapshot.data[
                                                                          'articles']
                                                                      [index][
                                                                  'urlToImage']),
                                                        ),
                                              title: Text(
                                                  newsSnapshot.data['articles']
                                                      [index]['title']),
                                              subtitle: Text(newsSnapshot
                                                      .data['articles'][index]
                                                  ['source']['name']),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    "Error Loading News",
                                    style: TextStyle(color: Colors.white),
                                  );
                                }
                                return Center(child: CircularProgressIndicator());
                              },
                            )),
                      ),
                    )
                  ],
                )),
              ),
            ),
          ));
        });
  }
}
