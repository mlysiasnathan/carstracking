import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';

class TrackingScreen extends StatefulWidget {
  final int carId;

  const TrackingScreen({super.key, required this.carId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, provider, _) {
        final car = provider.getCarById(widget.carId);
        if (car == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tracking')),
            body: const Center(child: Text('Car not found')),
          );
        }

        _markers = {
          Marker(
            markerId: MarkerId(car.id.toString()),
            position: LatLng(car.latitude, car.longitude),
            infoWindow: InfoWindow(
              title: car.name,
              snippet: 'Speed: ${car.speed} km/h',
            ),
          ),
        };

        return Scaffold(
          appBar: AppBar(
            title: Text('Tracking ${car.name}'),
          ),
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(car.latitude, car.longitude),
                  zoom: 16,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Status: ${car.status}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Speed: ${car.speed} km/h',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
} 