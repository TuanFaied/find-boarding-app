import 'dart:convert';
import 'package:findboarding/Screens/Login/components/login_form.dart';
import 'package:findboarding/Screens/Login/login_screen.dart';
import 'package:findboarding/Screens/Owner/widgets/proflie_widget.dart';
import 'package:findboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Future<void> updateUserDetails(
      String username, String email, String password) async {
    const String updateUrl =
        'http://192.168.239.100:8000/api/user/update-user/';

    final Map<String, dynamic> updateData = {
      'username': username,
      'email': email,
      'password': password,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${UserData.currentUser?.authToken}',
    };

    try {
      final response = await http.put(
        Uri.parse(updateUrl),
        headers: headers,
        body: jsonEncode(updateData),
      );
      if (response.statusCode == 200) {
        print('User details updated successfully.');
      } else {
        // Handle error response
        print('Error updating user details: ${response.body}');
      }
    } catch (e) {
      // Handle exception
      print('Error updating user details: $e');
    }
  }

  Future<void> logout() async {
    final String logoutUrl = 'http://192.168.239.100:8000/api/auth/logout/';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${UserData.currentUser?.authToken}',
    };

    try {
      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('Logout successful.');
        // Navigate to the login screen or perform any other actions after logout
      } else {
        // Handle error response
        print('Error during logout: ${response.body}');
      }
    } catch (e) {
      // Handle exception
      print('Error during logout: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 70,
            ),
            ProfileWidget(
                imagePath:
                    'http://192.168.239.100:8000${UserData.currentUser!.imageUrl}',
                isedit: true,
                onClicked: () async {}),
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5,
                horizontal: defaultPadding,
              ),
              child: Text(
                'Change User Credentials',
                style: TextStyle(
                  fontSize: 25, // Set your desired font size
                  fontWeight: FontWeight.bold, // Set your desired font weight
                  color: Colors.black, // Set your desired text color
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5,
                horizontal: defaultPadding,
              ),
              child: TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Your email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5,
                horizontal: defaultPadding,
              ),
              child: TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Your Username",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person_2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5,
                horizontal: defaultPadding,
              ),
              child: TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  updateUserDetails(_nameController.text, _emailController.text,
                      _passwordController.text);
                }
              },
              child: const Text(
                'Seve change',
                style: TextStyle(
                  fontSize: 16, // Set your desired font size
                  fontWeight: FontWeight.bold, // Set your desired font weight
                  color: Colors.white, // Set your desired text color
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              
              onPressed: () {
                logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set your desired background color here
                  ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
