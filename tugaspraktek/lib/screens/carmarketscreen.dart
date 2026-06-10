import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/carmodel.dart';

class CarMarketplace extends StatefulWidget {
  const CarMarketplace({super.key});

  @override
  State<CarMarketplace> createState() => _CarMarketplaceScreenState();
}

class _CarMarketplaceScreenState extends State<CarMarketplace> {
  final String apiUrl = "https://myfakeapi.com/api/cars/";
  List<Car> carList = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  Future<void> fetchCarData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> carsJson = data['cars'] ?? [];
        
        setState(() {
          // Mapping data JSON ke dalam List Objek Car
          carList = carsJson.map((json) => Car.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Gagal memuat data: Status ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Terjadi kesalahan jaringan atau server.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.directions_car_filled, color: Color(0xFF3B82F6), size: 22),
            const SizedBox(width: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: 'MOBIL', style: TextStyle(color: Colors.white)),
                  TextSpan(text: '-BEKAS', style: TextStyle(color: Color(0xFF3B82F6))),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Temukan Mobil Impian Dengan Harga Terjangkau",
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Menampilkan ${carList.length} unit mobil bekas tersedia secara live",
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(), 
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: carList.length, 
                      itemBuilder: (context, index) {
                        final car = carList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFF334155), width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF1E3A8A), Color(0xFF1E293B)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(Icons.directions_car, size: 70, color: Colors.white24),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: car.isAvailable ? Colors.green.withOpacity(0.8) : Colors.redAccent.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          car.isAvailable ? "TERSEDIA" : "DIRESERVASI",
                                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${car.brand} ${car.model}",
                                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Text(
                                          car.year.toString(),
                                          style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.palette, color: Colors.grey, size: 14),
                                        const SizedBox(width: 6),
                                        Text("Warna: ${car.color}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                      ],
                                    ),
                                    const Divider(color: Color(0xFF334155), height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(car.price, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF3B82F6),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                          onPressed: car.isAvailable ? () {} : null,
                                          icon: const Icon(Icons.shopping_cart, size: 14, color: Colors.white),
                                          label: const Text("Beli", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}