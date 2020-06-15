import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/pages/CameraStack.dart';
import 'package:flutteronline/pages/CustomerPage.dart';
import 'package:flutteronline/pages/HomeStack.dart';
import 'package:flutteronline/pages/LoginPage.dart';
import 'package:flutteronline/pages/MapPage.dart';
import 'package:flutteronline/pages/NewsStack.dart';
import 'package:flutteronline/pages/ProductStack.dart';
import 'package:flutteronline/pages/RegisterPage.dart';
import 'package:flutteronline/pages/BarcodePage.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

//redux
import 'package:redux/redux.dart';

String token;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Remove this method to stop OneSignal Debugging 
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init(
    "f66666aa-11e4-44a0-bc64-9153e5714888",
    iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    }
  );
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

  OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
     // print('noti from server ' + notification.jsonRepresentation());
    //  print('noti from server ' + notification.payload.body);
    //  print('noti from server ' + notification.payload.title);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // will be called whenever a notification is opened/button pressed.
    // print(result.notification.payload.additionalData['page']);
    navigatorKey.currentState.pushNamed(result.notification.payload.additionalData['page']); // /newsstack
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          title: 'CodingThailand',
          navigatorKey: navigatorKey,
          theme: ThemeData(
            // primarySwatch: Colors.green,
            primaryColor: Colors.purple,
            accentColor: Colors.purpleAccent,
            canvasColor: Colors.purple[50],
            textTheme: TextTheme(
              headline5: TextStyle(color: Colors.green, fontSize: 50),
              headline6: TextStyle(color: Colors.red)
            )
          ),
        // home: HomePage(),
        initialRoute: '/',
        routes: <String, WidgetBuilder> {
          '/': (context) => token == null ? LoginPage() : HomeStack(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/homestack': (context) => HomeStack(),
          '/productstack': (context) => ProductStack(),
          '/newsstack': (context) => NewsStack(),
          '/customer': (context) => CustomerPage(),
          '/camerastack': (context) => CameraStack(),
          '/barcode' : (context) => BarcodePage(),
          '/map' : (context) => MapPage()
        },
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}

