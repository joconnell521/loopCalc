import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loop.dart';
import '../models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ required this.uid });
  CollectionReference areteCollection = FirebaseFirestore.instance.collection('users');

  Future<String> createUser(UserData user) async{
    String retVal = 'error';
    try{
      await areteCollection.doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName
      });
      retVal = "sucess";
    }catch(e){
      print(e.toString());
    }
    return retVal;
  }
  Future<void> updateLoops(UserData user) async{
    try{
      await areteCollection.doc(user.uid).set({
        'loops': user.loops,
      });
    }catch(e){
      print(e.toString());
    }
  }

  // Future<UserData> getUserData(String uid) async{
  //   UserData ourUser = UserData.initialData();
  //
  //   try{
  //     DocumentSnapshot snapshot = await _
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      loops: snapshot['loops']
    );
  }
  Stream<UserData>? get user{
    return areteCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}