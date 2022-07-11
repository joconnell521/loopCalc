import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/const.dart';
import 'package:loop_calc/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[700],
            appBar: AppBar(
              backgroundColor: Colors.grey[850],
              elevation: 0.0,
              title: Text("Sign in to Loop Calc"),
              actions: [
                ElevatedButton.icon(
                  label: Text("Register"),
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[850])),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: imputDecoration.copyWith(hintText: "email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          imputDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? "Enter a password 6+ chars long"
                          : null,
                      onChanged: (val) {
                        setState(() => password = val.trim());
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = "Failed with credentials");
                              setState(() => loading = false);
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[850])),
                        child: Text("Sign In")),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
