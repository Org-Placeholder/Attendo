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
  Future addUser(String name,int type,String userid,String enroll) async{ // also including user id for now
     return await UserCollection.doc(uid).set({'Name':name,'User_Type':type,'User_id':userid,'Enroll_No':enroll});
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
Future getProfessorCourses(String enrollNo) async{
  var courses=[];
  FirebaseFirestore.instance
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

