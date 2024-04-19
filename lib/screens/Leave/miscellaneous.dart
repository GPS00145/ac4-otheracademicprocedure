import 'package:flutter/material.dart';
import 'assistantship_form.dart';
import 'bonafide.dart';
import 'graduate_Seminar.dart';
import 'assistantclaimstatus.dart';
import 'package:fusion/services/login_service.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';


class MiscellaneousPage extends StatelessWidget {
  bool _loading = false;
  int count = 0;
  String? name;
  String? depttype;

  MiscellaneousPage() {
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
        title: Text('MISCELLANEOUS', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                context); // Pop the current page when the arrow is pressed
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Container( // Orange container for buttons
                width: 380,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildClickableButton('Apply for Bonafide', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => bonafied()),
                      );
                      print('Apply for Bonafide clicked');
                    }),
                    SizedBox(height: 5),
                    buildClickableButton('Assistantship claim Form', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AssistantshipFormPage()),
                      );
                      print('Assistantship claim Form clicked');
                    }),
                    SizedBox(height: 5),
                    buildClickableButton('Assistantship claim Status', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AssistantClaimStatus()),
                      );
                      print('Assistantship claim Status clicked');
                    }),
                    SizedBox(height: 5),
                    buildClickableButton('Graduate Seminar', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GraduateSeminar()),
                      );
                      print('Graduate Seminar clicked');
                    }),
                  ],
                ),
              ),
            ],
          ),
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
