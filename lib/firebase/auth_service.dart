import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendo/models/user.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
   // function to create a user obj based in Firebase obj containing userid(uid)
 NewUser _userFromFirebase(User user){
       return user!=null? NewUser(uid:user.uid):null;
 }

 Stream<NewUser> get user{
   return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
 }
  // register with email and password
  Future registerWithEmailAndPassword(String email,String password) async
  {
    try
        {
          UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          User user=result.user;
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
  // sign out
}