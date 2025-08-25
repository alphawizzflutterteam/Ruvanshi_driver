import 'package:deliveryboy_multivendor/Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Helper/color.dart';
import 'Helper/constant.dart';
import 'Helper/notification_service.dart';
import 'Screens/Splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestLocationPermission();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    systemNavigationBarColor: Colors.transparent,
  ));
  LocalNotificationService.initialize();

  // FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  FirebaseMessaging.instance.getToken().then((value) {
    String fcmToken = value!;
    print("fcm is ${fcmToken}");
  });
  runApp(MyApp());
}

Future<void> _requestLocationPermission() async {
  if (await Permission.location.isGranted) {
    return;
  }
  var status = await Permission.location.request();
  if (status.isGranted) {
    print("Location permission granted");
  } else {
    print("Location permission denied");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: primary_app,
        fontFamily: 'opensans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
      },
    );
  }
}
