import 'package:flutter/material.dart';
import 'package:fusion/screens/Faculty/verify_leave_student.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

void main() {
  runApp(VerifyLeave());
}

class VerifyLeave extends StatelessWidget { bool _loading = false;
int count = 0;
String? name;
String? depttype;

VerifyLeave(){
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
            'Verify Leaves',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0), // Add padding around the orange container
              child: SizedBox(
                width: 200, // Reduce the width of the orange container
                child: Container(
                  height: 300, // Reduce the height of the orange container
                  decoration: BoxDecoration(
                    color: Colors.orange[50], // Change to orange color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Add padding inside the orange container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,//Reduce the width of the profile picture container
                          height: 210,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/profile_pic.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(name ??
                          'Unknown',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0, // Reduce font size
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300, // Set the desired width for the SingleChildScrollView
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('S.No')),
                    DataColumn(label: Text('STUDENT NAME')),
                    DataColumn(label: Text('ROLL NO')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('1')),
                        DataCell(Text('GAURAV SINGH')),
                        DataCell(Text('21BCS086')),
                      ],
                      onSelectChanged: (bool? isSelected) {
                        if (isSelected != null && isSelected) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LeaveRequest()),                       // Navigate or perform action here when the row is clicked
                         );
                        }
                      },
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('2')),
                        DataCell(Text('OMKAR GADAM')),
                        DataCell(Text('21BCS083')),
                      ],
                      onSelectChanged: (bool? isSelected) {
                        if (isSelected != null && isSelected) {
                          // Navigate or perform action here when the row is clicked
                          print('Clicked on OMKAR GADAM');
                        }
                      },
                    ),
                    // Add similar DataRow widgets for other rows...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
