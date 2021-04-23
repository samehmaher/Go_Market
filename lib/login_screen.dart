import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_market/component/textfield_text.dart';
import 'package:go_market/component/textfiled_password.dart';
import 'package:go_market/forgotPassword_screen.dart';
import 'package:go_market/home_screen.dart';
import 'package:go_market/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/background_Image.dart';
import 'component/reuse_button.dart';
import 'component/style.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password, email;
  var spinner = false;
  var _auth = FirebaseAuth.instance;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
  ]);
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/login_bg.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Builder(
            builder: (context) => ModalProgressHUD(
              inAsyncCall: spinner,
              child: Column(
                children: [
                  Flexible(
                    child: Center(
                      child: Text(
                        'Go Market',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextInputField(
                          controller: _emailController,
                          validator: emailValidator,
                          onChange: (value){
                            email = value;
                          },
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                        ),
                        PasswordInput(
                          controller: _passwordController,
                          validator: passwordValidator,
                          showPass: show,
                          iconV:
                          show ? Icons.visibility : Icons.visibility_off,
                          iconTap: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          onChange: (value){
                            password = value;
                          },
                          icon: FontAwesomeIcons.lock,
                          hint: 'Password',
                          inputAction: TextInputAction.done,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password',
                            style: kBodyText,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        RoundedButton(
                          buttonName: 'Login',
                          onPress: ()async{
                            if (_formKey.currentState.validate()) {
                              var connectivityResult =
                              await (Connectivity().checkConnectivity());
                              if (connectivityResult !=
                                  ConnectivityResult.mobile &&
                                  connectivityResult !=
                                      ConnectivityResult.wifi) {
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('No Internet Connection'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                try {
                                  setState(() {
                                    spinner = true;
                                  });

                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  pref.setString('email', email);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                  _emailController.clear();
                                  _passwordController.clear();
                                  setState(() {
                                    spinner = false;
                                  });
                                } catch (e) {
                                  setState(() {
                                    spinner = false;
                                  });
                                  if (e is FirebaseAuthException) {
                                    if (e.code == 'user-not-found') {
                                      // ignore: deprecated_member_use
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('user not found'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    } else if (e.code == 'wrong-password') {
                                      // ignore: deprecated_member_use
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('wrong password'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  }
                                }
                              }
                            }


                          },

                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateNewAccount()));
                    },
                    child: Container(
                      child: Text(
                        'Create New Account',
                        style: kBodyText,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: kWhite))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
