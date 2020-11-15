import 'package:attendo/models/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ControllerService{
  DatabaseService Service =new DatabaseService();
  // function that returns total classes attended and total class occurrence
  Future getClassesAttendedStudent(String courseCode, String enrollno) async {
      var arr=[];
      int tot_class=0,attended_class=0;
      var snap=[];
      snap=await Service.getSpecificCourseInfo(courseCode);
      tot_class=snap.length;
      for(int i=0;i<tot_class;i++)
         if(snap[i].get(enrollno)==true)
            attended_class++;
      arr.add(attended_class);
      arr.add(tot_class);
      return arr;
  }

  // function that returns number of classes attended by the students for a particular course given it's
  // courseCode in form of a map. map["total"] contains total number of classes held.

  Future getClassAttendedByStudents(String courseCode) async {
    var enroll=[];
     enroll=await Service.getenrollno(courseCode);
     print(enroll);
     Map mp=new Map();
     int total=0;
     var details=[];
     for(int i=0;i<enroll.length;i++){
        details=await getClassesAttendedStudent(courseCode,enroll[i]);
        total=details[1];
        mp[enroll[i]]=details[0];
     }
    mp["total"]=total;
     return mp;
  }
}