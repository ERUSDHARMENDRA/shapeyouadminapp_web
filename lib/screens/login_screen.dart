import 'package:ars_dialog/ars_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shapeyouadmin_web/screens/home_screen.dart';
import 'package:shapeyouadmin_web/services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Target Inbound"),
        title: Text("HummingBird approaching.ETA 1 minutes")
    );


    Future<void> _showMyDialog({title, message}) async {
      return showDialog<void>(
        context: context,
        barrierColor: Colors.red.withOpacity(0.1),
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                  Text('Please try again'),
                ],
              ),),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }

    _login({username, password}) async {
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async{
        if(value.exists){
          if(value.data()['username']==username){
            if(value.data()['password']==password){
            //if both is correct will login
              try{
                UserCredential userCredential  =  await FirebaseAuth.instance.signInAnonymously();
                if(userCredential!=null){
                  //if signin sucess will navigate to homescreen
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
                //if signin failes

              }catch(e){
                progressDialog.dismiss();
                _showMyDialog(
                  title: 'Login',
                  message: '${e.toString()}',
                );
              }
                  return ;
            }
            //if password is incorrect
            progressDialog.dismiss();
            _showMyDialog(title: 'Incorrect Password', message: 'Password you have entered is invalid');
            return ;
          }
          //if username is incorrect
          progressDialog.dismiss();
          _showMyDialog(title: 'Invalid Username', message: 'Username you have entered is incorrect');
        }
      });
    }


    return Scaffold(
      key: _formKey,
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Connection Failed'),);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF995F06),
                    Colors.white
                  ],
                  stops: [1.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment(0, 0),
                ),
              ),

              child: Center(
                child: Container(
                  height: 420,
                  width: 300,
                  child: Card(
                    elevation: 6,
                    shape: Border.all(color: Theme
                        .of(context)
                        .primaryColor, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/logo.png', height: 92,
                                      width: 92,),
                                    Text('Shop4ShapeYou App Admin',
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),),
                                    TextFormField(
                                      controller: _usernameTextController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter a User Name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'User Name',
                                        prefixIcon: Icon(Icons.person),
                                        focusColor: Theme
                                            .of(context)
                                            .primaryColor,
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        hintText: 'User Name',
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                              width: 2,
                                            )
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20,),

                                    TextFormField(
                                      controller: _passwordTextController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter a Password';
                                        }
                                        if (value.length < 6) {
                                          return 'Minimun 6 Characters';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Minimun 6 Characters',
                                        prefixIcon: Icon(
                                            Icons.vpn_key_rounded),
                                        focusColor: Theme
                                            .of(context)
                                            .primaryColor,
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        hintText: 'Password',
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                              width: 2,
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {
                                      if (_formKey.currentState
                                          .validate()) {
                                        _login(
                                          username: _usernameTextController.text,
                                          password: _passwordTextController.text,
                                        );
                                      }
                                    },
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    child: Text('Login', style: TextStyle(
                                        color: Colors.white),),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}