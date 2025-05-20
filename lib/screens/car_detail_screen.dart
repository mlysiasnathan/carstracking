import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import 'tracking_screen.dart';

class CarDetailScreen extends StatelessWidget {
  final int carId;

  const CarDetailScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Consumer<CarProvider>(
      builder: (context, provider, _) {
        final car = provider.getCarById(carId);
        if (car == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Car Details')),
            body: const Center(child: Text('Car not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(car.name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: theme.primaryColor),
                      ),
                      width: deviceSize.width * 0.4,
                      height: deviceSize.width * 0.3,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          gradient: RadialGradient(
                            center: const Alignment(0.65, -0.8),
                            colors: [
                              theme.colorScheme.surface.withOpacity(0.8),
                              Colors.blue.withOpacity(0.6),
                            ],
                            // transform: const GradientRotation(-10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              car.status == 'Parked'
                                  ? CupertinoIcons.arrow_3_trianglepath
                                  : CupertinoIcons.car_detailed,
                              color: Colors.white,
                              size: 70,
                            ),
                            FittedBox(
                              child: Text(
                                car.status,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              'Status',
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: theme.primaryColor),
                      ),
                      width: deviceSize.width * 0.4,
                      height: deviceSize.width * 0.3,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.yellow, Colors.orange]
                                .sublist(0, 2),
                            transform: const GradientRotation(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              CupertinoIcons.speedometer,
                              color: Colors.white,
                              size: 70,
                            ),
                            FittedBox(
                              child: Text(
                                '${car.speed} km/h',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            Text(
                              'Speed',
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Car Status Card
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Location: lat ${car.latitude.toStringAsFixed(4)}, long ${car.longitude.toStringAsFixed(4)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                // Mini Map
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(car.latitude, car.longitude),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(car.id.toString()),
                          position: LatLng(car.latitude, car.longitude),
                          infoWindow: InfoWindow(title: car.name),
                        ),
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Track Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrackingScreen(carId: car.id),
                        ),
                      );
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('Track This Car'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
