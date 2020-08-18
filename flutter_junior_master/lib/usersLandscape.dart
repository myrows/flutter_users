
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_junior_master/generated/l10n.dart';
import 'dart:async';
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

import 'bloc/provider.dart';
import 'bloc/user_bloc.dart';

class UsersLandscape extends StatefulWidget {
  UsersLandscape({Key key}) : super(key: key);

  _UsersLandscapeState _usersLandscapeState = _UsersLandscapeState();

  @override
  _UsersLandscapeState createState() => _usersLandscapeState;
}

class _UsersLandscapeState extends State<UsersLandscape>{

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  DateTime _date = DateTime.now();
  DateTime _dateEdit = DateTime.now();
  TextEditingController customControllerQuery = TextEditingController();
  UserBloc bloc = UserBloc();

  @override
  void dispose() { 
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bloc
    bloc = Provider.of(context);
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
            title: Container(
              margin: EdgeInsets.symmetric( horizontal: 10.0, vertical: 8.0 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(22.0))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: customControllerQuery,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.current.searchUsersHint,
                        hintStyle: TextStyle(
                          color: Colors.grey
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {
                //List<User> searchList = listOfUsers.where((u) => u.name.toLowerCase().startsWith(customControllerQuery.text.toLowerCase())).toList();
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
              StreamBuilder<List<User>>(
                initialData: [],
                stream: bloc.getUser,
                builder: ( BuildContext context, AsyncSnapshot<List<User>> snapshot ) {
                
                  return Expanded(
                    child: ListView.builder(
                    controller: controller,
                    itemCount: snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {

                      return _customListViewBuilder( snapshot.data[index].name, snapshot.data[index].birthdate, index, snapshot.data[index] );
                    },
                ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  createAlertDialog( BuildContext context ) {
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(S.current.titlePopUpCreate, textAlign: TextAlign.center),
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
            child: Text(S.current.buttonPopUpCreate),
            onPressed: () {
              Navigator.pop(context);
              if ( customController.text.toString().isNotEmpty ) {
                bloc.userCreate( customController.text.toString(), _date );
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
        
        title: Text(S.current.titlePopUpEdit, textAlign: TextAlign.center),
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
            child: Text(S.current.buttonPopUpEdit),
            onPressed: () {
              Navigator.pop(context);
              if ( customController.text.toString().isNotEmpty ) {
                bloc.userEdit(customController.text.toString(), user.id, _dateEdit);
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
              customFilterCard(context, S.current.newestDate, Colors.deepOrange, () {  }),
              customFilterCard(context, 'A-z', Colors.deepPurple, () { }),
              customFilterCard(context, 'Z-a', Colors.greenAccent, () { }),
              customFilterCard(context, S.current.olderDate, Colors.indigoAccent, () { })
            ],
          ),
        ),
      ),
    );
  }

    Widget customFilterCard( context, String title, Color color, Function filter ) {
    final double categoryHeight = MediaQuery.of(context).size.width * 0.30 - 130;

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

  Widget _customListViewBuilder( String title, String birthdate, int index, User user) {
    
    return Slidable(child: Container(height: 150,
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
                                      Container(
                                        width: 100,
                                        child: Text(title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,)
                                        ),
                                        SizedBox( height: 15.0 ),
                                        Text(birthdate, style: TextStyle( fontSize: 16, color: Colors.grey ))
                                    ],
                                  ),
                                  Image.asset('assets/images/users_welcome.png', height: 100.0)
                                ],
                              ),
                            ),
                          ),
                            delegate: new SlidableDrawerDelegate(),
                            actionExtentRatio: 0.25,
                            secondaryActions: [
                              IconSlideAction(
                              caption: S.current.editSlideOption,
                              color: Color.fromRGBO(12, 77, 105, 1),
                              icon: Icons.edit,
                              onTap: () {
                                editAlertDialog( context, user );
                              })
                            ],
                        );
  }
}