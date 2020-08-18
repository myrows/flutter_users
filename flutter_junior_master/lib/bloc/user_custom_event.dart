part of 'user_custom_bloc.dart';

abstract class UserCustomEvent extends Equatable {
  const UserCustomEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserCustomEvent {
  final List<User> users;

  FetchUsers({this.users}) : assert(users!=null);
}
class CreateUserEvent extends UserCustomEvent{
  final String title;
  final DateTime date;

  CreateUserEvent({this.title, this.date}) : assert(title!=null && date != null);
}
class EditUserEvent extends UserCustomEvent {
  final String title;
  final String id;
  final DateTime date;
  EditUserEvent({this.title, this.id, this.date}) : assert(title!=null && date != null && id != null);
}
