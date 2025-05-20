import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> _filteredCars = [];
  String _filterStatus = '';
  String _searchQuery = '';
  Timer? _timer;
  bool _isLoading = false;
  String? _error;

  List<Car> get cars => _filteredCars;

  bool get isLoading => _isLoading;

  String? get error => _error;

  CarProvider() {
    fetchCars();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchCars());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchCars() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final response = await http.get(
        Uri.parse('https://6829db25ab2b5004cb34fbfd.mockapi.io/cars'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _cars = data.map((json) => Car.fromJson(json)).toList();
        _applyFilters();
        await _saveToLocal(response.body);
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      _error = e.toString();
      await _loadFromLocal();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveToLocal(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedCars', data);
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cachedCars');
    if (cached != null) {
      final List<dynamic> data = json.decode(cached);
      _cars = data.map((json) => Car.fromJson(json)).toList();
      _applyFilters();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByStatus(String status) {
    _filterStatus = status;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredCars = _cars.where((car) {
      final matchQuery =
          car.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              car.id.toString().contains(_searchQuery);
      final matchStatus = _filterStatus.isEmpty || car.status == _filterStatus;
      return matchQuery && matchStatus;
    }).toList();
    notifyListeners();
  }

  Car? getCarById(int id) {
    try {
      return _cars.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }
}
