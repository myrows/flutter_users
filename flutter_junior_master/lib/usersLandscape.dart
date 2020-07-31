import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UsersLandscape extends StatelessWidget {
  const UsersLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aratech'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}