import 'package:flutter/material.dart';
import 'package:loop_calc/pages/home.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<UserData?>.value(
          value: DatabaseService(uid: user.uid).user,
          catchError: (_, __) => null,
          initialData: UserData.initialData(),
          child: Home()
      );
    }
  }
}
