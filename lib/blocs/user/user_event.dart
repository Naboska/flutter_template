part of 'user_bloc.dart';

abstract class UserEvent {}

class UserInitializeEvent extends UserEvent {}

class UserRemoveEvent extends UserEvent {}
