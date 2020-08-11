import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

  void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
GoogleSignInAccount _currentUser;
//String _contactText;

@override
void initState() {
  super.initState();

  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    setState(() => 
    _currentUser = account
    );
    /*
  if (_currentUser != null) {
        _handleGetContact();
      }
      */
    });
    _googleSignIn.signInSilently();
  }

@override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        backgroundColor: Colors.yellow[50],
        appBar: AppBar(
          title: Text("Flutter Login"),
          backgroundColor: Colors.teal ,
          ),
        body: Center(child:_buildBody()),
      );
    return MaterialApp(
      title: "Facebook Login",
      home: scaffold,
    );
  }


  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

   Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
     if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text('Signed in successfully.'),
          RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
}
}