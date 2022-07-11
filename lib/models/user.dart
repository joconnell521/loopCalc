import 'loop.dart';

class NewUser {
  final String uid;

  NewUser({required this.uid});
}
class UserData{
  late final String uid;
  late final String firstName;
  late final String lastName;
  late List<Loop> loops;

  UserData({required this.uid, required this.firstName, required this.lastName, required this.loops});

  factory UserData.initialData() {
    return UserData(
      uid: '',
      firstName: '',
      lastName: '',
      loops: [],
    );
  }

  void addLoop(Loop loop){
    loops.add(loop);
  }

}
