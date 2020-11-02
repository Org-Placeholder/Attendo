import 'package:cloud_firestore/cloud_firestore.dart';
// import necessary classes
class DatabaseService{
  final String uid; // defining uid as attribute instead of passing repeatedly
  DatabaseService({this.uid});
  //defining a collection refference
  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('users');
  // adding user to the database
  Future addUser(String name,int type,String userid) async{ // also including user id for now
     return await UserCollection.doc(uid).set({'Name':name,'User_Type':type,"User_id":userid});
  }

}
