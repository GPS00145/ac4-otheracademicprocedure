
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fusion/services/leave_services.dart';
import 'package:http/http.dart' as http;
import 'package:fusion/services/login_service.dart';
import 'package:fusion/models/profile.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';



class LeaveStatus extends StatefulWidget {
  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;
  ProfileData? _profileData;

  LeaveStatus() {
    var service = locator<StorageService>();
    _profileData = service.profileData;
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
  _LeaveStatusState createState() => _LeaveStatusState();
}

class _LeaveStatusState extends State<LeaveStatus> {

  LeaveService _leaveService = LeaveService();


  bool _loading = true;
  List<Map<String, dynamic>> _leaveList = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaves();
  }

  void _fetchLeaves() async {
    try {

      http.Response response = await _leaveService.getLeaves();

      if (response.statusCode == 200) {

        List<dynamic> leaveList = json.decode(response.body)['leave'];
        List<Map<String, dynamic>> mappedLeaveList = (widget._profileData?.profile?['user_type'] == "student") ? leaveList.map((item) => item as Map<String, dynamic>).toList().where((element) => element['applicant'] == widget._profileData?.user?['id']).toList()
                                                      : leaveList.map((item) => item as Map<String, dynamic>).toList();


        // print(mappedLeaveList);

        setState(() {
          _leaveList = mappedLeaveList;
          _loading = false;
        });
      }
    } catch (e) {

      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a function to handle delete operation
    void deleteEntry(int index) {
      // Implement the delete logic here
      print('Deleted entry at index: $index');
    }

    int approvedCount = 0;
    int pendingCount = 0;
    int declinedCount = 0;

    _leaveList.forEach((leave) {
      String status = leave['status'];
      if (status == 'approved') {
        approvedCount++;
      } else if (status == 'pending') {
        pendingCount++;
      } else if (status == 'declined') {
        declinedCount++;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave Status',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Orange container for the icon and student name
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10.0), // Set the border radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/unknown.jpg', // Replace 'unknown.jpg' with your image asset path
                          width: 120.0,
                          height: 170.0,
                        ),
                        SizedBox(height: 20),
                        Text( widget.name ?? 'Unknown',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // SizedBox to separate the containers vertically
          SizedBox(height: 20),

          // Orange container for the table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10.0), // Set the border radius
              ),
              child: _loading == true ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: _leaveList.isNotEmpty
                          ? _leaveList.first.keys.map((String key) {
                        return DataColumn(label: Text(key));
                      }).toList()
                          : const [],
                      rows: _leaveList.map((Map<String, dynamic> data) {
                        return DataRow(
                            cells: data.values.map((dynamic value) {
                              return DataCell(Text('$value'));
                            }).toList());
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Button row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Approved: $approvedCount',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pending: $pendingCount',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Declined: $declinedCount',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


