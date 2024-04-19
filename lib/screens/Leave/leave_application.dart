import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:fusion/services/leave_services.dart';
import 'package:http/http.dart' as http;

class LeaveApplicationForm extends StatefulWidget {
  @override
  _LeaveApplicationFormState createState() => _LeaveApplicationFormState();
}

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  String? selectedLeaveType = 'Sick Leave';
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String address = '';
  String purpose = '';
  String? filePath; // Variable to store the file path
  String? fileName; // Variable to store the file name

  LeaveService _leaveService = LeaveService();

  void _sendLeaveApplication(Map<String, dynamic> data) async {
    try {
      http.Response response = await _leaveService.postLeaves(data);

      if (response.statusCode == 200) {
        print("Leave Application sent successfully");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'APPLY LEAVE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange, // Color the app bar in deep orange
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Set the color of the back arrow to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Leave Application container
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.deepOrange,
                child: Text(
                  '         Leave Application            ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            // Rest of the form elements
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Leave type dropdown
                  SizedBox(height: 20),
                  Text(
                    'Leave type *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // Remove the border property to remove the grey background
                    ),
                    child: DropdownButton<String>(
                      value: selectedLeaveType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedLeaveType = newValue;
                        });
                      },
                      items: <String>[
                        'Sick Leave',
                        'Vacation',
                        'Personal Leave'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // From and To dates
                  Text(
                    'From *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: fromDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          fromDate = selectedDate;
                        });
                      }
                    },
                    child: Text('Select'),
                  ),
                  Text(
                    'Selected From Date: ${fromDate.toString().substring(0, 10)}',
                  ), // Display selected From date

                  SizedBox(height: 20),

                  Text(
                    'To *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: toDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          toDate = selectedDate;
                        });
                      }
                    },
                    child: Text('Select'),
                  ),
                  Text(
                    'Selected To Date: ${toDate.toString().substring(0, 10)}',
                  ), // Display selected To date

                  SizedBox(height: 20),

                  // File picker button
                  ElevatedButton(
                    onPressed: () async {
                      // Open file picker when button is pressed
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          filePath = result.files.single.path;
                          fileName = result.files.single.name;
                        });
                      }
                    },
                    child: Text('Choose File'),
                  ),
                  // Display selected file path
                  if (fileName != null) Text('Selected File: $fileName'),

                  SizedBox(height: 20),

                  // Address and Purpose text fields
                  Text(
                    'Address *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                  ),
                  Text(
                    'Purpose *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        purpose = value;
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      // Implement form submission logic
                      // You can use the values of selectedLeaveType, fromDate, toDate, address, purpose, filePath for submission.
                      Map<String, dynamic> data = {'purpose': purpose, 'timestamp': DateTime.now()};
                      _sendLeaveApplication(data);
                      print('Leave Application Submitted');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color:
                                Colors.white), // Change font color to black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(LeaveApplicationForm());
}
