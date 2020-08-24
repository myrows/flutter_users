
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_junior_master/repository/user_api_provider.dart';

class UserRepository {
  UserApiProvider _userApiProvider = UserApiProvider();

  Future<List<User>> getUsers() =>
      _userApiProvider.getUsers();
  Future<List<User>> getUserSorted() =>
      _userApiProvider.getUserSorted();
  Future<User> createUsers( String title, DateTime _date ) =>
      _userApiProvider.createUsers( title, _date );
  Future<User> editUsers( String title, String id, DateTime _dateEdit ) =>
      _userApiProvider.editUsers( title, id, _dateEdit );
}