import 'package:flutter/material.dart';
import 'package:flutter_junior_master/bloc/user_bloc.dart';
export 'package:flutter_junior_master/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class Provider extends InheritedWidget {
  
  static Provider _instance;

  factory Provider({ Key key, Widget child }) {

    if ( _instance == null ) {
      _instance = Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({ Key key, Widget child }) : super( key: key, child: child);

  final _userBloc = UserBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc of ( BuildContext context ) {
     return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._userBloc;
  }

}