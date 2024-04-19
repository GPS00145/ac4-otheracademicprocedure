import 'package:flutter/material.dart';

void main() {
  runApp(FacultyGraduateSeminar());
}

class FacultyGraduateSeminar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Graduate Seminar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepOrange, // Deep orange color
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.pop(context), // Handle back button press
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Grey background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/profile_pic.png', // Replace 'faculty_image.jpg' with your image file name
                        width: 130,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 200.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Grey background color
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'FACULTY NAME',
                                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Academic Assistant',
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Grey background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GRADUATE SEMINAR',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Grey background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ROLL NO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: ''),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Grey background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Seminar:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(hintText: 'DD/MM/YYYY'),
                              readOnly: true, // Set text field as read-only
                              onTap: () {
                                _selectDate(context); // Call function to open date picker
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate(context); // Call function to open date picker
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // If a date is selected, update the TextField with the selected date
      // For this, we need to find the TextField and use its controller to set the value
      TextEditingController _dateController = TextEditingController();
      _dateController.text = picked.toString().split(" ")[0];
    }
  }
}
