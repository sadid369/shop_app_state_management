import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app_state_management/models/exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool get isAuth {
    print(token);
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token!;
    }
    return null;
  }

  Future<void> _authentication(
      String email, String password, String urlSegment) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDeMd4QCUXkcNek6NGBj6wyUCHC-G_uHYg';

    await http
        .post(
      Uri.parse(url),
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    )
        .then((response) async {
      print(response.body);
      final responseData = json.decode(response.body);
      //print(responseData['error']['message']);
      if (responseData['error'] != null) {
        // print(responseData['error']['message']);
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      print(_userId);
      print(_expiryDate);
      print(_token);
      print(isAuth);
      print(token);
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }
}
