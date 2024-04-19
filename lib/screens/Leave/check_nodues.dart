import 'package:flutter/material.dart';

void main() {
  runApp(CheckNoDues());
}

class CheckNoDues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NoDuesScreen(),
      ),
    );
  }
}

class NoDuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0, left: 0),
          color: Colors.deepOrange,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),

                color: Colors.white,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'CHECK NO DUES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  _buildTableRow(['Student Name', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Roll No.', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Mess Due', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Library Due', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Hostel Due', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Placement Due', _buildTextField()], fontSize: 18),
                  _buildTableRow(['Total Due', _buildTextField()], fontSize: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(List<dynamic> rowData, {double fontSize = 16}) {
    return TableRow(
      children: List.generate(
        rowData.length,
            (index) => TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            width: index == 0 ? 120.0 : null,
            child: Center(
              child: _handleTableCellContent(rowData[index], fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleTableCellContent(dynamic content, {double fontSize = 16}) {
    if (content is String) {
      return Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    } else if (content is Widget) {
      return content;
    }
    return Container();
  }

  Widget _buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
