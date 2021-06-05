import 'package:flutter/material.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/widgets/global_widgets.dart';
import 'package:routemaster/routemaster.dart';

class ErrorPage extends StatelessWidget {
  final String path;

  const ErrorPage({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        GlobalValues.errorImage,
                        fit: BoxFit.cover,
                        height: 400,
                        width: 400,
                      ),
                      TitleText(
                        '404! Page Not Found',
                        fontSize: 24,
                        extraBold: true,
                      ),
                      SubtitleText(
                        'Looks like you are lost. The page you are trying to visit is not avialable. Kindly check your url.\n\nPath: $path',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SemiCircularButton(
                isRotated: true,
                height: 80,
                width: 200,
                child: TitleText(
                  'Back To Home',
                  color: Colors.white,
                ),
                onPressed: () {
                  Routemaster.of(context).push('/');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
