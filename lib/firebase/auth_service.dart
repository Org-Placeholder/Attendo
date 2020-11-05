import 'package:attendo/firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendo/models/user.dart';
class AuthService{ // class for handling all firebase related queries

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // function to create a user obj based in Firebase obj containing userid(uid)
  NewUser _userFromFirebase(User user){
    return user!=null? NewUser(uid:user.uid):null;
  }
  // convert stream of User obj to Newuser obj
  Stream<NewUser> get user{ // needed for determining whether user is signed in or not
    return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
  }
  // register with email and password
  Future registerWithEmailAndPassword(String email,String password, String enrollno, String name,int type) async
  {
    try
    {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      // adding the new user to the database
      await DatabaseService(uid: user.uid).addUser(name, enrollno, type,user.uid);
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //  sign-in with email and password
  Future signInWithEmailAndPassword(String email,String password) async
  {
    try
    {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  // sign out function
  Future signout() async {  // to be implemented after screens are made
    try{
      return await _auth.signOut(); // await _auth.signOut() => to be called for logout.
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}