import 'dart:convert';

import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<dynamic> savedBoardings = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch saved boardings when the widget is initialized
    fetchSavedBoardings(UserData.currentUser!.authToken);
  }

  Future<void> fetchSavedBoardings(String authToken) async {
  String apiUrl = 'http://192.168.239.100:8000/api/tenant/saved-boardings/';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $authToken', // Replace with your actual token
      },
    );

    if (response.statusCode == 200) {
      // Parse the response and handle the data as needed
      List<dynamic> savedBoardings = json.decode(response.body);
      // Handle the list of saved boardings (e.g., update UI, store in state)
      print('Saved Boardings: $savedBoardings');
    } else {
      print('Failed to fetch saved boardings. Status code: ${response.statusCode}');
      // Handle the error or show an appropriate message
    }
    } catch (e) {
      print('Error fetching saved boardings: $e');
      // Handle the error or show an appropriate message
    }
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
