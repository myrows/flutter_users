import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_junior_master/filterCards.dart';
import 'package:flutter_junior_master/model/user.dart';
import 'package:http/http.dart' as http;


class UsersPortrait extends StatefulWidget {
  UsersPortrait({Key key}) : super(key : key);

@override
_UsersPortraitState createState() => _UsersPortraitState();
}

class _UsersPortraitState extends State<UsersPortrait> {
  final String url = 'https://5f0ff22d00d4ab001613446c.mockapi.io/api/v1/user/';
  List<Widget> itemsData = [];
  List<User> listOfUsers = [];
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  void getPostsData() {
    List<User> responseList = listOfUsers;
    List<Widget> listItems = [];
    responseList.forEach((user) {
      listItems.add(
        Container(
          height: 150,
          margin: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
          decoration: BoxDecoration( borderRadius: BorderRadius.all( Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow( color: Colors.black.withAlpha(100), blurRadius: 2.0 )
          ]),
          child: Padding(
            padding: EdgeInsets.symmetric( horizontal: 20.0, vertical: 10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.name, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
                    SizedBox( height: 15.0 ),
                    Text(user.birthdate, style: TextStyle( fontSize: 16, color: Colors.grey ))

                  ],
                ),
                Image.asset('assets/images/users_welcome.png', height: 100.0)
              ],
            ),
          ),
        )
      );
    });

    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() { 
    super.initState();
    // Get data
    getJsonData();
    controller.addListener(() {
      double value = controller.offset/119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  transformDate( User item, String date ) {

    List<String> dateParts = date.split('-');
    String year = dateParts.elementAt(0);
    item.birthdate = year;
  }

  Future<List<User>> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );

    setState(() {
      var convertDataToJson = convert.json.decode(response.body);
      final users = new User.fromJsonList(convertDataToJson);

      for (var item in users.items) {
        transformDate( item, item.birthdate );
        listOfUsers.add(item);
      }
      getPostsData();
      return users.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
      double topContainer = 0;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Aratech'),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: 10
              ),
              AnimatedOpacity(
                opacity: closeTopContainer?0:1,
                duration: Duration( milliseconds: 300 ),
                child: AnimatedContainer(
                duration: Duration( milliseconds: 300 ),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer?0:categoryHeight,
                child: FilterCards()
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: itemsData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    if ( topContainer > 0.5 ) {
                      scale = index + 0.5 - topContainer;
                      if ( scale < 0 ) {
                        scale = 0;
                      } else if ( scale > 1 ) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Align(
                          heightFactor: 0.8,
                          alignment: Alignment.topCenter,
                          child: itemsData[index],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}