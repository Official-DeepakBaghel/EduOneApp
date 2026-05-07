import 'package:get/get.dart';
import '../../model/BusTrackingModel/bus_tracking_model.dart';
import 'dart:async';

class BusTrackingController extends GetxController {
  var buses = <Bus>[].obs;
  var activeTrips = <String, BusTrip>{}.obs; // BusID -> Trip
  var currentBusLocations = <String, BusLocation>{}.obs; // BusID -> Location

  var selectedBus = Rxn<Bus>();
  var userRole = 'user'.obs; // 'user', 'driver', 'admin'
  var isTripActive = false.obs;

  Timer? _locationTimer;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    buses.assignAll([
      Bus(
        id: '1',
        busNumber: 'UP81-AT-1234',
        routeName: 'Route A: Mathura to College',
        driverName: 'Ramesh Singh',
        driverPhone: '+91 9876543210',
        driverId: 'D001',
      ),
      Bus(
        id: '2',
        busNumber: 'UP81-BT-5678',
        routeName: 'Route B: Agra to College',
        driverName: 'Suresh Kumar',
        driverPhone: '+91 9876543211',
        driverId: 'D002',
      ),
    ]);

    // Initial locations
    currentBusLocations['1'] = BusLocation(
      latitude: 27.4924,
      longitude: 77.6737,
      timestamp: DateTime.now(),
    );
    currentBusLocations['2'] = BusLocation(
      latitude: 27.1767,
      longitude: 78.0081,
      timestamp: DateTime.now(),
    );
  }

  void setRole(String role) {
    userRole.value = role;
  }

  // Driver Actions
  void startTrip(String busId) {
    isTripActive.value = true;
    final trip = BusTrip(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      busId: busId,
      startTime: DateTime.now(),
    );
    activeTrips[busId] = trip;

    // Simulate location updates
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      updateDriverLocation(busId);
    });
  }

  void endTrip(String busId) {
    isTripActive.value = false;
    _locationTimer?.cancel();
    if (activeTrips.containsKey(busId)) {
      final trip = activeTrips[busId]!;
      activeTrips[busId] = BusTrip(
        id: trip.id,
        busId: trip.busId,
        startTime: trip.startTime,
        endTime: DateTime.now(),
        isActive: false,
        path: trip.path,
      );
    }
  }

  void updateDriverLocation(String busId) {
    // In real app, get GPS coordinates
    final currentLocation = currentBusLocations[busId];
    if (currentLocation != null) {
      currentBusLocations[busId] = BusLocation(
        latitude: currentLocation.latitude + 0.001,
        longitude: currentLocation.longitude + 0.001,
        timestamp: DateTime.now(),
      );
    }
  }

  // Helper to calculate ETA (Mock)
  String getETA(String busId) {
    // Mock ETA calculation
    return "15 mins";
  }

  String getDistance(String busId) {
    return "4.5 km";
  }
}
