import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class SharedMethods {
  saveUserLoginsDetails(AppUser user) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId!);
    prefs.setString("email", user.email!);
    prefs.setString("fullName", user.fullName!);
    prefs.setString("password", user.password!);
    prefs.setString("phoneNumber", user.phoneNumber!);
    prefs.setString("photo", user.address!);
  }

  Future<AppUser> getUserDetails() async {
    var prefs = await SharedPreferences.getInstance();

    AppUser currentUser;

    currentUser = AppUser(
      userId: prefs.getString("userId"),
      email: prefs.getString("email"),
      password: prefs.getString("password"),
      fullName: prefs.getString("fullName"),
      address: prefs.getString("photo"),
      phoneNumber: prefs.getString("phoneNumber"),
    );

    return currentUser;
  }
}
