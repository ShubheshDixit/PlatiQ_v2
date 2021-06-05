import 'dart:async';

import 'package:flutter/material.dart';
import 'package:platiq/animations/fade_animations.dart';
import 'package:platiq/animations/scale_animation.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/widgets/global_widgets.dart';
import 'package:routemaster/routemaster.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: -80,
              top: -50,
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xffebe6f9).withOpacity(0.6)
                      : Color(0xff2f2843).withOpacity(0.6),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: 50,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xffebe6f9).withOpacity(0.6)
                      : Color(0xff2f2843).withOpacity(0.6),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: ScaleAnimation(
                              child: Image.asset(
                                GlobalValues.workImage,
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 0.4,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(
                                    'Let\'s get you started',
                                    fontSize: 40,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SubtitleText(
                                    'Sign up using your preferred option',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FadeAnimation(
                        delay: 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: SemiCircularButton(
                            height: 100,
                            width: 200,
                            child: TitleText(
                              'SIGN IN',
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Routemaster.of(context).push('login?inMode=true');
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FadeAnimation(
                        delay: 0.4,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: SemiCircularButton(
                              isRotated: true,
                              color: Theme.of(context).accentColor,
                              height: 100,
                              width: 200,
                              child: TitleText(
                                'SIGN UP',
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Routemaster.of(context).push(
                                  'login',
                                  queryParameters: {'inMode': 'false'},
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final bool inMode;

  const LoginPage({Key? key, this.inMode = false}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isLoading = false;
  bool inMode = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      inMode = widget.inMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: !inMode
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    width: 500,
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          inMode ? 'Hello' : 'Hey there!',
                          fontSize: 40,
                          extraBold: true,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SubtitleText(
                          inMode
                              ? 'Sign in to your account'
                              : 'Create yourself a new account',
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  vsync: this,
                  child: Center(
                    child: Container(
                      width: 500,
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[100]!.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          inMode
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade300),
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade300),
                                      focusColor: Colors.red,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: 'Enter your name',
                                      prefixIcon: Icon(
                                        Icons.account_box,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                          inMode
                              ? SizedBox.shrink()
                              : Divider(
                                  height: 0,
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  thickness: 1.0,
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade300),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade300),
                                focusColor: Colors.red,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter your email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey.shade300.withOpacity(0.5),
                            thickness: 1.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade300),
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade300),
                                hintText: 'Enter your password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                inMode
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: TextButton(
                          child: SubtitleText(
                            'Forgot Password?',
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              inMode = !inMode;
                            });
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                Align(
                  alignment:
                      inMode ? Alignment.bottomLeft : Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: SemiCircularButton(
                      isRotated: !inMode,
                      isLoading: isLoading,
                      height: 100,
                      color: Colors.white,
                      width: 200,
                      child: TitleText(
                        inMode ? 'SIGN IN' : 'SIGN UP',
                        color: inMode
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              isLoading = false;
                            });
                            Routemaster.of(context).push('/home');
                          });
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    child: SubtitleText(
                      inMode
                          ? 'Don\'t have an account? Sign Up'
                          : 'Already have an account? Sign In',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        inMode = !inMode;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
