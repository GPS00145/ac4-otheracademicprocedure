import 'package:flutter/material.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

void main() {
  runApp(AssistantClaimStatus());
}

class AssistantClaimStatus extends StatelessWidget {

  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;

  AssistantClaimStatus() {
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
      appBar: AppBar(
        title: Text('Assistantship Status'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 380.0,
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/unknown.jpg',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
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
              width: MediaQuery.of(context).size.width - 40,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'NAME',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),

                  buildTableRow('ROLL', ''),
                  buildTableRow('DATE', ''),
                  buildTableRow('FORM', ''),

                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text('Approve: 10', style: TextStyle(fontSize: 20)),
                Text('Reject: 5', style: TextStyle(fontSize: 20)),
                Text('Pending: 3', style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(String title, String content) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            height: 40,
            padding: EdgeInsets.all(8),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        TableCell(
          child: Container(
            height: 40,
            padding: EdgeInsets.all(8),
            child: Text(
              content,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  TableRow buildTableRowWithStatus(String title) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            height: 40,
            padding: EdgeInsets.all(8),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),

      ],
    );
  }
}
