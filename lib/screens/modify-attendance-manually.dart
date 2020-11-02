import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction{add , Cancel}
class AddManualAttendance{
  static Future<DialogAction> AddCancelDialogue(
      BuildContext context,
      String title,
      TextEditingController enrolment_number_controller,
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
                          controller: enrolment_number_controller,
                          decoration: InputDecoration(
                              labelText: "Enrolment Number",
                              labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)
                          ),
                          autofillHints: [AutofillHints.name],
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