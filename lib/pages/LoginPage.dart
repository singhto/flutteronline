import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutteronline/redux/appReducer.dart';
import 'package:flutteronline/redux/profile/profileAction.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _autovalidate = false;
  bool isLoading = false;
  SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() { 
    super.initState();
    _initPrefs();
  }

  _login(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });
    // print(values);
    var url = 'http://fixitlearn.com/user/login';
    var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode({
        'email': values['email'],
        'password': values['password']
      })
    );
    if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });

        // print(response.body);
        //save token to prefs
        await prefs.setString('token', response.body);

        //get profile
        await _getProfile();

        //ไปที่หน้า Home
        Navigator.pushNamedAndRemoveUntil(context, '/homestack', (Route<dynamic> route) => false);

    } else {
      setState(() {
          isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
          title: '${feedback['message']}',
          message: 'เกิดข้อผิดพลาดจากระบบ ${feedback['status_code']}',
          backgroundColor: Colors.redAccent,
          icon: Icon(
            Icons.error,
            size: 28.0,
            color: Colors.white,
            ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.redAccent,
        )..show(context);
    }
  }

  Future<void> _getProfile() async {
    //get token from prefs
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);
    // print(token['access_token']);
    //http get profile
    var url = 'http://fixitlearn.com/user/me';
    var response = await http.get(url, headers: { 'Authorization': 'Bearer ${token['access_token']}' });
    // print(response.body);
    //save user profile to prefs
    var profile = convert.jsonDecode(response.body);
    await prefs.setString('profile', convert.jsonEncode(profile['user']));

    //call action
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profile  ['user']));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.purple[200],
            Theme.of(context).primaryColor,
          ])),
      child: Center(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Image(
            image: AssetImage('assets/images/cct_logo.png'),
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'email': '',
                'password': '',
              },
              autovalidate: _autovalidate,
              child: Column(
                children: <Widget>[
                  
                  FormBuilderTextField(
                    attribute: "email",
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                     labelText: "Email",
                     labelStyle: TextStyle(color: Colors.black87),
                     fillColor: Colors.white,
                     filled: true,
                     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                     errorStyle: TextStyle(color: Colors.white)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'ป้อนข้อมูลอีเมล์ด้วย'),
                      FormBuilderValidators.email(errorText: 'รูปแบบอีเมล์ไม่ถูกต้อง'),
                    ],
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    attribute: "password",
                    maxLines: 1,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                     labelText: "Password",
                     labelStyle: TextStyle(color: Colors.black87),
                     fillColor: Colors.white,
                     filled: true,
                     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                     errorStyle: TextStyle(color: Colors.white)
                    ),
                    validators: [
                      FormBuilderValidators.required(errorText: 'ป้อนข้อมูลรหัสผ่านด้วย'),
                      FormBuilderValidators.minLength(3, errorText: 'รหัสผ่านต้อง 3 ตัวอักษรขึ้นไป'),
                    ],
                  ),

                  SizedBox(height: 30),

                  SizedBox(
                    width: 200,
                    child: RaisedButton(
                      onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            _login(_fbKey.currentState.value);
                          } else {
                            setState(() {
                              _autovalidate = true;
                            });
                          }  
                      },
                      child: Text('Log In', style: TextStyle(fontSize: 20, color: Colors.white)),
                      padding: EdgeInsets.all(30),
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            child: Text('ลงทะเบียน', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                            onPressed: () {
                                Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: Text('ลืมรหัสผ่าน?', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                            onPressed: () {

                            },
                          ),
                        )
                    ]
                  )
                  
                ],
              ),
            ),
          ),
        ])),
      ),
    ));
  }
}
