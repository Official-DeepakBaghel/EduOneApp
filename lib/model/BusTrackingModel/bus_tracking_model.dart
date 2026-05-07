class Bus {
  final String id;
  final String busNumber;
  final String routeName;
  final String driverName;
  final String driverPhone;
  final String driverId;

  Bus({
    required this.id,
    required this.busNumber,
    required this.routeName,
    required this.driverName,
    required this.driverPhone,
    required this.driverId,
  });
}

class BusLocation {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double? speed;
  final double? heading;

  BusLocation({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.speed,
    this.heading,
  });
}

class BusTrip {
  final String id;
  final String busId;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isActive;
  final List<BusLocation> path;

  BusTrip({
    required this.id,
    required this.busId,
    required this.startTime,
    this.endTime,
    this.isActive = true,
    this.path = const [],
  });
}
