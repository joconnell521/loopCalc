import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loop_calc/pages/addloop.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'pages/wrapper.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NewUser?>.value(
      value: AuthService().user,
      catchError: (_, __) => null,
      initialData: null,
      child: MaterialApp(
        home: AddLoop(),
        //home: Wrapper(),
      ),
    );
  }
}
