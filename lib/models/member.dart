import 'loop.dart';

class Member{
  late String name;
  late List<Loop> loops;


  void addLoop(Loop loop){
    loops.add(loop);
  }

}