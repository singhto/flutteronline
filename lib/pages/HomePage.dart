import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:flutteronline/redux/profile/profileReducer.dart';
import 'package:flutteronline/widgets/logo.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteronline/redux/profile/profileAction.dart';
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fromAbout; //dynamic

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    //post logout to server

    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    if (profileString != null) {
      // setState(() {
      //   profile = convert.jsonDecode(profileString);
      // });
      //call action
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(getProfileAction(convert.jsonDecode(profileString)));
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    // print('home build');
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          centerTitle: true,
          title: const Logo(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover)),
            child: Column(children: <Widget>[
              StoreConnector<AppState, ProfileState>(
                distinct: true,
                converter: (store) => store.state.profileState,
                builder: (context, profileState) {
                  // print('connector build');
                  return Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                            'ยินดีต้อนรับคุณ ${profileState.profile['name']}')),
                  );
                },
              ),
              Expanded(
                  flex: 11,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'homestack/company');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.business,
                                  size: 80, color: Colors.purple),
                              Text('บริษัท', style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                           Navigator.of(context, rootNavigator: true)
                              .pushNamed('/map');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.pin_drop, size: 80, color: Colors.purple),
                              Text('ปักหมุด', style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/camerastack');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt,
                                  size: 80, color: Colors.purple),
                              Text('กล้อง', style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          fromAbout = await Navigator.pushNamed(
                              context, 'homestack/about', arguments: {
                            'email': 'codingthailand@gmail.com',
                            'phone': '0888888'
                          });
                          setState(() {
                            fromAbout = fromAbout;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.report,
                                  size: 80, color: Colors.purple),
                              Text('รายงาน',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'homestack/room');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.monetization_on,
                                  size: 80, color: Colors.purple),
                              Text('เบิก',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/customer');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.person_pin,
                                  size: 80, color: Colors.purple),
                              Text('ผู้ใช้ไฟ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ))
            ])));
  }
}
