import 'package:attendo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import necessary classes
class DatabaseService{
  final String uid; // defining uid as attribute instead of passing repeatedly
  DatabaseService({this.uid});
  //defining a collection refference
  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('users');
  // adding user to the database
  Future addUser(String name, String enrollno, int type, String userid) async{ // also including user id for now
    return await UserCollection.doc(uid).set({'Name':name, 'Enroll_No':enrollno, 'User_Type':type,"User_id":userid});
  }
  Future getUserFromUid(String uid) async{ // returns user information given userid
    DocumentSnapshot doc = await UserCollection.doc(uid).get();
    userinfo user=new userinfo(doc.get("Name"),doc.get("Enroll_No"),doc.get("User_Type"));
    return user;
  }
}
Future getStudentCourses(String enrollNo) async{ // function which returns student courses with a given enrollment number.
  var courses=[];
  await FirebaseFirestore.instance
      .collection('courses')
      .where(enrollNo,isEqualTo: true)
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      courses.add(doc);
    })
  });
  return courses;
}
// function which returns student courses with a given enrollment number.
//assuming that the documents in the collection courses has extra fields "Prof_name" and "enroll_no:true"
Future getProfessorCourses(String profname) async{
  var courses=[];
  await FirebaseFirestore.instance
      .collection('courses')
      .where("Prof_name",isEqualTo: profname)
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      courses.add(doc);
    })
  });
  return courses;
}
Future getSpecificCourseInfo(String course_code) async{
  var Document;
  var DocList=[];
  await FirebaseFirestore.instance
      .collection('courses')
      .where("Course_Code",isEqualTo: course_code)
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      Document=doc.id;
    })
  });
  await FirebaseFirestore.instance
      .collection("courses").doc(Document).collection("Class")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      DocList.add(doc);
    });
  });
  return DocList;
}
Future getSpecificCourseDateInfo(String date, String course_code) async{
  var Document;
  var result;
  await FirebaseFirestore.instance
      .collection('courses')
      .where("Course_Code",isEqualTo: course_code)
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      Document=doc.id;
    })
  });
  await FirebaseFirestore.instance
      .collection('courses').doc(Document.toString()).collection("Class")
      .where("Date",isEqualTo: date)
      .get()
      .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      print(doc.id);
      result=doc;
    })
  });
  return result;
}
