import 'dart:async';

import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_junior_master/repository/user_repository.dart';

enum BlocEvent {
  loadList,
  createUser,
  editUser,
  search,
  sortedDesc,
  sortedAz,
  sortedZa,
  sortedAsc
}

class UserBloc {
  final UserRepository userRepository = UserRepository();

  List<User> _usersList = [];
  String title;
  String id;
  String query;
  DateTime _date;

  void getUsers() async {
    _usersList.addAll(await userRepository.getUsers());
  }

  final _userListStreamController = StreamController<List<User>>();
  Stream<List<User>> get userListStream => _userListStreamController.stream;
  StreamSink<List<User>> get userListSink => _userListStreamController.sink;

  final _eventStreamController = StreamController<BlocEvent>();
  Stream<BlocEvent> get eventStream => _eventStreamController.stream;
  StreamSink<BlocEvent> get eventSink => _eventStreamController.sink;

  UserBloc() {
    refreshList();
    eventStream.listen((event) async {
      switch (event) {
        case BlocEvent.sortedDesc:
          _usersList.sort(
              (user1, user2) => user2.birthdate.compareTo(user1.birthdate));
          break;
        case BlocEvent.sortedAz:
          _usersList.sort((user1, user2) => user1.name.compareTo(user2.name));
          break;
        case BlocEvent.sortedZa:
          _usersList.sort((user1, user2) => user2.name.compareTo(user1.name));
          break;
        case BlocEvent.sortedAsc:
          _usersList.sort(
              (user1, user2) => user1.birthdate.compareTo(user2.birthdate));
          break;
        case BlocEvent.createUser:
          await userRepository.createUsers(title, _date);
          refreshList();
          break;
        case BlocEvent.editUser:
          await userRepository.editUsers(title, id, _date);
          refreshList();
          break;
        case BlocEvent.search:
        print(query);
        List<User> _searchList = [];
          _searchList.addAll(_usersList.where((u) => u.name.toLowerCase().startsWith(query)).toList());
          userListSink.add(_searchList);
        break;
        default:
      }

      userListSink.add(_usersList);
    });
  }

  void getData(String _dataTitle, String _dataId, DateTime _dataDate) async {
    this.title = _dataTitle;
    this._date = _dataDate;
    this.id = _dataId;
  }

  void searchQuery( String _query ) async {
    this.query = _query;
  }

  refreshList() async {
    _usersList = await userRepository.getUsers();
    userListSink.add(_usersList);
  }

  void dispose() {
    _userListStreamController?.close();
    _eventStreamController?.close();
  }
}
