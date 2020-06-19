import 'package:flutter/material.dart';
import 'note_detail.dart';
import 'dart:async';
import 'package:academy/models/note.dart';
import 'package:academy/services/sqlitedb.dart';
import 'package:academy/screens/note/note_detail.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  SqliteDB sqliteDB = SqliteDB();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              updateListView();
            }, 
            child: getNoteListView()
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return NoteDetail(
            note: Note('', '', 2),
            appHeaderTitle: 'Add Note',
          );
        }))).then((value) => setState(() => updateListView())),
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    print('count');
    print(count);
    print(noteList);

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    getPriorityColor(this.noteList[position].priority),
                child: getPriorityIcons(this.noteList[position].priority),
              ),
              title: Text(
                this.noteList[position].title,
                style: titleStyle,
              ),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                  onTap: () => _delete(context, this.noteList[position]),
                  child: Icon(Icons.delete, color: Colors.grey)),
               onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return NoteDetail(
                    note: this.noteList[position],
                    appHeaderTitle: this.noteList[position].title,
                  );
                }))).then((value) => setState(() => updateListView())),
            ),
          );
        });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcons(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  Future<void> _delete(BuildContext context, Note note) async {
    int result = await sqliteDB.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar =
        SnackBar(content: Text(message), duration: Duration(milliseconds: 500));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    try {
      Future dbFuture = sqliteDB.initializeDatabase();
      dbFuture.then((database) {
        Future<List<Note>> noteListFuture = sqliteDB.getNoteList();
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    } catch (error) {
      print('error is ${error.toString()}');
    }
  }
}
