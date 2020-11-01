import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction{add , Cancel}
class DialogProfessor{
  static Future<DialogAction> yesAbortDialogue(
      BuildContext context,
      String title,
      TextField CourseCodeField,
      TextField CourseName,
      ) async{
      final action = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
              title: Text(title),
              content: CourseCodeField,

              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(DialogAction.add),
                  child: const Text('Add')
                  ),
                RaisedButton(
                  onPressed: () => Navigator.of(context).pop(DialogAction.Cancel),
                  child : const Text("Cancel"),
                ),
              ]
           );
         }
      );
      return (action != null ) ? action : DialogAction.Cancel; //change according
    }
  }