import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_junior_master/filterCards.dart';
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/rounded_picker.dart';


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
  DateTime _date = DateTime.now();
  DateTime _dateEdit = DateTime.now();
  User user1;
  User user2;
  List<User> responseList;

  void getPostsData( Function e ) {
    responseList = listOfUsers;
    // Filter
    e.call();
    //--------
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
      getPostsData( () {});
      return users.items;
    });
  }

    postJsonData( String title ) async {
    var response = await http.post(
      Uri.encodeFull(url),
      headers: {
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8'
      },
      body: convert.jsonEncode(<String, String> {
        'name' : title,
        'birthdate' : _date.toString()
      })
    );

    if ( response.statusCode == 201 ) {
      
    } else {
      throw Exception( 'Failed to create user' );
    }
  }

    putJsonData( String title, String id ) async {
    var response = await http.put(
      Uri.encodeFull('https://5f0ff22d00d4ab001613446c.mockapi.io/api/v1/user/$id'),
      headers: {
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8'
      },
      body: convert.jsonEncode(<String, String> {
        'name' : title,
        'birthdate' : _dateEdit.toString()
      })
    );

    if ( response.statusCode == 200 ) {
      
    } else {
      throw Exception( 'Failed to update user' );
    }
  }

  createAlertDialog( BuildContext context ) {
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Create user', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Hermion'
              ),
              controller: customController,
            )
          ],
        ),
        actions: [
            IconButton(
              icon: Icon( Icons.date_range ),
              color: Color.fromRGBO(12, 77, 105, 1),
              onPressed: () {
                _selectDate( context );
            },
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            color: Color.fromRGBO(12, 77, 105, 1),
            child: Text('Create'),
            onPressed: () {
              if ( customController.text.toString().isNotEmpty ) {
                postJsonData( customController.text.toString() );
              }
            },
          )
        ],
      );
    });
  }

    editAlertDialog( BuildContext context, User user ) {
    TextEditingController customController = TextEditingController( text: user.name );

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Edit user', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: customController,
            )
          ],
        ),
        actions: [
            IconButton(
              icon: Icon( Icons.date_range ),
              color: Color.fromRGBO(12, 77, 105, 1),
              onPressed: () {
                _selectDate( context );
            },
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            color: Color.fromRGBO(12, 77, 105, 1),
            child: Text('Save'),
            onPressed: () {
              if ( customController.text.toString().isNotEmpty ) {
                putJsonData( customController.text.toString(), user.id );
              }
            },
          )
        ],
      );
    });
  }

  Future<Null> _selectDate ( BuildContext context ) async {

    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      imageHeader: AssetImage('assets/images/users_welcome.png'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
      theme: ThemeData.dark(),
      borderRadius: 16,
    );

    if ( newDateTime != null ) {
      setState(() {
        _date = newDateTime;
        _dateEdit = newDateTime;
      });
    }
  }

  Widget filterCards() {
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
              customFilterCard(context, 'Newest Date', Colors.deepOrange, () { getPostsData(() { responseList.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate)); }); }),
              customFilterCard(context, 'A-z', Colors.deepPurple, () { getPostsData(() { responseList.sort((user1, user2) => user1.name.compareTo(user2.name)); }); }),
              customFilterCard(context, 'Z-a', Colors.greenAccent, () { getPostsData(() { responseList.sort((user1, user2) => user2.name.compareTo(user1.name)); }); }),
              customFilterCard(context, 'Older Date', Colors.indigoAccent, () { getPostsData(() { responseList.sort((user1, user2) => user1.birthdate.compareTo(user2.birthdate)); }); })
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    double topContainer = 0;

    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              createAlertDialog(context);
            },
            backgroundColor: Color.fromRGBO(12, 77, 105, 1),
            child: Icon( Icons.add ),
          ),
          appBar: AppBar(
            elevation: 0,
            title: Text('Aratech'),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {
                setState(() {
                  getPostsData(() { responseList.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate)); });
                });
              }),
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
                duration: Duration( milliseconds: 200 ),
                child: AnimatedContainer(
                duration: Duration( milliseconds: 200 ),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer?0:categoryHeight,
                child: filterCards()
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
                          child: Slidable(
                            child: itemsData[index],
                            delegate: new SlidableDrawerDelegate(),
                            actionExtentRatio: 0.25,
                            secondaryActions: [
                              IconSlideAction(
                              caption: 'Edit',
                              color: Color.fromRGBO(12, 77, 105, 1),
                              icon: Icons.edit,
                              onTap: () {
                                editAlertDialog( context, listOfUsers.elementAt(index) );
                              })
                            ],
                        ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}