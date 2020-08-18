part of 'user_custom_bloc.dart';

abstract class UserCustomState extends Equatable {
  const UserCustomState();
  
  @override
  List<Object> get props => [];
}

class UserUninitializedState extends UserCustomState {}

class UserFetchingState extends UserCustomState {}

class UserFetchedState extends UserCustomState {
  final List<User> users;
  UserFetchedState({this.users});
}

class UserErrorState extends UserCustomState {}

class UserEmptyState extends UserCustomState {}
