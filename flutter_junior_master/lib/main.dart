
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_junior_master/bloc/provider.dart';
import 'package:flutter_junior_master/generated/l10n.dart';
import 'package:flutter_junior_master/users.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Aratech',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(12, 77, 105, 1),
          scaffoldBackgroundColor: Colors.white
        ),
        home: LayoutBuilder(builder: (context, constraints) {
          if ( constraints.maxHeight < 600 ) {
            return WelcomeScreenLandscape();
          } else {
            return WelcomeScreen();
          }
        }),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/users_welcome.png'),
                fit: BoxFit.fill,
              ),
              SizedBox( height: 80.0 ),
              RaisedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Users()));
              },
              color: Color.fromRGBO(12, 77, 105, 1),
              child: Text(S.current.buttonMain, style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              )
              ),
              padding: EdgeInsets.only( top: 20.0, bottom: 20.0, left: 50.0, right: 50.0 ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              elevation: 7.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreenLandscape extends StatelessWidget {
  const WelcomeScreenLandscape({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/users_welcome.png'),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.fill,
              ),
              SizedBox( height: 80.0 ),
              RaisedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Users()));
              },
              color: Color.fromRGBO(12, 77, 105, 1),
              child: Text(S.current.buttonMain, style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              )
              ),
              padding: EdgeInsets.only( top: 20.0, bottom: 20.0, left: 50.0, right: 50.0 ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              elevation: 7.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
