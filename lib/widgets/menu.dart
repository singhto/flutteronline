import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Map<String, dynamic> profile = {
  //   'email': '',
  //   'name': '',
  //   'role': ''
  // };

  // _getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var profileString = prefs.getString('profile');
  //   if (profileString != null) {
  //     // setState(() {
  //     //   profile = convert.jsonDecode(profileString);
  //     // });
  //     //call action
  //     final store = StoreProvider.of<AppState>(context);
  //     store.dispatch(getProfileAction(convert.jsonDecode(profileString)));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getProfile();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.deepPurple,
              //   ),
              //   child: Text(
              //     'เมนูหลัก',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 24,
              //     ),
              //   ),
              // ),
              StoreConnector<AppState, Map<String, dynamic>>(
                distinct: true,
                converter: (store) => store.state.profileState.profile,
                builder: (context, profile) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/sing.jpg'),
                    ),
                    accountEmail:
                        Text('${profile['email']} role: ${profile['role']}'),
                    accountName: Text('${profile['name']}'),
                    otherAccountsPictures: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, 'homestack/editprofile',
                              arguments: {'name': profile['name']});
                        },
                      )
                    ],
                    // onDetailsPressed: () {
                    // },
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text('หน้าหลัก'),
                trailing: Icon(Icons.arrow_right),
                selected:
                    ModalRoute.of(context).settings.name == 'homestack/home'
                        ? true
                        : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/homestack', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.all_out),
                title: Text('งานประจำวัน'),
                subtitle: Text('ข้อมูลรายการงานประจำวัน'),
                trailing: Icon(Icons.arrow_right),
                selected: ModalRoute.of(context).settings.name ==
                        'productstack/product'
                    ? true
                    : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/productstack', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('ข่าวสาร'),
                subtitle: Text('ข่าวสารรอบโลก Ps23New'),
                trailing: Icon(Icons.arrow_right),
                selected:
                    ModalRoute.of(context).settings.name == 'newsstack/news'
                        ? true
                        : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/newsstack', (Route<dynamic> route) => false);
                },
              ),
             ListTile(
                leading: Icon(Icons.chrome_reader_mode),
                title: Text('Barcode/QRCode'),
                trailing: Icon(Icons.arrow_right),
                selected:
                    ModalRoute.of(context).settings.name == '/barcode'
                        ? true
                        : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/barcode', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ));
  }
}
