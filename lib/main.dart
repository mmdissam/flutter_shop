import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappnew/authentication/firebase_auth.dart';

main() {
  runApp(FlutterShop());
}

class FlutterShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthTest(),
    );
  }
}

class AuthTest extends StatefulWidget {

  @override
  _AuthTestState createState() => _AuthTestState();
}

class _AuthTestState extends State<AuthTest> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

  @override
  void initState() {
    firebaseAuthentication.getCurrentUser();
    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Test'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Register'),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text('Register'),
                    onPressed: () async{
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      await firebaseAuthentication.register(email, password);
                    },
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text('Sign Out'),
                    onPressed: () async{
                      await firebaseAuthentication.signOut();
                    },
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    child: Text('Sign In'),
                    onPressed: () async{
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      await firebaseAuthentication.singIn(email, password);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
