import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:letsgohome/component/fancy_bottom_navigator.dart';
import 'package:letsgohome/screens/forgetpassword_page.dart';
import 'package:letsgohome/screens/healthStatus_page.dart';
import 'package:letsgohome/screens/homepage.dart';
import 'package:letsgohome/screens/login_page.dart';
import 'package:letsgohome/screens/newpassword_page.dart';
import 'package:letsgohome/screens/newstudent_page.dart';
import 'package:letsgohome/screens/notification_page.dart';
import 'package:letsgohome/screens/register_page.dart';
import 'package:letsgohome/screens/verify_page.dart';
import 'package:letsgohome/utils/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationSetUp.init();
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String? isLogin = prefs.getString('isLogin');

  //
  //  final firebaseApi = FirebaseApi();
  // // var onMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;
  //  await firebaseApi.initNotification();

  runApp(MyApp(
    islogin: isLogin == "true",
  ));
}
Future <void> init_notifcations ()async {
  final FlutterLocalNotificationsPlugin localNot =
  FlutterLocalNotificationsPlugin();
  final NotificationAppLaunchDetails? noti =
  await localNot.getNotificationAppLaunchDetails();
  print(" pppppgghjj ${noti?.notificationResponse?.payload}");
}
class MyApp extends StatefulWidget {
  bool islogin;

  MyApp({Key? key, required this.islogin}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {



  @override
  void initState()  {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffD9D9D9),
      ),
      home://AddStudentPage(studentCode: '234516',),
      widget.islogin ? const CustomFancyBottomNavigation() : const HomePage(),
      //widget.islogin ? CustomFancyBottomNavigation() : HomePage(),

      navigatorKey: navigatorKey,
      routes: {
        'SignUp': (context) => const RegisterPage(),
        "Login": (context) =>  LoginPage(),
        "ForgetPassword": (context) =>  ForgetPasswordPage(),
        "Verify": (context) => const VerifyPage(),
        "ResetPassword": (context) =>  ResetPassword(),
        'notification': (context) => const NotificationPage(),
        'healthstatus': (context) => HeathStatus(),
        'bottomBar': (context) => const CustomFancyBottomNavigation(),
        NotificationPage.route: (context) => const NotificationPage(),
      },
    );
  }
}
