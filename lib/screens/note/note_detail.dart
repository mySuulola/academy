import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:academy/models/note.dart';
import 'package:academy/services/sqlitedb.dart';


class NoteDetail extends StatefulWidget {
  final Note note;
  final String appHeaderTitle;

  NoteDetail({@required this.note, @required this.appHeaderTitle});
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  SqliteDB sqliteDB = SqliteDB();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appHeaderTitle),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                    items: _priorities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    style: textStyle,
                    value:  widget.note.priority == 1 ? 'High' : 'Low',
                    onChanged: (valueSelectedByUser) {
                        print('User selected $valueSelectedByUser');
                        widget.note.priority = valueSelectedByUser == 'High' ? 1 : 2;
                            print(widget.note.priority);
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    widget.note.title = titleController.text;
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  maxLines: 5,
                  onChanged: (value) {
                    widget.note.description = descriptionController.text;
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                            var updatedNote = Note.withId(
                                widget.note.id,
                                titleController.text,
                                DateFormat.yMMMMd().format(DateTime.now()),
                                widget.note.priority,
                                descriptionController.text);
                            _save(updatedNote, context);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          _delete(context, widget.note.id);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _delete(BuildContext context, int id) async {
    if (id == null) {
      Navigator.pop(context);
    } else {
      int result = await sqliteDB.deleteNote(id);
      Navigator.pop(this.context, true);
      if (result != 0) {
        _showAlertDialog('Success', 'Note Deleted successfully');
      } else {
        _showAlertDialog('Error', 'Problem Deleting Note');
      }
    }
  }

  Future<void> _save(Note note, BuildContext context) async {
    Navigator.pop(this.context, true);

    try {
      int result;
      if (note.id != null) {
        // update
        result = await sqliteDB.updateNote(note);
      } else {
        // fresh insert
        result = await sqliteDB.insertNote(note);
      }
      print(result);
      if (result != 0) {
        // Success
        _showAlertDialog('Status', 'Note Saved successfully');
      } else {
        // Failed
        _showAlertDialog('Status', 'Problem Saving note');
      }
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }

  void _showAlertDialog(String title, String message) {
    print('got here too');
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: this.context, builder: (_) => alertDialog);
  }
}
