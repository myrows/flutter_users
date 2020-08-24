

import 'package:dio/dio.dart';
import 'package:flutter_junior_master/model/user.dart';

class UserApiProvider {

  transformDate( User item, String date ) {

    List<String> dateParts = date.split('-');
    String year = dateParts.elementAt(0);
    item.birthdate = year;
  }

  Future<List<User>> getUsers() async {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    var users = await client.getTasks();
    users.forEach((u) { 
      transformDate(u, u.birthdate);
    });

    return users;
  }

  Future<List<User>> getUserSorted() async {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    var users = await client.getTasks();
    users.forEach((u) { 
      transformDate(u, u.birthdate);
    });
    users.sort((user1, user2) => user2.birthdate.compareTo(user1.birthdate));

    return users;
  }

  Future<User> createUsers( String title, DateTime _date ) async {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    Map<String, String> userBody = {
        'name' : title,
        'birthdate' : _date.toString()
    };
    await client.createUser( userBody );
  }

    Future<User> editUsers( String title, String id, DateTime _dateEdit ) async {
    final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
    Map<String, String> userBody = {
        'name' : title,
        'birthdate' : _dateEdit.toString()
    };
    await client.editUser( id, userBody );
  }
}