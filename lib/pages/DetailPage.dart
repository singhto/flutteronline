import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ข้อมูลมิเตอร์')),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            buildHeader(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('ขอผ่อนผันครั้งที่ 1',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Divider(),
                    // Text('Lorem Ipsum is simply dummy text of the printing and',
                    //   textAlign: TextAlign.left,
                    // ),
                    // Divider(),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.timelapse, color: Colors.purple)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('5 มิ.ย. 2563 11:30:34')]),
                            ]),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.person_pin, color: Colors.purple)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('นายสิงห์โต โนนกลาง')]),
                            ]),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.data_usage, color: Colors.purple)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('02145276726')])
                            ]),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.star, color: Colors.purple)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('ASGDเริ่มงานงดจ่ายไฟ')])
                            ]),
                      ],
                    ),
                    Divider(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Icon(Icons.person, color: Colors.purple)
                        ]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[Text('พนักงานปฏิบัติการงดจ่ายไฟ')])
                            ]),
                      ],
                    ),
                    Divider(),

                  ],
                ),
              ),
            )
          ])),
    );
  }

  // header image
  Image buildHeader() {
    return Image(
      image: AssetImage('assets/images/Meter.jpg'),
      fit: BoxFit.cover,
    );
  }

}
