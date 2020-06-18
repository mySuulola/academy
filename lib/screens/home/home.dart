import 'package:flutter/material.dart';

// stle

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                'Hi, Suulola',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.brown[500], fontSize: 15.0, fontWeight: FontWeight.w800),
              ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height) / 3.5,
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
                        title: Text('Nightingale(n)'),
                        subtitle: Text(
                            'Music by Julie Gable. Lyrics by Sidney Stein.'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    height: (MediaQuery.of(context).size.height) / 2,
                    child: GridView.count(
                      // scrollDirection: Axis.horizontal,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Card(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Know Thyself',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Take a personality Test to get to know your major strength and weakness',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  )
                                ],
                              )),
                          color: Colors.white,
                        ),
                        Card(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'News Feed',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Get updated with the latest in the world of science, politics and entertainment',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  )
                                ],
                              )),
                          color: Colors.white,
                        ),
                        Card(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Book Recc',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Check out the top listed books for the week and participate in reading.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  )
                                ],
                              )),
                          color: Colors.white,
                        ),
                        Card(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Talk to a Counsellor',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              )),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    ));
  }
}
