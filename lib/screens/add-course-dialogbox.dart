import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction{add , Cancel}
class DialogProfessor{
  static Future<DialogAction> addCourseDialog(
      BuildContext context,
      String title,
      TextEditingController course_name_controller,
      TextEditingController course_code_controller,
      TextEditingController course_image_controller,
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
              content: Wrap(
                children: [Container(
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0
                        ),
                        controller: course_name_controller,
                        decoration: InputDecoration(
                            labelText: "Course name",
                            labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)
                        ),
                        autofillHints: [AutofillHints.name],
                      ),
                      TextField(
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0
                        ),
                        controller: course_code_controller,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Course code",
                            labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)
                        ),
                        autofillHints: [AutofillHints.name],
                      ),
                      TextField(
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0
                        ),
                        controller: course_image_controller,
                        decoration: InputDecoration(
                            labelText: "Image URL",
                            labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)
                        ),
                        autofillHints: [AutofillHints.url],
                      ),
                    ],
                  ),
                ),]
              ),

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