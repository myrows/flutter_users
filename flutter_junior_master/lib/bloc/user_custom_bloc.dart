import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_junior_master/model/user.dart';
import 'package:flutter_junior_master/repository/user_repository.dart';

part 'user_custom_event.dart';
part 'user_custom_state.dart';

class UserCustomBloc extends Bloc<UserCustomEvent, UserCustomState> {
  final UserRepository userRepository = UserRepository();
  
  UserCustomBloc() : super(UserUninitializedState());

  @override
  void onTransition(Transition<UserCustomEvent, UserCustomState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  UserCustomState get initialState => UserUninitializedState();

  Stream<List<User>> get getUser async* {
    yield await userRepository.getUsers();
  }

  @override
  Stream<UserCustomState> mapEventToState(
    UserCustomEvent event,
  ) async* {
    yield UserFetchingState();
    List<User> users = await userRepository.getUsers();

    try {
      if ( event is CreateUserEvent ) {
        userRepository.createUsers(event.title, event.date);
      } else if ( event is EditUserEvent ) {
        userRepository.editUsers(event.title, event.id, event.date);
      }
      if ( users.length == 0 ) {
        yield UserEmptyState();
      } else {
        yield UserFetchedState( users: users );
      }
    } catch (_) {
      yield UserErrorState();
    }
  }
}
