import 'package:flutter/material.dart';
import 'package:flutter_junior_master/usersLandscape.dart';
import 'package:flutter_junior_master/usersPortrait.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight < 600) {
                return UsersLandscape();
              } else {
                return UsersPortrait();
              }
            },
          ),
    );
  }
}
