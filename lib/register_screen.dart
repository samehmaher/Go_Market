import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_market/component/background_Image.dart';
import 'package:go_market/component/reuse_button.dart';
import 'package:go_market/component/style.dart';
import 'package:go_market/component/textfield_text.dart';
import 'package:go_market/component/textfiled_password.dart';
import 'package:go_market/login_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  String password, name, email, rePassword;
  bool spinner = false;
  var _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _rePasswordController = TextEditingController();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is Required'),
    EmailValidator(errorText: 'Email not Valid'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password at least 8 chars'),
    PatternValidator(r'(?=.?[#?!@$%^&-])',
        errorText: 'password must have special chars')
  ]);
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: 'assets/register_bg.jpg'),
        Builder(
            builder: (context) => ModalProgressHUD(
                  inAsyncCall: spinner,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Stack(
                            children: [
                              Center(
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.14,
                                      backgroundColor:
                                          Colors.grey[400].withOpacity(
                                        0.4,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        color: kWhite,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.08,
                                left: MediaQuery.of(context).size.width * 0.56,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: kBlue,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: kWhite, width: 2),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.arrowUp,
                                    color: kWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextInputField(
                                  icon: FontAwesomeIcons.user,
                                  hint: 'Name',
                                  inputType: TextInputType.name,
                                  inputAction: TextInputAction.next,
                                  controller: _nameController,
                                  onChange: (value) {
                                    name = value;
                                  },
                                ),
                                TextInputField(
                                  icon: FontAwesomeIcons.envelope,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  controller: _emailController,
                                  validator: emailValidator,
                                  onChange: (value) {
                                    email = value;
                                  },
                                ),
                                PasswordInput(
                                  icon: FontAwesomeIcons.lock,
                                  hint: 'Password',
                                  inputAction: TextInputAction.next,
                                  controller: _passwordController,
                                  validator: passwordValidator,
                                  onChange: (value) {
                                    password = value;
                                    //Do something with the user input.
                                  },
                                  showPass: show,
                                  iconV: show
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  iconTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                                PasswordInput(
                                  icon: FontAwesomeIcons.lock,
                                  hint: 'Confirm Password',
                                  inputAction: TextInputAction.done,
                                  controller: _rePasswordController,
                                  onChange: (value) {
                                    rePassword = value;
                                    //Do something with the user input.
                                  },
                                  showPass: show,
                                  iconV: show
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  iconTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                RoundedButton(
                                  buttonName: 'Register',
                                  onPress: () async {
                                    if (password == rePassword) {
                                      if (_formKey.currentState.validate()) {
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        if (connectivityResult !=
                                                ConnectivityResult.mobile &&
                                            connectivityResult !=
                                                ConnectivityResult.wifi) {
                                          // ignore: deprecated_member_use
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'No Internet Connection'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        } else {
                                          try {
                                            setState(() {
                                              spinner = true;
                                            });
                                            await _auth
                                                .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password);
                                            Navigator.pop(context);

                                            setState(() {
                                              spinner = false;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              spinner = false;
                                            });
                                            if (e is FirebaseAuthException) {
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                Scaffold.of(context)
                                                    // ignore: deprecated_member_use
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Email Already in Use'),
                                                  backgroundColor: Colors.red,
                                                  duration:
                                                      Duration(seconds: 3),
                                                ));
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }else{
                                      // ignore: deprecated_member_use
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'password Not Matched'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: kBodyText,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text(
                                        'Login',
                                        style: kBodyText.copyWith(
                                            color: kBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}
