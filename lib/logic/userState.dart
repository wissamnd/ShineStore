import 'package:shared_preferences/shared_preferences.dart';
class UserState{
  static String _firstName = "" ;
  static String _lastName = "";
  static String _email = "";
  String _imageUrl;
  String _phoneNumber;
  String _shippingAddress1;
  String _shippingAddress2;
  String _shippingAddresscity;
  String _shippingAddresscountry;
  String _billingAddress1;
  String _billingAddress2;
  String _billingAddresscity;
  String _billingAddresscountry;


  static initialize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName= prefs.getString('firstName')??"Caroline";
    _lastName= prefs.getString('lastName')??"Herschel";
  }
  static setFirstName(String firstName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = firstName;
    prefs.setString('firstName', firstName);
    }
  static setLastName(String latName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastName = latName;
    prefs.setString('lastName', latName);
    }
  static get getFirstName{
    return _firstName;
    }
  static get getLastName{
    return _lastName;
    }
  static getfullName(){
    return _firstName +' '+_lastName;
  }
}