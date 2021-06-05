import 'dart:async';
import 'package:flutter/material.dart';
import 'package:platiq/animations/fade_animations.dart';
import 'package:platiq/animations/scale_animation.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/widgets/dots_indicator.dart';
import 'package:platiq/widgets/global_widgets.dart';
import 'package:routemaster/routemaster.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int currentIndex = 0;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.index;
      });
    });
  }

  Future<void> changePage(index) async {
    _controller.animateTo(index);
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isChecked
        ? Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                PageFlow(
                  assetPath: GlobalValues.workImage,
                  heading: 'Switch between work to relax',
                  description:
                      'In the office? Don\'t worry this feature won\'t disturb you.',
                  index: 0,
                  currentIndex: currentIndex,
                  onPageChanged: (index) => changePage(index),
                  onSkipPressed: () => changePage(3),
                  length: 4,
                  onDonePressed: () {},
                ),
                PageFlow(
                  assetPath: GlobalValues.socialImage,
                  heading: 'Chats, Calls and Stories',
                  description:
                      'Be connected with your contacts; different for different modes.',
                  index: 1,
                  currentIndex: currentIndex,
                  onPageChanged: (index) => changePage(index),
                  onSkipPressed: () => changePage(3),
                  length: 4,
                  onDonePressed: () {},
                ),
                PageFlow(
                  assetPath: GlobalValues.exploreImage,
                  heading: 'News and Posts',
                  description:
                      'Get the latest verified news and avoid rumours. Share your ideas with posts.',
                  index: 2,
                  currentIndex: currentIndex,
                  onPageChanged: (index) => changePage(index),
                  onSkipPressed: () => changePage(3),
                  length: 4,
                  onDonePressed: () {},
                ),
                PageFlow(
                  assetPath: GlobalValues.sucessImage,
                  heading: 'VIP Membership',
                  description:
                      'Become a VIP to enjoy more features and relax mode.',
                  index: 3,
                  currentIndex: currentIndex,
                  onPageChanged: (index) => changePage(index),
                  onSkipPressed: () => changePage(3),
                  length: 4,
                  onDonePressed: () {
                    Routemaster.of(context).push('/auth');
                  },
                ),
              ],
            ),
          )
        : SplashPage();
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              GlobalValues.logoImage,
              height: 150,
            ),
            SubtitleText('Let\'s get the conversation started.')
          ],
        ),
      ),
    ));
  }
}

class PageFlow extends StatelessWidget {
  final String assetPath, heading, description;
  final Function(int index) onPageChanged;
  final VoidCallback onDonePressed, onSkipPressed;
  final int currentIndex, index, length;

  const PageFlow(
      {Key? key,
      required this.assetPath,
      required this.heading,
      required this.description,
      required this.onPageChanged,
      required this.currentIndex,
      required this.index,
      required this.onDonePressed,
      required this.onSkipPressed,
      required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      height: 410,
                      width: 300,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 200,
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(500),
                                  bottomRight: Radius.circular(500),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink.shade900,
                                    Color(0xff3e355a),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 300,
                              child: FadeAnimation(
                                delay: 0.2,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ScaleAnimation(
                                    repeat: false,
                                    child: Image.asset(
                                      assetPath,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAnimation(
                            delay: 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TitleText(
                                heading,
                                fontSize: 28,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                                extraBold: true,
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SubtitleText(
                                description,
                                fontSize: 18,
                                color: Colors.grey,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DotsIndicator(
                            onPageChanged: (index) => onPageChanged(index),
                            currentIndex: currentIndex,
                            length: length,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: currentIndex == (length - 1)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    currentIndex == (length - 1)
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                                foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent,
                                ),
                              ),
                              onPressed: onSkipPressed,
                              child: SubtitleText(
                                currentIndex != (length - 1) ? 'Skip' : '',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                    RotatedBox(
                      quarterTurns: 0,
                      child: SemiCircularButton(
                          height: currentIndex == (length - 1) ? 100 : 80,
                          width: currentIndex == (length - 1) ? 200 : 150,
                          isRotated: true,
                          child: currentIndex == (length - 1)
                              ? TitleText(
                                  'Get Started',
                                  textAlign: TextAlign.center,
                                  fontSize: 20,
                                  color: Colors.white,
                                )
                              : TitleText(
                                  'Next',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            if (index == (length - 1)) {
                              onDonePressed();
                            } else
                              onPageChanged(index + 1);
                          }),
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
}
