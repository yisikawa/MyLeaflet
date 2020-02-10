import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Issues',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
// コンストラクト
  MyHomePage({Key key, this.title}) : super(key: key);

// 定数定義
  final String title;

// アロー関数を用いて、Stateを呼ぶ
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await http.post('https://tokogeko.net/api/login',
        body: {'userid': 'xxx', 'password': 'xxx'});
    setState(() {
      _data = res.headers['authorization'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(35.000081, 137.004055),
        zoom: 16.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoieWlzaWthd2EiLCJhIjoiY2s2YndmdXFuMGZ1bDNsb3ZnMXBsbnI3eSJ9.gftC8NPsB9xNWIVEdWnTvw',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 20.0,
              height: 20.0,
              point: new LatLng(35.000081, 137.004055),
              builder: (ctx) => new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
