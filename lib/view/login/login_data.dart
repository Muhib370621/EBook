import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../datafile/firebase_data/firebasedata.dart';
import '../../datafile/firebase_data/key_table.dart';
import '../../models/user_model.dart';
import '../../utils/constantWidget.dart';


class LoginData{

  static String keyUId = 'uid';
  static String keyEmail = 'email';
  static String keyUsername = 'username';
  static String keyPassword = 'password';
  static String keyActive = 'active';
  // static String keySubscribed = 'subscribed';

  static createUser(
      {required BuildContext context,
        required String username,
        required String email,

        required String password,

        required Function function}) async {
    bool isCreated = await registerUsingEmailPassword(context,
        password: password, email: email);

    print("isCreated==$isCreated");

    if (isCreated) {

      // FirebaseAuth.instance.signOut();
      // function();

      UserModel userModel = UserModel();

      userModel.username = username;
      userModel.password = password;
      userModel.email = email;
      userModel.active = "1";
      // userModel.subscribed = 0;
      userModel.uid = FirebaseAuth.instance.currentUser!.uid;


      FirebaseFirestore.instance.collection(KeyTable.loginData).add(userModel.toJson()).then((value) {
        FirebaseAuth.instance.signOut();

        print("isCreated==54545454");
        Future.delayed(Duration(seconds: 1),() async {
function();
        });
      });
    }
  }
  static Future<bool> registerUsingEmailPassword(BuildContext context,
      {email, password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        auth.currentUser != null;
      });
      // user = userCredential.user;
      //
      //
      // user = auth.currentUser;
      // print('The=====${user!.email}');

      return auth.currentUser != null;
    } on FirebaseAuthException catch (e) {

      print("code------------${e.code}");
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

        showCustomToast(message: "weak-password");
      } else if (e.code == 'email-already-in-use') {
        if (auth.currentUser != null) {
          auth.currentUser != null;
        }

        showCustomToast(
            message: "The account already exists for that email.",
            );
        return false;
      }
    } catch (e) {
      print("e------------$e");
      return false;
    }

    return false;
  }


  // static createUser(
  //     {
  //       required String username,
  //       required String email,
  //       required String password,
  //       required Function function}) {
  //
  //
  //   UserModel userModel = UserModel();
  //
  //   userModel.username = username;
  //   userModel.password = password;
  //   userModel.email = email;
  //   userModel.active = "1";
  //   userModel.subscribed = 0;
  //
  //   FirebaseFirestore.instance.collection(KeyTable.loginData).add(userModel.toJson()).then((value) => function());
  // }





  // static Future<bool> userAlreadyRegister({email}) async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(KeyTable.loginData)
  //       .where(keyEmail, isEqualTo: email)
  //       .get();
  //
  //   print("user---------${querySnapshot.docs.length}");
  //
  //   if (querySnapshot.size > 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }


  static Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }

  static Future<bool> userAlreadyRegister(BuildContext context,
      {required phoneNumber, required password,required LoginController loginController}) async {


    bool isRegister =

    await checkIfEmailInUse(phoneNumber);
    // await loginUsingEmailPassword(context,
    //     password: password, email: phoneNumber, isCheck: true,loginController: loginController);

    print("isRegister===$isRegister");

    if (!isRegister) {
      return false;
    }


    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection(FirebaseData.loginData)
    //     .where(keyPhoneNumber, isEqualTo: phoneNumber)
    //     .get();
    //
    // if (FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.signOut();
    // }
    // if (querySnapshot.size > 0) {
    return true;
    // } else {
    //   return false;
    // }
  }



  // static Future<bool> login(BuildContext context,{email, password,loginController}) async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection(KeyTable.loginData)
  //       // .where(keyUsername, isEqualTo: use)
  //       .where(keyEmail, isEqualTo: email)
  //       .where(keyPassword, isEqualTo: password)
  //       .where(keyActive, isEqualTo: '1')
  //
  //       .get();
  //
  //   print("login--------${querySnapshot.docs.length}");
  //
  //   if (querySnapshot.size > 0) {
  //     querySnapshot.docs.forEach((element) {
  //
  //       Map map = element.data() as Map;
  //
  //       if(map["subscribed"] == 1)
  //         {
  //           Preferences.preferences.saveBool(key: PrefernceKey.isProUser,value: true);
  //         }else{
  //         Preferences.preferences.saveBool(key: PrefernceKey.isProUser,value: false);
  //       }
  //       loginController.login(element.id);
  //
  //     });
  //
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }


  static Future<bool> loginUsingEmailPassword(BuildContext context,
      {email, password, required isCheck,required LoginController loginController}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    print("user===${email}==$password");

    try {
      await auth
          .signInWithEmailAndPassword(
        email:  email,
        password: password,
      )
          .then((value) {
        auth.currentUser != null;
      });


      print("currUser-------${auth.currentUser}");

      return auth.currentUser != null;
    } on FirebaseAuthException catch (e) {

      print("logincodr===${e.code}");

      if (!isCheck) {
        if (e.code == 'user-not-found') {
          loginController.isLoading(false);
          showCustomToast(
              message: 'No user found for that email.');
          return false;
        } else if (e.code == 'wrong-password') {
          loginController.isLoading(false);

          showCustomToast(

              message: 'Wrong password provided for that user.');
          return false;
        }
      }
    }
    return false;
  }

  static Future<bool> login(BuildContext context,
      {phoneNumber, password, loginController}) async {
    print("login===true");


    bool isLogin = await loginUsingEmailPassword(context,
        password: password, email: phoneNumber, isCheck: false,loginController: loginController);

    if (!isLogin) {
      return false;
    }

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection(FirebaseData.loginData)
    //     .where(keyPhoneNumber, isEqualTo: phoneNumber)
    //     .where(keyUId, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .where(keyActive, isEqualTo: '1')
    //     .get();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(KeyTable.loginData)
          // .where(keyUsername, isEqualTo: use)
          .where(keyEmail, isEqualTo: phoneNumber)
          .where(keyUId, isEqualTo: FirebaseAuth.instance.currentUser!.uid)

          // .where(keyPassword, isEqualTo: password)
          .where(keyActive, isEqualTo: '1')

          .get();





    print("isLogin11111===${querySnapshot.size}");

    if (querySnapshot.docs.isNotEmpty) {


      final token =
      await FirebaseMessaging.instance.getToken();

      print("token-----${token.toString()}");

      FireBaseData.addToken(token ?? "");

      await FireBaseData.getAppDetail();



      for (var element in querySnapshot.docs) {
        loginController.login(element.id);
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserId({email}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.loginData)
        .where(keyEmail, isEqualTo: email)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0].id;
      }

      return '';
    } else {
      return '';
    }
  }

  static Future<void> changePassword({id, password}) async {
    FirebaseFirestore.instance
        .collection(KeyTable.loginData)
        .doc(id)
        .update({
      keyPassword: password,
    });
  }

}