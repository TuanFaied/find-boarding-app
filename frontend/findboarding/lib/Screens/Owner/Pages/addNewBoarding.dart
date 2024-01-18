import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddNewBoardingPage extends StatefulWidget {
  const AddNewBoardingPage({Key? key}) : super(key: key);

  @override
  _AddNewBoardingPageState createState() => _AddNewBoardingPageState();
}

class _AddNewBoardingPageState extends State<AddNewBoardingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Boarding'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Change this to your desired background color
                minimumSize: Size(200, 50), // Set your desired width and height
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add, // Add your desired icon
                    size: 24, // Set your desired icon size
                  ),
                  SizedBox(width: 8), // Adjust the spacing between icon and text
                  Text(
                    'Pick Images',
                    style: TextStyle(
                      fontSize: 16, // Set your desired font size
                      fontWeight: FontWeight.bold, // Set your desired font weight
                      color: Colors.white, // Set your desired text color
                    ),
                  ),
                ],
              ),
            ),
            // if (_imageList != null)
            //   Column(
            //     children: _imageList!.map((image) {
            //       return Image.file(
            //         image as File,
            //         width: 100.0,
            //         height: 100.0,
            //         fit: BoxFit.cover,
            //       );
            //     }).toList(),
            //  ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'User Name ',
                border: OutlineInputBorder(),
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter University name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Faculty name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Number of Rooms',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Person capacity',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Boarding Rent',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Boarding Location URL',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              
              decoration: InputDecoration(
                labelText: 'Enter university name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              
            },
            child: Text('Search'),
          ),
          ],
        ),
      ),
    );
  }
}
