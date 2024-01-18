import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String email;
  final String role;
  final String authToken;
  final int id;
  final String imageUrl;

  User({
    required this.username,
    required this.email,
    required this.role,
    required this.authToken,
    required this.id,
    required this.imageUrl,
  });
}

Future<void> signUpTenant(
    String username, String email, String password, String role) async {
  final String apiUrl = 'http://192.168.239.100:8000/api/auth/register/tenant/';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'user': {
        'username': username,
        'email': email,
        'role': role,
        'password': password,
      }
    }),
  );

  if (response.statusCode == 201) {
    // Successful registration
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(
        'User registered successfully: ${responseData["username"]}, ${responseData["email"]}, ${responseData["role"]}');
    // You can handle the successful registration response here
  } else {
    // Registration failed
    print('Failed to register user. ${response.body}');
    // You can handle the registration failure response here
  }
}

Future<void> signUpOwner(
    String username, String email, String password, String role) async {
  final String apiUrl = 'http://192.168.239.100:8000/api/auth/register/owner/';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'user': {
        'username': username,
        'email': email,
        'role': role,
        'password': password,
      }
    }),
  );

  if (response.statusCode == 201) {
    // Successful registration
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(
        'User registered successfully: ${responseData["username"]}, ${responseData["email"]}, ${responseData["role"]}');
    // You can handle the successful registration response here
  } else {
    // Registration failed
    print('Failed to register user. ${response.body}');
    // You can handle the registration failure response here
  }
}

String? authToken;

Future<User?> signIn(String username, String password) async {
  final String apiUrl = 'http://192.168.239.100:8000/api/auth/login/';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(
          'Login successful: ${responseData["username"]} ,${responseData['role']}');
      // You can handle the successful login response here
      if (responseData['token'] != null && responseData['data'] != null) {
        print('hsdjahd');
        // Extract user details from 'data'
        final userData = responseData['data'];
        User user = User(
          username: userData['user']['username'],
          email: userData['user']['email'],
          role: userData['user']['role'],
          authToken: responseData['token'],
          imageUrl: userData['user']['profile_image'],
          id: userData['user']['id'],
        );
        authToken = responseData['token'];
        print(authToken);
        return user;
      } 
      
      else {
        // Login failed
        print('Failed to login. ${response.body}');
        // You can handle the login failure response here
        return null;
      }
    }
  } catch (e) {
    print('Error during login: $e');
    return null; // Other exceptions
  }
}
