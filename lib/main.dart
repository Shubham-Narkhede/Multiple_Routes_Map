import 'package:flutter/material.dart';

import 'googleMap.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => WidgetGoogleMap()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class MarkerData {
//   String? name;
//   double? latitude;
//   double? longitude;

//   MarkerData({this.name, this.latitude, this.longitude});
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<MarkerData> markers = [];
//   Position? currentPosition;
//   GoogleMapController? mapController;
//   StreamSubscription<Position>? positionStream;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 200,
//           width: 100,
//           color: Colors.yellow,
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadMarkers();
//     _getCurrentLocation();
//   }

//   @override
//   void dispose() {
//     positionStream?.cancel();
//     super.dispose();
//   }

//   Future<void> _loadMarkers() async {
//     var response = await http.get(Uri.parse('https://mydatabase.com/markers'));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       List<MarkerData> tempMarkers = [];
//       for (var marker in data) {
//         tempMarkers.add(MarkerData(
//           name: marker['name'],
//           latitude: marker['latitude'],
//           longitude: marker['longitude'],
//         ));
//       }
//       setState(() {
//         markers = tempMarkers;
//       });
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     positionStream = Geolocator.getPositionStream().listen((Position position) {
//       setState(() {
//         currentPosition = position;
//       });
//     });
//   }

//   double _distance(MarkerData start, Position end) {
//     const int radiusOfEarth = 6371;
//     LatLng startLatLng = LatLng(start.latitude!, start.longitude!);
//     LatLng endLatLng = LatLng(end.latitude, end.longitude);
//     double lat1 = startLatLng.latitude;
//     double lat2 = endLatLng.latitude;
//     double lon1 = startLatLng.longitude;
//     double lon2 = endLatLng.longitude;

//     double dLat = _toRadians(lat2 - lat1);
//     double dLon = _toRadians(lon2 - lon1);
//     double a = pow(sin(dLat / 2), 2) +
//         cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     double distance = radiusOfEarth * c;
//     return distance;
//   }

//   double _toRadians(double degrees) {
//     return degrees * pi / 180;
//   }

//   void _onMarkerTapped(MarkerData marker) async {
//     LatLng destination = LatLng(marker.latitude!, marker.longitude!);
//     LatLng current =
//         LatLng(currentPosition!.latitude, currentPosition!.longitude);
//     List<LatLng> points = await _getRoute(current, destination);
//     setState(() {
//       markers.sort((a, b) => _distance(a, currentPosition!)
//           .compareTo(_distance(b, currentPosition!)));
//     });
//     mapController!.animateCamera(CameraUpdate.newLatLngZoom(destination, 15));
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         height: 200,
//         child: GoogleMap(
//           onMapCreated: (GoogleMapController controller) {
//             mapController = controller;
//           },
//           initialCameraPosition: CameraPosition(
//             target: current,
//             zoom: 15.0,
//           ),
//           polylines: {
//             Polyline(
//               polylineId: PolylineId('route'),
//               points: points,
//               width: 4,
//               color: Colors.blue,
//             ),
//           },
//           markers: {
//             Marker(
//               markerId: MarkerId(marker.name!),
//               position: destination,
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueRed),
//             ),
//             Marker(
//               markerId: MarkerId('current'),
//               position: current,
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue),
//             ),
//           },
//         ),
//       ),
//     );
//   }

//   Future<List<LatLng>> _getRoute(LatLng current, LatLng destination) async {
//     String apiKey = 'your_api_key_here';
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${current.latitude},${current.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       List<dynamic> coordinates =
//           data['routes'][0]['overview_polyline']['points'];
//       List<LatLng> points = [];
//       for (var coordinate in coordinates) {
//         points.add(_decodePolyline(coordinate));
//       }
//       return points;
//     } else {
//       throw Exception('Failed to load route');
//     }
//   }

//   LatLng _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//     return points.first;
//   }
// }
