
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_junior_master/repository/user_repository.dart';


class UserBloc {

  final UserRepository userRepository = UserRepository();

  List<User> _usersList = [];

  void getUsers() async {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    var tasks = await client.getTasks();
    tasks.forEach((u) {
      _usersList.add(u);
    });
  }

  final _userListStreamController = StreamController<List<User>>();
  final _userSortStreamController = StreamController<List<User>>();
  final _userCreateStreamController = StreamController<User>();
  final _userEditStreamController = StreamController<User>();


  Stream <List<User>> get userListStream => _userListStreamController.stream;
  StreamSink <List<User>> get userListSink => _userListStreamController.sink;

  Stream<List<User>> get getUser async* {
    yield await userRepository.getUsers();
  }

  Stream <User> userCreate( String title, DateTime date) {
    _createUser( title, date );
    _userCreateStreamController.sink;
  } 

  Stream <User> userEdit( String title, String id, DateTime date) {
    _editUser( title, id, date );
    _userEditStreamController.sink;
  }

  Stream <List<User>> userSort() {
    _userSort();
    _userSortStreamController.sink;
  }

  UserBloc () {
    getUsers();
    _userListStreamController.add(_usersList);
  }

  _createUser( String i, DateTime date ) async {

    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    Map<String, String> userBody = {
        'name' : i,
        'birthdate' : date.toString()
    };
    await client.createUser( userBody );
  }

  _editUser( String title, String id, DateTime _dateEdit ) async {

    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    Map<String, String> userBody = {
        'name' : title,
        'birthdate' : _dateEdit.toString()
    };
    await client.editUser( id, userBody  );
  }

  _userSort( ) async {
    List<User> listToSort = [];
    listToSort.addAll( await userRepository.getUsers());

    listToSort.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate));

    _userListStreamController.sink;
  }

  void dispose() { 
    _userSortStreamController?.close();
    _userListStreamController?.close();
    _userCreateStreamController?.close();
    _userEditStreamController?.close();
  }


}

