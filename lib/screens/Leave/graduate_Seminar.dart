import 'package:flutter/material.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

void main() {
  runApp(GraduateSeminar());
}

class GraduateSeminar extends StatelessWidget {
  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;

  GraduateSeminar() {
    var service = locator<StorageService>();
    if (service.profileData != null) {
      name = service.profileData!.user!["first_name"] +
          " " +
          service.profileData!.user!["last_name"];
      var department = service.profileData!.profile!['department'];
      if (department != null) {
        depttype = department['name'] + " " + service.profileData!.profile!['user_type'];
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Graduate Seminar',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          backgroundColor: Colors.deepOrange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back , color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0), // Adjust overall padding
              child: Column(
                children: [
                  // Image and student name in same container
                  Container(
                    width: 380.0,
                    height: 280.0, // Adjusted height to accommodate both image and text
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0), // Adjust padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image with circular edges
                        Container(
                          width: 220.0,
                          height: 185.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/unknown.jpg', // Path to your image asset
                              fit: BoxFit.cover, // Ensure the image covers the container
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0), // Add spacing between image and text
                        // Student info
                        Text(name ?? 'Unknown', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        Text(depttype ?? 'Unknown', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35.0),

                  // Top right square with seminar info
                  Container(
                    width: 380.0, // Keep width same
                    height: 80.0, // Increase height
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(15.0), // Adjust padding
                    child: Column(
                      children: [
                        Text(
                          '[Graduate Seminar Date]',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '[12/01/2024]',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
