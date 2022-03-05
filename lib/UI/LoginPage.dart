import 'package:ecommerce_sport/UI/HomePage.dart';
import 'package:ecommerce_sport/UI/RegistrationPage.dart';
import 'package:ecommerce_sport/Widgets/CustomButton.dart';
import 'package:ecommerce_sport/Widgets/CustomInputField.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _buildAlertDialog(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                )),
            backgroundColor: Color(0xff000221),
            title: Text("Login Failed",
                style: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            contentPadding: EdgeInsets.all(30.0),
            content: Container(
                child: Text(
                  error,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w200),
                )),
            elevation: 10,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    elevation: 5,
                    child: Text(
                      "Okay",
                      style: TextStyle(
                          color: Color(0xff000221),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          );
        });
  }
  // login to app method
  Future<String> _loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailRegistered, password: _passwordRegistered);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // submit Form
  void _submitForm() async {
    setState(() {
      loginFormLoading = true;
    });
    String createAccountFeedback = await _loginUser();
    if (createAccountFeedback != null) {
      _buildAlertDialog(createAccountFeedback);
      setState(() {
        loginFormLoading = false;
      });
    }
    else{
      // login successfully, head to homepage
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }

//Form Input Field values
  String _emailRegistered = "";
  String _passwordRegistered = "";

  // FocusNode for inputFields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }
  bool loginFormLoading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height / 24),
                  child: Text(
                    "Welcome User,\nLogin to your account",
                    textAlign: TextAlign.center,
                    style: Constants.semiBoldHeading,
                  ),
                ),
                Column(
                  children: [
                    //Email TextField
                    CustomInputField(
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      onChanged: (value) {
                        _emailRegistered = value;
                      },
                      // once i click enter cursor head to password field
                      onSubmit: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                      hintText: "Type Your Email",
                      hintStyle: Constants.regularDarkText,
                      prefixIcon: Icon(Icons.mail_rounded,
                          color: Constants.darkBtnColor),
                    ),
                    //PasswordTextField
                    CustomInputField(
                      obscureText: true,
                      onChanged: (value) {
                        _passwordRegistered = value;
                      },
                      onSubmit: (value) {
                        _submitForm();
                      },
                      focusNode: _passwordFocusNode,
                      hintText: "Type Your Password",
                      hintStyle: Constants.regularDarkText,
                      prefixIcon: Icon(
                        Icons.lock_open_rounded,
                        color: Constants.darkBtnColor,
                      ),
                    ),
                    SizedBox(height: height/26,),
                    //Login Button
                    CustomButton(
                      isDarkBtn: false,
                      text: "Login",
                      colorBtn: Constants.lightBtnColor,
                      paddingBtn: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                      roundedRectangleBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            topRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          )),
                      circularPadding: EdgeInsets.symmetric(horizontal: 20),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                          setState(() {
                          loginFormLoading = true;
                          _submitForm();
                          });
                          },
                          isLoading: loginFormLoading,
                    ),
                  ],
                ),
                CustomButton(
                  isDarkBtn: true,
                  text: "Create New Account",
                  circularPadding: EdgeInsets.symmetric(horizontal: 100),
                  colorBtn: Constants.darkBtnColor,
                  highlightColorBtn: Color(0xff000444),
                  paddingBtn:
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                  roundedRectangleBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
