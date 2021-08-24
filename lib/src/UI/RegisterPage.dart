import 'dart:convert';

import 'package:cms_manhattan/src/UI/HomePage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<RegisterPage> {
  final JsonDecoder _decoder = new JsonDecoder();
  String _password, _email;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;


  Widget _fistField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "First Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _email = val,
            validator: (value) => value.isNotEmpty ? null : "Please enter a First name",
          )
        ],
      ),
    );
  }
  Widget _lastField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Last Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _email = val,
            validator: (value) => value.isNotEmpty ? null : "Please enter a Last name",
          )
        ],
      ),
    );
  }
  Widget _emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _email = val,
            validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
          )
        ],
      ),
    );
  }
  Widget _passField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blueGrey[200]),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onSaved: (val) => _password = val,
            validator: (val) {
              return val.length < 5 ?  "password must have valid" : null;
            },
          )
        ],
      ),
    );
  }
  Future<void> saveData(context,user) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
  Widget _submitButton() {
    final form = _formKey.currentState;
    return InkWell(
      onTap: () => {
        if (form.validate())
          {
            setState(() {
              isLoading = true;
            }),
            form.save(),

          }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.blueGrey[200]),
        child: Text(
          'Create Account',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _fistField(),
        _lastField(),
        _emailField(),
        _passField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create an Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Continue with',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/google.png",width: 80,),
                              Image.asset("images/fb.png",width: 80),
                              Image.asset("images/apple.png",width: 80),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                   Divider(
                                    color: Colors.blueGrey[200],
                                    height: 2,
                                  ),
                                ],
                              ),
                              Center(
                                child:Container(
                                  width: 30,
                                  alignment: AlignmentDirectional.center,
                                  color: Colors.white,
                                  child: Text("Or",
                                    textAlign: TextAlign.center, style: TextStyle(
                                      backgroundColor: Colors.white,
                                    ),) ,
                                ) ,
                              )
                            ],
                          )
                        ],
                      )
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(key: _formKey, child: _emailPasswordWidget()),
                    SizedBox(
                      height: 20,
                    ),
                    privacyPolicyLinkAndTermsOfService(),
                    isLoading ? CircularProgressIndicator() : _submitButton(),
                    SizedBox(height:30),
                    TextButton(onPressed: ()=>{

                    }, child: Text(
                      'Need Help',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text("Register",style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
      ),
      ),
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,//change your color here
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Center(
          child: Text.rich(
              TextSpan(
                  text: 'By Creating an account, you agree to our', style: TextStyle(
                  fontSize: 14, color: Colors.blueGrey
              ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' User Agreement', style: TextStyle(
                      fontSize: 14, color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // code to open / launch terms of service link here
                          }
                    ),
                    TextSpan(
                        text: ' And acknowledge reading our ', style: TextStyle(
                        fontSize: 14, color: Colors.blueGrey
                    ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'User Privacy Notice.', style: TextStyle(
                              fontSize: 14, color: Colors.blue,
                              decoration: TextDecoration.underline
                          ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch privacy policy link here
                                }
                          )
                        ]
                    )
                  ]
              )
          )
      ),
    );
  }
}
