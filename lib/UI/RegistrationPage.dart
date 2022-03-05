import 'package:ecommerce_sport/UI/LoginPage.dart';
import 'package:ecommerce_sport/Widgets/CustomButton.dart';
import 'package:ecommerce_sport/Widgets/CustomInputField.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // build alertDialog to show some errors
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
            title: Text("Registration Failed",
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

  // Create new User Account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    // set the form Loading state
    setState(() {
      registerFormLoading = true;
    });
    // create new account method runs
    String createAccountFeedback = await _createAccount();
    // if the email and password not null, head to Error while creating account
    if (createAccountFeedback != null) {
      _buildAlertDialog(createAccountFeedback);
      // set the form regular state [submitted]
      setState(() {
        registerFormLoading = false;
      });
    }
    else{
      // the String was null, user is logged in, head back to login page
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }

  }

  // form loading state
  bool registerFormLoading = false;

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

//  final _formKey = GlobalKey<FormState>();
//  TextEditingController emailController = new TextEditingController();
//  TextEditingController passwordController = new TextEditingController();
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
                // create new account "TEXT"
                Padding(
                  padding: EdgeInsets.only(top: height / 24),
                  child: Text(
                    "Create New Account\n for easily Shopping",
                    textAlign: TextAlign.center,
                    style: Constants.semiBoldHeading,
                  ),
                ),
                // Registration Form
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
//                      textEditingController: emailController,
                      hintText: "Type Your Email",
                      hintStyle: Constants.regularDarkText,
                      prefixIcon: Icon(Icons.mail_rounded,
                          color: Constants.darkBtnColor),
                    ),
                    //PasswordTextField
                    CustomInputField(
//                      textEditingController: passwordController,
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
                    SizedBox(
                      height: height / 26,
                    ),
                    //Login Button
                    CustomButton(
                      isDarkBtn: false,
                      text: "Register",
                      colorBtn: Constants.lightBtnColor,
                      paddingBtn: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      roundedRectangleBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      )),
                      circularPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      onPressed: () {
                        setState(() {
                          registerFormLoading = true;
                          _submitForm();
                        });
                      },
                      isLoading: registerFormLoading,
                    ),
                  ],
                ),
                // Button to head to LoginPage
                CustomButton(
                  circularPadding: EdgeInsets.symmetric(horizontal: 100.0),
                  isDarkBtn: true,
                  text: "Already, Have An Account",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
