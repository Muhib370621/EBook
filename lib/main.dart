

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/routes/app_pages.dart';
import 'package:ebook_app/utils/constant.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:ebook_app/utils/theme_data.dart';
import 'package:ebook_app/utils/theme_service.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'controller/net_check_cont.dart';
import 'models/book_list_model.dart';

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =

StreamController<String?>.broadcast();


final StreamController<Map<String, dynamic>?> onClickStream =
StreamController<Map<String, dynamic>?>.broadcast();



const String darwinNotificationCategoryPlain = 'plainCategory';

const MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';
// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';
//
// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {

  print("called------tapBackground");
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  selectNotificationStream.add(notificationResponse.payload);

  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();

}



@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print("object-------called");

  print("dataOpen===${message.data}===${message.notification!.android!.clickAction}====${message.notification!.body}===");


  if(message.data["story_id"]!=null){
    print("sroryZI------1111${message.data["story_id"]}");
    // PrefData.setStoryId(message.data["story_id"]);
  }


  // if(message.data.isNotEmpty && message.notification!.android!.clickAction!.isNotEmpty) {
  //
  //
  //   // selectNotificationStream.add(json.encode({"action":"FLUTTER_NOTIFICATION_CLICK_STORY","storyId":message.data["story_id"]}));
  //
  //   Map payload = json.decode(json.encode({"action":"FLUTTER_NOTIFICATION_CLICK_STORY","storyId":message.data["story_id"]}));
  //
  //   print("pay----true");
  //
  //   String action = payload["action"];
  //   print("called----notifications---true===${action}===");
  //
  //   if (action == "FLUTTER_NOTIFICATION_CLICK") {
  //     String link = payload["link"] ?? "";
  //
  //     Constant.launchURL(link);
  //   } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
  //
  //     print("storyId------------true");
  //
  //     String storyId = payload["storyId"];
  //     print("storyId------------===$storyId===");
  //
  //     StoryModel? story = await FireBaseData.fetchStory(storyId);
  //
  //     print("story--------------11--${story!.id}");
  //     Get.to(PopularBookDetailScreen(
  //       storyModel: story,
  //     ));
  //   }
  //
  // }



  print("dataOpen12121212121===${message.data}===${message.notification}====${message.notification!.body}===");

  print(" ");

  await setupFlutterNotifications();

  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();

  // showCustomToast1(message: "message");

  // selectNotificationStream.add(message.messageId);

  print("data---------${message.data.toString()}");
  print("data1111---------${message.notification!.title}");


}


setupFlutterNotifications() async {

  channel = const AndroidNotificationChannel(
    'com.example.ebook_app', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

}


// bool isAppBg = false;
 AndroidNotificationChannel channel = AndroidNotificationChannel(
    "com.example.ebook_app", "big text channel name",
    importance: Importance.high, playSound: true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  if(kIsWeb){

    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDbVIRvP2P72LktDtHY0HnfoKzBwfXqZFA",
            authDomain: "e-book-a4896.firebaseapp.com",
            projectId: "e-book-a4896",
            storageBucket: "e-book-a4896.appspot.com",
            messagingSenderId: "1043346652466",
            appId: "1:1043346652466:web:7579322e78fbfb0f8e2b2b",
            measurementId: "G-VERWQ13CLQ"
        )
    );

    await FirebaseMessaging.instance.setAutoInitEnabled(false);


    requestPermissions();

    runApp(MyApp());

  }else{

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    // final token = await FirebaseMessaging.instance.getToken();
    //
    // FireBaseData.addToken(token ?? "");


    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging messages = FirebaseMessaging.instance;

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

      print("routeFromMessageOpen---_${message.data}");


      // ignore: unused_local_variable
      final routeFromMessage = message.data[""];

      if(message.data.isNotEmpty){


        print("sroryZI------${message.data["story_id"]}");

        print("link--------${message.data["link"]}");


        if(message.data["story_id"]!=null){

          await PrefData.setStoryId(message.data["story_id"]);

        }

        if (message.data["link"]!=null){


          print("setLink--------${message.data["link"]}");

          PrefData.setLink(message.data["link"]);

          // Constant.launchURL(message.notification!.android!.link!);
        }


      }








    });






    messages.requestPermission();


    await _configureLocalTimeZone();

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
      // notificationCategories: darwinNotificationCategories,
    );

    // final LinuxInitializationSettings initializationSettingsLinux =
    // LinuxInitializationSettings(
    //   defaultActionName: 'Open notification',
    //   defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    // );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {


        print("selectNotification===true");

        selectNotificationStream.add(notificationResponse.payload);

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }

            break;
        }
      },

      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await FireBaseData.getAppDetail();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    await FlutterDownloader.initialize(
        debug: true,
        // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
    );
    runApp(MyApp(message: message,));

  }

}
//
GetXNetworkManager networkManager = Get.put(GetXNetworkManager());


Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();

  var timeZoneName = tz.getLocation('America/Detroit');

  // final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(timeZoneName);
  // tz.setLocalLocation(tz.getLocation(detroit!));
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> _showNotificationWithImage(RemoteMessage message) async {
  Map mapData = {
    "link": message.notification!.android!.link,
    "action": message.notification!.android!.clickAction,
    "storyId": message.data["story_id"]
  };

  String payload = json.encode(mapData);

  final String largeIconPath = await _downloadAndSaveFile(
      message.notification!.android!.imageUrl!, 'largeIcon');

  final String bigPicturePath = await _downloadAndSaveFile(
      message.notification!.android!.imageUrl!, 'bigPicture');

  final BigPictureStyleInformation bigPictureStyleInformation =
  BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: message.notification!.title,
      htmlFormatContentTitle: true,
      summaryText: message.notification!.body!,
      htmlFormatSummaryText: true);

  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('com.example.ebook_app', 'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation);

  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,

    presentAlert: true,

  );

  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);
  await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
      message.notification!.body!, notificationDetails,
      payload: payload);

  // setStoryId(message.data["story_id"]);
  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();
}

NotificationTabController notificationTabController = Get.put(NotificationTabController());

Future<void> _showNotification(RemoteMessage message) async {

  Map mapData = {
    "link": message.notification!.android!.link,
    "action": message.notification!.android!.clickAction,
    "storyId": message.data["story_id"]
  };

  String payload = json.encode(mapData);
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'com.example.ebook_app',
    'big text channel name',
    channelDescription: 'big text channel description',
    importance: Importance.max,
    priority: Priority.high,
  );


  // const DarwinNotificationDetails iosNotificationDetails =
  // DarwinNotificationDetails(
  //   categoryIdentifier: darwinNotificationCategoryPlain,
  // );
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails,
      // iOS: iosNotificationDetails
  );
  await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
      message.notification!.body!, notificationDetails,
      payload: payload);

  // saveNotification(message);

  // setStoryId(message.data["story_id"]);

  // _configureSelectNotificationSubject();
  // _configureDidReceiveLocalNotificationSubject();
}
//
void _configureDidReceiveLocalNotificationSubject() {
  print("receive---true");

  didReceiveLocalNotificationStream.stream
      .listen((ReceivedNotification receivedNotification) async {
    print("receive---${receivedNotification.payload}");

    Map payload = json.decode(receivedNotification.payload!);

    String action = payload["action"];

    if (action == "FLUTTER_NOTIFICATION_CLICK") {
      String link = payload["link"];

      Constant.launchURL(link);

    } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
      String storyId = payload["storyId"];

      StoryModel? story = await FireBaseData.fetchStory(storyId);

      print("story--------------${story!.id}");
        Get.to(PopularBookDetailScreen(
          storyModel: story,
        ));
    }
  });
}

Future<void> _configureSelectNotificationSubject() async {
  print("called----notification");

  // if(isAppBg){
  //
  //   print("isAppBg---$isAppBg");
  //
  // }else{

  selectNotificationStream.stream.listen((receive) async {
    print("pay1111----true===${receive}");

    if(receive != null && receive.isNotEmpty){


      Map message = json.decode(receive);
      // var message = jsonDecode(receive);


      print("storyId-------_${message["storyId"]}");


      if(message["storyId"]!=null){

        // PrefData.setStoryId(message["storyId"]);
        // PrefData.setIsBack(true);

        StoryModel? story = await FireBaseData.fetchStory(message["storyId"]);


        Get.to(PopularBookDetailScreen(
          storyModel: story!,
        ));

      }
      else if

      (message["link"]!= null){
        Constant.launchURL(message["link"]);
      }


    }

    // Map payload = json.decode(receive!);
    //
    // print("pay----true");
    //
    // String action = payload["action"];
    // print("called----notifications---true===${action}===${receive}");
    //
    // if (action == "FLUTTER_NOTIFICATION_CLICK") {
    //   String link = payload["link"] ?? "";
    //
    //   Constant.launchURL(link);
    // } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
    //   String storyId = payload["storyId"];
    //
    //   StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //   print("story--------------11--${story!.id}");
    //   Get.to(PopularBookDetailScreen(
    //     storyModel: story,
    //   ));
    // }
  });
  // }
}


void requestPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // ignore: unused_local_variable
    final bool? granted = await androidImplementation?.requestPermission();



  }

}

// AppLifecycleState? _notification;


// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  RemoteMessage? message;
  MyApp({super.key,this.message});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver{


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    if(!kIsWeb){

      requestPermissions();

      // _configureSelectNotificationSubject();

      // _configureDidReceiveLocalNotificationSubject();

    }

    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: AppPages.routes,
      // home: (widget.message != null)?SplashScreen(message: widget.message):null,
    );
  }

  initInfo() async {
    print("notifications-----true");

    final fcmToken = await FirebaseMessaging.instance.getToken();

    print("fcmToken----------$fcmToken");

    FirebaseMessaging.instance.getToken().then((value) {
      print("value------$value");
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((value) {
    //   print("FirebaseMessaging.getInitialMessage");
    //   if (value != null) {
    //     //
    //     Get.to(LatestStoryScreen());
    //   }
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {


      print("message------$message");



      print("background2222===true");

      Future.delayed(Duration.zero, () {

//       FirebaseService._localNotificationsPlugin.cancelAll();
//       FirebaseService.showNotification(message);

        flutterLocalNotificationsPlugin.cancelAll();




        if(message.notification!=null && message.notification!.android!=null){


        if (message.notification!.android!.imageUrl!=null &&
            message.notification!.android!.imageUrl!.isNotEmpty) {
          _showNotificationWithImage(message);
        } else {
          _showNotification(message);
        }
        }


        _configureSelectNotificationSubject();
        _configureDidReceiveLocalNotificationSubject();

      });

      // if(message.notification!.android!.imageUrl!.isNotEmpty && message.notification!.android!.imageUrl != null){
      //   _showNotificationWithImage(message);
      // }else{
      //   _showNotification(message);
      // }

    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   final routeFromMessage = message.data[""];
    //
    //
    //   // _handleMessage(message);
    //
    //
    //   // showCustomToast(context: context, message: "message");
    //
    //   // if (message.notification!.android!.imageUrl!.isNotEmpty &&
    //   //     message.notification!.android!.imageUrl != null) {
    //   // _showNotificationWithImage(message);
    //   // } else {
    //   // _showNotification(message);
    //   // }
    //
    //   _configureSelectNotificationSubject();
    //   _configureDidReceiveLocalNotificationSubject();
    //
    //
    //   print("routeFromMessage---_$routeFromMessage");
    // });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        PrefData.setInForeground(false);
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        PrefData.setInForeground(false);
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        PrefData.setInForeground(true);
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        PrefData.setInForeground(false);
        print("app in detached");
        break;
    }
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);


    // setupInteractedMessage();


    if(!kIsWeb){
      initInfo();
    }


    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (widget.message != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () async {
    //       String storyId = widget.message!.data["storyId"];
    //
    //             StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //             print("story--------------${story!.id}");
    //             Get.to(PopularBookDetailScreen(
    //               storyModel: story,
    //             ));
    //     });
    //   }
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (widget.message != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () async {
    //
    //
    //       String storyId = widget.message!.data["storyId"];
    //
    //       StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //       print("story--------------${story!.id}");
    //       Get.to(PopularBookDetailScreen(
    //         storyModel: story,
    //       ));
    //
    //
    //     });
    //   }
    // });

    print("mess----_${widget.message}");
  }

}





