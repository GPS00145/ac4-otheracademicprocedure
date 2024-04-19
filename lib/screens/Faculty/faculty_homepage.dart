import 'package:flutter/material.dart';
import 'package:fusion/screens/Faculty/verify_leaves.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

void main() {
  runApp(FacultyHomepage());
}

class FacultyHomepage extends StatelessWidget {

  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;

  FacultyHomepage() {
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
          backgroundColor: Colors.deepOrange,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0), // Padding around the orange container
              child: SizedBox(
                width: 80, // Reduced width of the orange container
                child: Container(
                  height: 280, // Reduced height of the orange container
                  decoration: BoxDecoration(
                    color: Colors.orange[50], // Changed to orange color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Padding inside the orange container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140, // Reduced width of the profile picture container
                          height: 180, // Reduced height of the profile picture container
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/profile_pic.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Added spacing
                        Text(
                          name ?? 'Unknown',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0, // Reduced font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Added spacing between the orange container and buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons horizontally
              children: [
                SizedBox(
                  width: 850,
                  height:60,// Set the width of both buttons
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button onPressed logic here

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set button color to white
                      onPrimary: Colors.black, // Set text color to black
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.deepOrange, width: 2), // Increased border width
                      ),
                    ),
                    child: Text(
                      'Approve Assistantship',
                      style: TextStyle(
                        fontSize: 20, // Reduced font size
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 850,
                  height:60,// Set the width of both buttons
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button onPressed logic here
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VerifyLeave()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set button color to white
                      onPrimary: Colors.black, // Set text color to black
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.deepOrange, width: 2), // Increased border width
                      ),
                    ),
                    child: Text(
                      'Verify Leave',
                      style: TextStyle(
                        fontSize: 20, // Reduced font size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
