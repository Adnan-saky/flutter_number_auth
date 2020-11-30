import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_in/home.dart';
import 'package:g_in/main.dart';

class LoginPhone extends StatefulWidget {
  LoginPhone({Key key}) : super(key: key);

  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final _txcontroller = TextEditingController();
  final _txfromcontroller = TextEditingController();

  Future<bool> _loginph(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          //this call back only gets called when verifican done by codeAutoRetrievalTimeout

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  user: user,
                ),
              ),
            );
          } else {
            print("Error");
          }
        },
        verificationFailed: (AuthException err) {
          print(err);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text('Enter The code'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _txfromcontroller,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId,
                        smsCode: _txfromcontroller.text.trim());

                    AuthResult result =
                        await _auth.signInWithCredential(credential);

                    FirebaseUser user = result.user;
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            user: user,
                          ),
                        ),
                      );
                    } else {
                      print("Error");
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                )
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _txcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Phone number",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                OutlineButton(
                  onPressed: () {
                    final phonee = _txcontroller.text.trim();
                    _loginph(phonee, context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
