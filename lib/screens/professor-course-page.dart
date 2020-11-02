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
  var Enrollment = [
    '19114001','19114002','19114003','19114004','19114005','19114006','19114007','19114008','19114009','19114010','19114011','19114012','19114013','19114014','19114015','19114016','19114017','19114018','19114019','19114020','19114021','19114022','19114023','19114024','19114025','19114026','19114027','19114028','19114029','19114030','19114031','19114032','19114033','19114034','19114035','19114036','19114037','19114038','19114039','19114040','19114041','19114042','19114043','19114044','19114045','19114046','19114047','19114048','19114049','19114050','19114051','19114052','19114053','19114054','19114055','19114056','19114057','19114058','19114059','19114060','19114061','19114062','19114063','19114064','19114065','19114066','19114067','19114068','19114069','19114070','19114071','19114072','19114073','19114074','19114075','19114076','19114077','19114078','19114079','19114080','19114081','19114082','19114083','19114084','19114085','19114086','19114087','19114088','19114089','19114090','19114091','19114092','19114093','19114094','19114095','19114096','19114097','19114098','19114099','19114100',
  ];
  @override
  Widget build(BuildContext context) {
    final enrolment_number_controller = TextEditingController();
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
        onPressed: () {
           final action =AddManualAttendance.AddCancelDialogue(context, 'Add Attendee', enrolment_number_controller);
            //yet to be implemented
        },
        backgroundColor: PrimaryColor,
        child: Icon(Icons.add,),
      ),
    );
  }
}



