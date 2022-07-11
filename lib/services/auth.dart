import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NewUser _firebaseUser(User user) {
    return NewUser(uid: user.uid);
  }

  //Change user stream
  Stream<NewUser> get user {
    return _auth.authStateChanges().map((User? user) => _firebaseUser(user!));
  }

  //Sign in email/ password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _firebaseUser(user!);
    } catch (e) {
      print("error registering user.......");
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password, String fName, String lName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Create doc for user with uid
      //await DatabaseService(uid: user!.uid).updateUserData("joe");
      User? user = result.user;
      await DatabaseService(uid: result.user!.uid)
          .createUser(UserData(
          uid: user!.uid,
          firstName: fName,
          lastName: lName,
          loops: [],
      ));
      return _firebaseUser(user);
    } catch (e) {
      print("error registering user.......");
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
