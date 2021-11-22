import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  String? _expiryDate;
  String? _userId;
  Future<void> _authentication(
      String email, String password, String urlSegment) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDeMd4QCUXkcNek6NGBj6wyUCHC-G_uHYg';

    http
        .post(Uri.parse(url),
            body: json.encode({
              'email': email,
              'password': password,
              'returnSecureToken': true,
            }))
        .then((response) {
      print(response.body);
    }).catchError((error) {});
  }

  Future<void> signup(String email, String password) async {
    _authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    _authentication(email, password, 'signInWithPassword');
  }
}
