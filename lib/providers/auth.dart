import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:seventh/models/http_exception.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class Auth with ChangeNotifier{
  String _token;
  DateTime _expiry;
  String _id;
  Timer _timer;
  bool get isAuth{
    return token!=null;
  }
  String get userId{
    return _id;
  }
  String get token{
    if(_token!=null&&_expiry!=null&&_expiry.isAfter(DateTime.now())){
      return _token;
    }
    else{
      return null;
    }
  }

  Future<void> _authenticate(String endpoint,String email,String password) async{
    final url='https://identitytoolkit.googleapis.com/v1/accounts:'+endpoint+'?key=AIzaSyAIj2LvCn4FCx7BqQa_orMKh3DSALXP914';
    try{
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      if(json.decode(response.body)['error']!=null){
        throw HttpException(json.decode(response.body)['error']['message']);
      }
      _token=json.decode(response.body)['idToken'];
      _expiry=DateTime.now().add(Duration(seconds: int.parse(json.decode(response.body)['expiresIn'])));
      _id=json.decode(response.body)['localId'];
      autoLogout();
      notifyListeners();
      final prefs= await SharedPreferences.getInstance();
      final userData=json.encode({
        'token':_token,
        'expiry':_expiry.toIso8601String(),
        'id':_id,
      });
      prefs.setString('userData', userData);
    }
    catch(error){
      throw error;
    }
  }
  Future<void> signup(String email,String password) async{
    return _authenticate('signUp', email, password);
  }
  Future<void> login(String email,String password) async{
    return _authenticate('signInWithPassword', email, password);
  }
  Future<void> tryAutoLogin() async{
    final prefs= await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extractedData=json.decode(prefs.getString('userData')) as Map<String,Object>;
    final expiry=DateTime.parse(extractedData['expiry']);
    if(expiry.isBefore(DateTime.now())){
      return false;
    }
    _token=extractedData['token'];
    _id=extractedData['id'];
    _expiry=extractedData['expiry'];
    autoLogout();
    notifyListeners();
    return true;
  }
  Future<void> logout() async{
    _token=null;
    _id=null;
    _expiry=null;
    if(_timer!=null){
      _timer.cancel();
      _timer=null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
  void autoLogout(){
    if(_timer!=null){
      _timer.cancel();
    }
    _timer=Timer(Duration(seconds: _expiry.difference(DateTime.now()).inSeconds),logout);
  }
}