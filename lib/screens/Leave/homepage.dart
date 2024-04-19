import 'package:flutter/material.dart';
import 'leave_application.dart';
import 'miscellaneous.dart';
import 'leave_status.dart';
import 'graduate_Seminar.dart';

import 'check_nodues.dart';
import 'package:fusion/Components/side_drawer.dart';
import 'package:fusion/Components/appBar.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

class HomePage extends StatelessWidget {
  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;

  HomePage() {
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
    return Scaffold(
      appBar: DefaultAppBar().buildAppBar(),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [],
            ),
            SizedBox(height: 40),
            Container(
              width: 380,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/unknown.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(name ?? 'Unknown', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(depttype ?? 'Unknown', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 380,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  buildClickableButton('Leave Application', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaveApplicationForm()),
                    );
                  }),
                  buildClickableButton('Leave Status', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaveStatus()),
                    );
                  }),
                  buildClickableButton('Check Dues', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckNoDues()),
                    );
                  }),
                  buildClickableButton('Miscellaneous', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MiscellaneousPage()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableButton(String buttonText, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 400,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange, width: 2),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
