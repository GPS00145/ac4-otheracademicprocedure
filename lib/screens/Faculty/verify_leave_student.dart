import 'package:flutter/material.dart';

void main() {
  runApp(LeaveRequest());
}

class LeaveRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange, // Background color of orange
          title: Center(
            child: Text(
              'Leave Request',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Add back arrow icon
            onPressed: () {
              // Handle back arrow press here
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20), // Space between app bar and container
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[500], // Background color of gray with opacity
                  borderRadius: BorderRadius.circular(10), // Circular edges
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle, // Icon representing student
                      size: 150,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Student Name',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Space between container and info rows
              _buildCompactEditableInfoRow('Student Name:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('Roll No:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('Type:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('From:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('To:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('Purpose:', ''),
              SizedBox(height: 2), // Space between info rows
              _buildCompactEditableInfoRow('Address:', ''),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Approve',
                        style: TextStyle(color: Colors.white), ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange, // Set background color to orange
                    ),
                  ),
                  SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Decline',
                        style: TextStyle(color: Colors.white), ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange, // Set background color to orange
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactEditableInfoRow(String label, String initialValue) {
    return Container(
      padding: EdgeInsets.all(5), // Reduced padding for smaller box
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the row
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: initialValue, // Placeholder text
                border: InputBorder.none, // Remove default border
              ),
            ),
          ),
        ],
      ),
    );
  }
}
