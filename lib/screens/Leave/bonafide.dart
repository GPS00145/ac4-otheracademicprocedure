import 'package:flutter/material.dart';

class bonafied extends StatefulWidget {
  @override
  _BonafiedState createState() => _BonafiedState();
}

class _BonafiedState extends State<bonafied> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'APPLY BONAFIED FOR',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat', // Custom font family
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 70,
            child: DropdownButton<String>(
              isExpanded: true,
              items: [
                DropdownMenuItem<String>(
                  value: 'Option 1',
                  child: Text('SIM'),
                ),
                DropdownMenuItem<String>(
                  value: 'Option 2',
                  child: Text('PASSPORT'),
                ),
                DropdownMenuItem<String>(
                  value: 'Option 3',
                  child: Text('INCOME TAX'),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                });
              },
              hint: Text('Select an option'),
              value: selectedOption,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle submit button press
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              onPrimary: Colors.white,
            ),
            child: Text('Submit'),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: bonafied(),
  ));
}
