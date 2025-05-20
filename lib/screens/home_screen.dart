import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import '../providers/car_provider.dart';
import '../routes/splash_screen.dart';
import './car_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateCameraPosition();
  }

  void _updateCameraPosition() {
    if (_mapController == null || _markers.isEmpty) return;

    double minLat = _markers.first.position.latitude;
    double maxLat = _markers.first.position.latitude;
    double minLng = _markers.first.position.longitude;
    double maxLng = _markers.first.position.longitude;

    for (var marker in _markers) {
      if (marker.position.latitude < minLat) minLat = marker.position.latitude;
      if (marker.position.latitude > maxLat) maxLat = marker.position.latitude;
      if (marker.position.longitude < minLng)
        minLng = marker.position.longitude;
      if (marker.position.longitude > maxLng)
        maxLng = marker.position.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50.0),
    );
  }

  final List<Tab> tabs = const [
    Tab(text: "All"),
    Tab(text: "Moving"),
    Tab(text: "Parked"),
  ];
  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Consumer<CarProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && !isInit) {
            return const SplashScreen();
          }

          if (provider.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Error: ${provider.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => provider.fetchCars(),
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          isInit = true;
          _markers.clear();
          _markers.addAll(_buildMarkers(provider.cars));

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-1.94995, 30.05885),
                  zoom: 12,
                ),
                onMapCreated: _onMapCreated,
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    // Search Bar
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Search by name or ID",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => provider.search(value),
                    ),
                    const SizedBox(height: 10),
                    // Filter Chips
                    DefaultTabController(
                      initialIndex: 0,
                      length: tabs.length,
                      child: Column(
                        children: [
                          Container(
                            height: kToolbarHeight,
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                              color: theme.primaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorWeight: 5,
                              indicator: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              splashBorderRadius: BorderRadius.circular(30),
                              dividerHeight: 0,
                              unselectedLabelStyle:
                                  theme.textTheme.labelSmall?.copyWith(
                                fontSize: 15,
                                color: theme.colorScheme.surface,
                              ),
                              labelStyle: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              onTap: (index) {
                                if (index == 0) {
                                  provider.filterByStatus('');
                                } else if (index == 1) {
                                  provider.filterByStatus("Moving");
                                } else if (index == 2) {
                                  provider.filterByStatus("Parked");
                                }
                              },
                              tabs: tabs,
                            ),
                          ),

                          //
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(List<Car> cars) {
    return cars.map((car) {
      return Marker(
        markerId: MarkerId(car.id.toString()),
        position: LatLng(car.latitude, car.longitude),
        infoWindow: InfoWindow(
          title: car.name,
          snippet: 'Speed: ${car.speed} km/h',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CarDetailScreen(carId: car.id),
              ),
            );
          },
        ),
      );
    }).toSet();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
