
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'user.g.dart';

@RestApi(baseUrl: "https://5f0ff22d00d4ab001613446c.mockapi.io/api/v1/user/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  
    @GET("/")
    Future<List<User>> getTasks();

    @POST("/")
    Future<User> createUser( @Body() Map<String, dynamic> body );

    @PUT("/{id}")
    Future<User> editUser( @Path() String id, @Body() Map<String, dynamic> body );

  }

@JsonSerializable()
class User {
  String id;
  String name;
  String birthdate;

  User({this.id, this.name, this.birthdate});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}