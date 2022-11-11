import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';
import 'package:n_tel_care_family_app/members/members.dart';
import 'package:n_tel_care_family_app/profile/profile_page.dart';
import 'package:n_tel_care_family_app/spalsh/modified_splash.dart';
import 'package:flutter/services.dart';
import 'package:n_tel_care_family_app/video/videos_widget.dart';
import 'core/shared_preferences_service.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp()
      .then((FirebaseApp value) => print('Firebase Service init $value.'));
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  await Firebase.initializeApp()
      .then((FirebaseApp value) => print('Firebase Service init $value.'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // for IOS
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  // All IOS Notification configurations have been taken away (except above line) for
  // Duplicate IOS notification problem (until further explanation or notie)
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // Initialize FFAppState.
  FFAppState();
  SharedPreferenceService.init();
  runApp(MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'ntelcare', // id
  'High Importance Notifications',
  importance: Importance.high,
);

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Future<void> _getFCMToken() async {
    String fcmToken = await FirebaseMessaging.instance.getToken();
    FFAppState().FCM = fcmToken;
  }

  // void _onDidReceiveLocalNotification(int a, String b, String c, String d) {
  //   print("recieved notification");
  // }

  @override
  void initState() {
    super.initState();
    _getFCMToken();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // final DarwinInitializationSettings iosSettings =
    //     DarwinInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    // );
    var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, /*iOS: iosSettings*/
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("got notification ie not null");
      // if (notification != null) {
      //   print("got notification ie not null");
      //   flutterLocalNotificationsPlugin.show(s
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         // iOS: DarwinNotificationDetails(
      //         //     presentAlert: true,
      //         //     presentBadge: true,
      //         //     presentSound: true,
      //         //     subtitle: "NtelCare",
      //         //     interruptionLevel: InterruptionLevel.critical),
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           color: Colors.white,
      //           icon: "@mipmap/ic_launcher",
      //         ),
      //       ));
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      AppleNotification iphone = message.notification?.apple;
      if (notification != null && android != null && iphone != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTelCareFamilyApp',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      home: ModifiedSplashWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'Landing';
  //PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    //_controller = PersistentTabController(initialIndex: 0);
    _currentPage = widget.initialPage ?? _currentPage;
  }

//Screens for each nav items.
  /*List<Widget> _NavScreens() {
    return [
      ModifiedLandingPageWidget(),
      VideoClipsWidget(),
      MembersWidget(),
      ProfilePageWidget(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.now_widgets_sharp),
          title: ("Dashboard"),
          activeColorPrimary: Color(0xFF00B89F),
          inactiveColorPrimary: Color(0xFF535353),
          iconSize: 24,
          onPressed: (context) {
            pushDynamicScreen(context, screen: dashboard(), withNavBar: true);
          }),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.ondemand_video),
          title: ("Video"),
          activeColorPrimary: Color(0xFF00B89F),
          inactiveColorPrimary: Color(0xFF535353),
          iconSize: 24,
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: VideoClipsWidget(), withNavBar: true);
          }),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.people_rounded),
          title: ("Members"),
          activeColorPrimary: Color(0xFF00B89F),
          inactiveColorPrimary: Color(0xFF535353),
          iconSize: 24,
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: MembersWidget(), withNavBar: true);
          }),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: Color(0xFF00B89F),
          inactiveColorPrimary: Color(0xFF535353),
          iconSize: 24,
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: ProfilePageWidget(), withNavBar: true);
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _NavScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFF1A1A1A), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Color(0xFF1A1A1A),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}*/

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Landing': ModifiedLandingPageWidget(),
      'Video': VideoClipsWidget(),
      'Members': MembersWidget(),
      'Profile': ProfilePageWidget(),
    };

    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Color(0xFF00B89F),
        unselectedItemColor: Color(0xFF535353),
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8,
        itemBorderRadius: 8,
        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
        width: double.infinity,
        elevation: 0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.now_widgets_sharp,
                  color:
                      currentIndex == 0 ? Color(0xFF00B89F) : Color(0xFF535353),
                  size: 24,
                ),
                Text(
                  'Dashboard',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 0
                        ? Color(0xFF00B89F)
                        : Color(0xFF535353),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ondemand_video,
                  color:
                      currentIndex == 1 ? Color(0xFF00B89F) : Color(0xFF535353),
                  size: 24,
                ),
                Text(
                  'Videos',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 1
                        ? Color(0xFF00B89F)
                        : Color(0xFF535353),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_rounded,
                  color:
                      currentIndex == 2 ? Color(0xFF00B89F) : Color(0xFF535353),
                  size: 24,
                ),
                Text(
                  'Members',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 2
                        ? Color(0xFF00B89F)
                        : Color(0xFF535353),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color:
                      currentIndex == 3 ? Color(0xFF00B89F) : Color(0xFF535353),
                  size: 24,
                ),
                Text(
                  'Profile',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 3
                        ? Color(0xFF00B89F)
                        : Color(0xFF535353),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
