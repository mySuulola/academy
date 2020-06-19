import 'package:academy/models/menu_item.dart';
import 'package:academy/screens/authenticate/sign_in.dart';
import 'package:academy/screens/course/course_home.dart';
import 'package:academy/screens/dictionary/dictionary_home.dart';
import 'package:academy/screens/home/home.dart';
import 'package:academy/screens/home/settings_form.dart';
import 'package:academy/screens/note/note_list.dart';
import 'package:academy/services/auth.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final AuthService _authService = AuthService();

  Widget _appBarTitle;
  Color _appBarBackgroundColor;
  MenuItem _selectedMenuItem;
  List<MenuItem> _menuItems;
  List<Widget> _menuOptionWidgets = [];

  @override
  void initState() {
    super.initState();
    _menuItems = createMenuItems();
    _selectedMenuItem = _menuItems.first;
    _appBarTitle = new Text(_menuItems.first.title);
    _appBarBackgroundColor = _menuItems.first.color;
  }

  @override
  Widget build(BuildContext context) {
    _menuOptionWidgets = [];

    for (var menuItem in _menuItems) {
      _menuOptionWidgets.add(Container(
        decoration: BoxDecoration(
          color:
              menuItem == _selectedMenuItem ? Colors.grey[200] : Colors.white,
        ),
        child: new ListTile(
          leading: Image.asset(
            menuItem.icon,
            height: 20.0,
            width: 20.0,
          ),
          onTap: () => _onSelectItem(menuItem),
          title: Text(
            menuItem.title,
            style: TextStyle(
              fontSize: 20.0,
              color: menuItem.color,
              fontWeight: menuItem == _selectedMenuItem
                  ? FontWeight.bold
                  : FontWeight.w300,
            ),
          ),
        ),
      ));
    }

    _menuOptionWidgets.add(new SizedBox(
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
          height: 0.3,
          color: Colors.grey,
        ),
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        backgroundColor: _appBarBackgroundColor,
        // centerTitle: true,
        actions: <Widget>[
          Container(
            child: FlatButton(
              child: Icon(Icons.settings, color: Colors.white70),
              onPressed: () => _showSettingsPanel(),
            ),
          ),
          FlatButton.icon(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white70,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white70),
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/profile.png',
                      height: 80.0,
                    ),
                    Text(
                      'Academy',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w200),
                    ),
                    Text(
                      'Learners are Leaders',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   child: Center(
            //     child: Container(
            //       margin:
            //           new EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
            //       height: 0.3,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              child: Column(
                children: _menuOptionWidgets,
              ),
            )
          ],
        ),
      ),
      body: _getMenuItemWidget(_selectedMenuItem),
    );
  }

  List<MenuItem> createMenuItems() {
    final menuItems = [
      new MenuItem(
          'Dashboard', 'assets/dash.png', Colors.black, () => new Home()),
      new MenuItem(
          'Note', 'assets/note.png', Colors.indigo, () => new NoteList()),
      new MenuItem('Dictionary', 'assets/dico.png', Colors.black,
          () => new DictionaryHome()),
      new MenuItem('Courses', 'assets/courses.png', Colors.indigo,
          () => new CourseHome()),
      new MenuItem('Logout', 'assets/logout.png', Colors.black,
          () async => {await _authService.signOut().then((value) => SignIn())}),
    ];

    return menuItems;
  }

  _onSelectItem(MenuItem menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
      _appBarTitle = new Text(menuItem.title);
      _appBarBackgroundColor = menuItem.color;
    });
    Navigator.of(context).pop();
  }

  _getMenuItemWidget(MenuItem selectedMenuItem) {
    return selectedMenuItem.func.call();
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Colors.brown[300],
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm());
        });
  }
}
