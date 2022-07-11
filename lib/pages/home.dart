import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loop_calc/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/user.dart';
import 'addloop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dropdownvalue = DateFormat('yyyy').format(DateTime.now());
  var items = ["2021", "2022", "2023"];
  var loops = ["tim", "Ryan", "Steve"];
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData?>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Year",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 20),
            ),
            Text(
              dropdownvalue,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            label: Text("Sign out"),
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          // DropdownButton(
          //   // Down Arrow Icon
          //   icon: const Icon(Icons.keyboard_arrow_down),
          //   // Array list of items
          //   items: items.map((String items) {
          //     return DropdownMenuItem(
          //       value: items,
          //       child: Text(items),
          //     );
          //   }).toList(),
          //   // After selecting the desired option,it will
          //   // change button value to selected value
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       dropdownvalue = newValue!;
          //     });
          //   },
          // ),
        ],
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Loops",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: ExpansionTile(
                        title: Text(loops[index]),
                        leading: Icon(Icons.directions_walk),
                        children: [
                          ListTile(title: Text("Pay: 100")),
                          ListTile(title: Text("Date: june 1")),
                          ListTile(
                            title: Text("numHoles: 18"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: (loops.length),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => const AddLoop()),);
        },
        label: Text("Add Loop"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[800],
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, "/statistics");
              },
              icon: const Icon(Icons.query_stats),
              color: Colors.white,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
