import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datafile/firebase_data/key_table.dart';
import '../utils/pref_data.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  String currentUser = '';
static  String keyLogin = "${PrefData.prefName}keyLogin";
 static String keyCurrentUser = "${PrefData.prefName}currentUser";


 RxBool isLoading = false.obs;
 RxBool isVerifyLoading = false.obs;

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  Future<void> setData() async {

    bool i = await PrefData.getLogin();
    isLogin(i);
    currentUser = await getUser();
    update();
  }

  Future<void> changeData(bool isLogin) async {
    // PrefData.setLogin(isLogin);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyLogin, isLogin);

    // PrefData.setUserId(id);
    setData();
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyLogin, false);
    prefs.setString(keyCurrentUser, '');
    // Preferences.preferences.saveBool(key: PrefernceKey.isProUser,value: false);
    FirebaseAuth.instance.signOut();

    update();
  }

  login(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyLogin, true);
    prefs.setString(keyCurrentUser, id);
    currentUser = id;

    print("current-====${id}");


    update();
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString(keyCurrentUser) ?? '';

    if (id.isNotEmpty) {

      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(KeyTable.loginData)
          .doc(id)
          .get();

      if (querySnapshot.exists) {
        return id;
      } else {
        logout();
        changeData(false);
        return '';
      }
    } else {
      isLogin(false);
      if (isLogin.value) {
        changeData(false);
      }
      return '';
    }
  }
}
