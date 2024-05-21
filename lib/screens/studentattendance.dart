import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool _isCheckedIn = false;
  String _currentLocation = 'Unknown';
  String _checkinTime = 'Not Checked In';
  String _checkoutTime = 'Not Checked Out';
  final double _targetLatitude = 28.6449734;
  final double _targetLongitude = 77.3465185;
  final double _radiusInMeters = 10.0;
  final List<Map<String, dynamic>> _attendanceData = [];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission again
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      // Location permission denied, show an error message or handle it accordingly
      setState(() {
        _currentLocation = 'Location permission denied';
      });
    } else {
      // Location permission granted, proceed to get the current location
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        _targetLatitude,
        _targetLongitude,
      );

      final now = DateTime.now();
      final checkinTime = DateFormat('HH:mm:ss').format(now);
      final checkoutTime = DateFormat('HH:mm:ss').format(now);

      setState(() {
        _currentLocation =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        if (distance <= _radiusInMeters) {
          if (!_isCheckedIn) {
            _isCheckedIn = true;
            _checkinTime = checkinTime;
            _checkoutTime = 'Not Checked Out';
            _saveAttendanceData(position.latitude, position.longitude, _checkinTime, _checkoutTime);
          } else {
            _isCheckedIn = false;
            _checkoutTime = checkoutTime;
            _saveAttendanceData(position.latitude, position.longitude, _checkinTime, _checkoutTime);
          }
        } else {
          _isCheckedIn = false;
          _checkinTime = 'Not Checked In';
          _checkoutTime = 'Not Checked Out';
        }
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Failed to get location: $e';
        _isCheckedIn = false;
        _checkinTime = 'Not Checked In';
        _checkoutTime = 'Not Checked Out';
      });
    }
  }

  Future<void> _saveAttendanceData(double latitude, double longitude, String checkinTime, String checkoutTime) async {
    final attendanceData = {
      'latitude': latitude,
      'longitude': longitude,
      'checkinTime': checkinTime,
      'checkoutTime': checkoutTime,
    };
    _attendanceData.add(attendanceData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/attendance_data.json');
    await file.writeAsString(jsonEncode(_attendanceData));
  }

  void _toggleCheckin() {
    _getCurrentLocation();
    print('Student has ${_isCheckedIn ? 'checked out at $_checkoutTime' : 'checked in at $_checkinTime'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_currentLocation),
            const SizedBox(height: 16.0),
            Text('Check-in Time: $_checkinTime'),
            const SizedBox(height: 8.0),
            Text('Check-out Time: $_checkoutTime'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _toggleCheckin,
              child: Text(_isCheckedIn ? 'Check Out' : 'Check In'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceDataScreen(attendanceData: _attendanceData),
                  ),
                );
              },
              child: const Text('View Attendance Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceDataScreen extends StatelessWidget {
  final List<Map<String, dynamic>> attendanceData;

  AttendanceDataScreen({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView.builder(
            itemCount: attendanceData.length,
            itemBuilder: (context, index) {
              final data = attendanceData[index];
              return ListTile(
                title: Text('Latitude: ${data['latitude']}, Longitude: ${data['longitude']}'),
                subtitle: Text('Check-in Time: ${data['checkinTime']}\nCheck-out Time: ${data['checkoutTime']}'),
              );
            },
          ),
        ),
      ),
    );
  }
}