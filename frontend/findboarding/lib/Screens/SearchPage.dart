import 'dart:convert';

import 'package:findboarding/Screens/boardingDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<BoardingHouse> boardingHouses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Boardings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter university name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchBoardingHouses();
            },
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: boardingHouses.length,
              itemBuilder: (context, index) {
                BoardingHouse boardingHouse = boardingHouses[index];
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Map<String, dynamic> boardingHouseMap = {
                          'id': boardingHouse.id,
                          'owner': boardingHouse.owner,
                          'address': boardingHouse.address,
                          'rent': boardingHouse.rent,
                          'number_of_rooms': boardingHouse.numberOfRooms,
                          'capacity_of_people': boardingHouse.capacityOfPeople,
                          'university_name': boardingHouse.universityName,
                          'university_faculty': boardingHouse.universityFaculty,
                          'university_location': boardingHouse.universityLocation,
                          'location': boardingHouse.location,
                          'phone_number': boardingHouse.phoneNumber,
                          'images': boardingHouse.imageUrls,
                        };
                      // Navigate to BoardingDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BoardingDetailsPage(boardingHouse: boardingHouseMap),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(boardingHouse.address),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rent: ${boardingHouse.rent}"),
                          Text(
                              "Number of Rooms: ${boardingHouse.numberOfRooms}"),
                          // Add more details as needed
                        ],
                      ),
                      leading: boardingHouse.imageUrls?.isNotEmpty ?? false
                          ? Image.network(
                              boardingHouse.imageUrls.first,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Placeholder(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchBoardingHouses() async {
    String searchQuery = _searchController.text;
    String apiUrl =
        'http://192.168.239.100:8000/api/boardings/search/?university_name=$searchQuery';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Parse the response and update the boardingHouses list
        List<BoardingHouse> parsedBoardingHouses =
            parseBoardingHouses(response.body);
        for (BoardingHouse boardingHouse in parsedBoardingHouses) {
          final List<String>? imageUrls = await boardingHouse.fetchImages();
          if (imageUrls != null && imageUrls.isNotEmpty) {
            boardingHouse.imageUrls = imageUrls;
          }
        }
        setState(() {
          boardingHouses = parsedBoardingHouses;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<BoardingHouse> parseBoardingHouses(String responseBody) {
    final parsed = json.decode(responseBody) as List<dynamic>;
    return parsed.map((json) => BoardingHouse.fromJson(json)).toList();
  }
}

class BoardingHouse {
  final int id;
  final String owner;
  final String address;
  final String rent;
  final int numberOfRooms;
  final int capacityOfPeople;
  final String universityName;
  final String universityFaculty;
  final String universityLocation;
  final String location;
  final String? phoneNumber;
  List<String> imageUrls; // Added property for image URLs

  Future<List<String>?> fetchImages() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.239.100:8000/api/boardings/$id/images'));

      if (response.statusCode == 200) {
        final List<dynamic> imagesData = json.decode(response.body);
        if (imagesData != null) {
          List<String> imageUrls = imagesData
              .map((image) => image['image']?.toString())
              .whereType<String>()
              .toList();
          return imageUrls.isNotEmpty ? imageUrls : null;
        } else {
          return null; // Return null if 'images' field is null
        }
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      return null;
    }
  }

  BoardingHouse({
    required this.id,
    required this.owner,
    required this.address,
    required this.rent,
    required this.numberOfRooms,
    required this.capacityOfPeople,
    required this.universityName,
    required this.universityFaculty,
    required this.universityLocation,
    required this.location,
    required this.phoneNumber,
    required this.imageUrls,
  });

  factory BoardingHouse.fromJson(Map<String, dynamic> json) {
    return BoardingHouse(
      id: json['id'],
      owner: json['owner'],
      address: json['address'],
      rent: json['rent'],
      numberOfRooms: json['number_of_rooms'],
      capacityOfPeople: json['capacity_of_people'],
      universityName: json['university_name'],
      universityFaculty: json['university_faculty'],
      universityLocation: json['university_location'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      imageUrls: List<String>.from(
          json['images']?.map((image) => image['image_url']) ?? []),
    );
  }
}
