import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/driver.png'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: isOnline ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Text(
              isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                color: isOnline ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Switch(
            value: isOnline,
            onChanged: (value) {
              setState(() {
                isOnline = value;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(1.474830, 124.842079),
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implementasikan logika untuk tombol ini
                  },
                  child: Text('Option 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implementasikan logika untuk tombol ini
                  },
                  child: Text('Option 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implementasikan logika untuk tombol ini
                  },
                  child: Text('Option 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
