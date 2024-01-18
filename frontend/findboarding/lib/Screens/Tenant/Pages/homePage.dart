import 'package:flutter/material.dart';
import '../../allBoaardingHouseList.dart'; // Corrected typo in the import
import '../../../constants.dart';
import '../../Login/components/login_form.dart';
import '../../SearchPage.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('${UserData.currentUser?.imageUrl}');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 133, 8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 133, 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  // Adjust the left padding as needed
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'http://192.168.239.100:8000${UserData.currentUser?.imageUrl}'), // Replace with your image
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Hi,${UserData.currentUser?.username} ', // Replace with the actual username
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          // Search Bar
          GestureDetector(
            onTap: () {
              // Open search page here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 236, 231, 143),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Text('Search for boardings by university or faculty...'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Boarding Details Cards
          Expanded(
            child: BoardingHouseList(),
          ),
        ],
      ),
    );
  }
}

