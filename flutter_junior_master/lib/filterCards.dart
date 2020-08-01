import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_junior_master/usersPortrait.dart';

class FilterCards extends StatefulWidget {

  List<User> responseList;
  User user1;
  User user2;

  FilterCards({ this.responseList, this.user1, this.user2 });

  @override
  _FilterCards createState() => _FilterCards();
}

class _FilterCards extends State<FilterCards> {
  final UsersPortrait usersPortrait = UsersPortrait();
  List<User> responseList;
  User user1;
  User user2;

  @override
  Widget build(BuildContext context) {
    responseList = widget.responseList;
    user1 = widget.user1;
    user2 = widget.user2;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
            child: Row(
            children: [
              customFilterCard(context, 'Newest Date', Colors.deepOrange, () {usersPortrait.createState().getPostsData(() { responseList.sort(( user1, user2) => user2.birthdate.compareTo(user1.birthdate)); });}),
              customFilterCard(context, 'A-z', Colors.deepPurple, () {usersPortrait.createState().getPostsData(() { widget.responseList.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate)); });}),
              customFilterCard(context, 'Z-a', Colors.greenAccent, () {usersPortrait.createState().getPostsData(() { widget.responseList.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate)); });}),
              customFilterCard(context, 'Older Date', Colors.indigoAccent, () {usersPortrait.createState().getPostsData(() { widget.responseList.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate)); });}),
            ],
          ),
        ),
      ),
    );
  }

  Widget customFilterCard( context, String title, Color color, Function filter ) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 90;

    return InkWell(
      onTap: () {
        filter.call();
      },
          child: Container(
                width: 150,
                margin: EdgeInsets.only( right: 20 ),
                height: categoryHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      )
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}