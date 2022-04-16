import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/api/http_managers.dart';
import 'package:flutter_template/blocs/user/user_bloc.dart';

class AuthUserInterceptorWidget extends StatefulWidget {
  final Widget child;
  final _userInterceptor = _UserInterceptor();

  AuthUserInterceptorWidget({Key? key, required this.child}) : super(key: key);

  @override
  _AuthUserInterceptorWidgetState createState() => _AuthUserInterceptorWidgetState();
}

class _AuthUserInterceptorWidgetState extends State<AuthUserInterceptorWidget> {
  @override
  void initState() {
    super.initState();

    UserBloc userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    widget._userInterceptor.addInterceptor(userBloc);
  }

  @override
  void dispose() {
    widget._userInterceptor.removeInterceptor();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _UserInterceptor {
  InterceptorsWrapper? _userInterceptor;

  addInterceptor(UserBloc userBloc) {
    _userInterceptor = InterceptorsWrapper(onError: (error, handler) {
      if (error.response?.statusCode == 401) userBloc.add(UserRemoveEvent());
      return handler.next(error);
    });

    apiManager.client.interceptors.add(_userInterceptor!);
  }

  removeInterceptor() {
    _userInterceptor = null;
    apiManager.client.interceptors.remove(_userInterceptor);
  }
}
