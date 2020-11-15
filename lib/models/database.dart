import 'package:attendo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{
  final String uid; // defining uid as attribute instead of passing repeatedly
  DatabaseService({this.uid});

  //defining collection reference

  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference CourseCollection=FirebaseFirestore.instance.collection('courses');

  // adding user to the database

  Future addUser(String name, String enrollno, int type, String userid) async{ // also including user id for now
    return await UserCollection.doc(uid).set({'Name':name, 'Enroll_No':enrollno, 'User_Type':type,"User_id":userid});
  }

  // returns user information given userid

  Future getUserFromUid(String uid) async{
    DocumentSnapshot doc = await UserCollection.doc(uid).get();
    userinfo user=new userinfo(doc.get("Name"),doc.get("Enroll_No"),doc.get("User_Type"));
    return user;
  }

  // function which returns student courses with a given enrollment number in the form of an array of document snapshots

  Future getStudentCourses(String enrollNo) async{
    var courses=[];
    await CourseCollection
        .where(enrollNo,isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        courses.add(doc);
      })
    });
    return courses;
  }

  // function which returns professor courses with a given enrollment number in the form of a documentsnapshot array.
  //assuming that the documents in the collection courses has extra fields "Prof_name" and "enroll_no:true"

  Future getProfessorCourses(String profname) async{
    var courses=[];
    await CourseCollection
        .where("Prof_name",isEqualTo: profname)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        courses.add(doc);
      })
    });
    return courses;
  }

  // returns an array of string of enrollno given courseCode

  Future getenrollno(String courseCode) async {
    var enroll=[];
    String coursedoc;
    DocumentSnapshot docSnap;
    await CourseCollection
        .where("Course_Code",isEqualTo: courseCode)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        coursedoc=doc.id;
      })
    });
    docSnap=await CourseCollection.doc(coursedoc).get();
    Map<String,dynamic> mp=docSnap.data();
    for(MapEntry e in mp.entries){
      if(e.value==true)
         enroll.add(e.key);
    }
    //print(enroll);
    return enroll;
  }

// returns all the document snapshots related with a particular courseCode

  Future getSpecificCourseInfo(String course_code) async{
    var Document;
    var DocList=[];
      await CourseCollection
          .where("Course_Code",isEqualTo: course_code)
          .get()
          .then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
          Document=doc.id;
        })
      });


    await CourseCollection
        .doc(Document)
        .collection("Class")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        DocList.add(doc);
      });
    });
    return DocList;
  }

  // returns a document snapshot having details of a particular with given courseCode on a particular date.

  Future getSpecificCourseDateInfo(String date, String course_code) async{
    var Document;
    var result;
    await CourseCollection
        .where("Course_Code",isEqualTo: course_code)
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        Document=doc.id;
      })
    });


    await CourseCollection
        .doc(Document.toString())
        .collection("Class")
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
}


