// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:incentive_tracker/screen/dashboard.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/asset_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String _email, _passwaord;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sign In'),
//      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                    child: Image.asset(
                      'assets/sales_icon.png',
                      width: 100,
                    ),
                  ),
                  Text(AssetConstants.appName,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          // E-mail TextField
                          Container(
                            child: TextFormField(
                              controller: Provider.of<LoginProvider>(context)
                                  .userNameController,
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.primaryColor,
                              style: TextStyle(color: AppColors.backgroundCol),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Provide Service Number';
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.account_circle,
                                    color: AppColors.primaryColor,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  focusColor: AppColors.primaryColor,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle:
                                      TextStyle(color: AppColors.primaryColor),
                                  hintText: 'Service Number'),
                              onSaved: (input) => _email = input!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          // Password TextField
                          Container(
                            child: TextFormField(
                              controller: Provider.of<LoginProvider>(context)
                                  .otpController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: AppColors.backgroundCol,
                              style: TextStyle(color: AppColors.backgroundCol),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: AppColors.primaryColor,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  focusColor: AppColors.primaryColor,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintStyle:
                                      TextStyle(color: AppColors.primaryColor),
                                  hintText: 'Password'),
                              onSaved: (input) => _passwaord = input!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60),
                          ),
                          //  Sign In button

                          MaterialButton(
                              padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                              color: AppColors.buttonGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                              ),
                              onPressed: () => {
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .validateInput(context)
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const DashboardPage()))
                                  },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 80),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'By SLT IT Solutions Development',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
