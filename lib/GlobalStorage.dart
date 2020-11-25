import 'package:katha/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalStorage
{
  static final GlobalStorage _globalStorage = GlobalStorage._internal();

  factory GlobalStorage() {
    return _globalStorage;
  }

  GlobalStorage._internal();

  Future<void> setUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', user.userID);
    prefs.setString('name', user.name);
    prefs.setString('loginType',user.LoginType);
    prefs.setString('profilePicPath', user.profilePicPath);
    prefs.setString('email', user.email);
  }

  Future<UserModel> getUser() async {
    UserModel userModel = new UserModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('userID') == null){
      return null;
    }

    userModel.userID = prefs.getString('userID');
    userModel.name = prefs.getString('name');
    userModel.LoginType = prefs.getString('loginType');
    userModel.profilePicPath = prefs.getString('profilePicPath');
    userModel.email = prefs.getString('email');

    return userModel;
  }

  Future<void> logoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userID");
    prefs.remove("name");
    prefs.remove("loginType");
    prefs.remove("profilePicPath");
    prefs.remove("email");
  }
}