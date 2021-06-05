import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/pages/auth_page.dart';
import 'package:platiq/pages/calls_page.dart';
import 'package:platiq/pages/chats_page.dart';
import 'package:platiq/pages/error_page.dart';
import 'package:platiq/pages/home.dart';
import 'package:platiq/pages/intro_page.dart';
import 'package:platiq/pages/posts_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:platiq/configure_nonweb.dart'
    if (dart.library.html) 'package:platiq/configure_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GlobalValues.backgroundColorDark,
        primaryColor: GlobalValues.primaryColor,
        primaryColorLight: Color(0xffa690e3),
        primaryColorDark: Color(0xff7d6ab3),
        accentColor: GlobalValues.accentColor,
        canvasColor: GlobalValues.canvasColorDark,
        cardColor: GlobalValues.cardColorDark,
        hintColor: Colors.grey.shade400,
        fontFamily: GoogleFonts.montserrat(color: GlobalValues.fontColorDark)
            .fontFamily,
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: GlobalValues.primaryColor,
            cursorColor: GlobalValues.primaryColorDark,
            selectionHandleColor: GlobalValues.primaryColor),
      ),
      title: 'PlatiQ',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: GlobalValues.primaryColor,
        primaryColorLight: Color(0xffa690e3),
        primaryColorDark: Color(0xff7d6ab3),
        highlightColor: GlobalValues.primaryColor,
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: GlobalValues.primaryColor,
            selectionHandleColor: GlobalValues.primaryColor),
        accentColor: GlobalValues.accentColor,
        colorScheme: ColorScheme(
          primary: GlobalValues.primaryColor,
          primaryVariant: Colors.white,
          secondary: GlobalValues.accentColor,
          secondaryVariant: Colors.white,
          surface: GlobalValues.cardColorLight,
          background: Colors.transparent,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        canvasColor: GlobalValues.canvasColorLight,
        scaffoldBackgroundColor: GlobalValues.backgroundColorLight,
        cardColor: GlobalValues.cardColorLight,
        hintColor: Colors.grey.shade400,
        fontFamily: GoogleFonts.montserrat(color: GlobalValues.fontColorLight)
            .fontFamily,
      ),
      // home: ErrorPage(),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: RoutemasterParser(),
    );
  }
}

bool loggedIn = true;
bool firstTime = true;
final routes = RouteMap(
    onUnknownRoute: (path) {
      return MaterialPage(
          child: ErrorPage(
        path: path,
      ));
    },
    routes: {
      '/': (_) {
        if (loggedIn) {
          return TabPage(
            child: HomePage(),
            paths: ['/chats', '/calls', '/contacts'],
          );
        } else if (firstTime)
          return Redirect('/intro');
        else
          return Redirect('/auth');
      },
      '/home': (_) {
        return TabPage(
          child: HomePage(),
          paths: ['/chats', '/calls', '/contacts'],
        );
      },
      '/intro': (_) => MaterialPage(
            child: IntroPage(),
          ),
      '/auth': (_) => MaterialPage(
            child: AuthPage(),
          ),
      '/auth/login': (info) => MaterialPage(
            child: LoginPage(
              inMode: info.queryParameters['inMode'] == 'true' ? true : false,
            ),
          ),
      '/chats': (_) {
        return MaterialPage(
          child: ChatViewPage(),
        );
      },
      '/calls': (info) {
        return MaterialPage(
          child: CallsPage(),
        );
      },
      '/chat/:id': (info) => MaterialPage(
              child: ChatsPage(
            workMode: false,
          )),
      '/error': (info) => MaterialPage(
            child: ErrorPage(
              path: info.fullPath,
            ),
          ),
      '/posts/:id': (info) =>
          MaterialPage(child: PostsPage(id: info.pathParameters['id'] ?? '')),
    });
