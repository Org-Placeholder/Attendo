import 'package:attendo/networking/networkservicediscovery.dart';
import 'package:attendo/networking/socket.dart';
import 'package:attendo/screens/prof-student-common-drawer.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/screens/modify-attendance-manually.dart';

// class MarkAttendanceProfessor extends StatelessWidget{
//   final String courseCode;
//   MarkAttendanceProfessor({Key key, @required this.courseCode}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: PrimaryColor,
//         centerTitle: true,
//         toolbarHeight: 100,
//         title :Text("Take Attendance For " + courseCode),
//       ),
//       body:  TabBarView(
//       controller: controller,
//       children: <Widget>[
//         ShowCardsProfessor(),
//       ],
//     ),
//     );
//   }
// }
class MarkAttendanceProfessor extends StatefulWidget {
  final String courseCode;
  MarkAttendanceProfessor({Key key, @required this.courseCode}) : super(key: key);
  @override
  _MarkAttendanceProfessor createState() => _MarkAttendanceProfessor();
}

class _MarkAttendanceProfessor extends State<MarkAttendanceProfessor> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 1, vsync: this , initialIndex: 0);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text("Your Courses"),
      ),
      drawer: account_drawer(
        Name: "Sandeep Kumar",
        Email: "sandeep.garg@cs.iitr.ac.in",
        ImageURL: "https://internet.channeli.in/media/kernel/display_pictures/2e447df4-5763-44fd-9c5a-3ec45217c76c.jpg",
      ),
      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          ShowMarkedStudents(),
        ],
      ),
    );
  }
}
class ShowMarkedStudents extends StatefulWidget {
  @override
  _ShowMarkedStudentsState createState() => _ShowMarkedStudentsState();
}

class _ShowMarkedStudentsState extends State<ShowMarkedStudents> {
  var Enrollment ;
  bool set_state = true;
  void getStudents() async{
    //Need to get courseCode
    String courseCode = "CSN-291";
    var service = Service();
    var service_name = "_"+courseCode+"._tcp";
    await service.registerService(service_name);
    var server = Server(service.port);
    int max_time = 90;
    await new Future.delayed(const Duration(seconds : max_time));
    //server closes after 90 seconds
    server.closeServer();
    setState(() {
      Enrollment = server.students;
    });
  }
  @override
  Widget build(BuildContext context) {
    final enrolment_number_controller = TextEditingController();
    bool b = true;
    if(b){
      b = false;
      getStudents();
    }
    return Scaffold(
      body: ListView.builder(
          itemCount: Enrollment.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                trailing: Text("Done",style: TextStyle(
                    color: Colors.green,fontSize: 15),),
                title:Text(Enrollment[index],)
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           final action = await AddManualAttendance.AddCancelDialogue(context, 'Add Attendee', enrolment_number_controller);
           if(action == DialogAction.add)
             {
               print("reached");
               //Enrollment.add(enrolment_number_controller.text);
               setState(() {
                 Enrollment.add(enrolment_number_controller.text);
               });
             }
           enrolment_number_controller.text = "";
        },
        backgroundColor: PrimaryColor,
        child: Icon(Icons.add,),
      ),
    );
  }
}



