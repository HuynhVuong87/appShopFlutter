import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/me/home.dart';
import 'package:myapp/model/user.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(User.imageUrl),
              radius: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Name: " + User.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            Text(
              "Email: " + User.email,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            // Text(
            //   "Provider: " + User.,
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //       fontSize: 20.0),
            // ),
            MaterialButton(
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 20),
              ),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () => UserService().signOut().then((_) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => GoogleSignApp()),
                  ModalRoute.withName('/'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
