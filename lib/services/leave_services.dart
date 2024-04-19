
import 'dart:convert';
import 'package:fusion/models/profile.dart';
import 'package:fusion/services/profile_service.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'package:fusion/constants.dart';
import 'package:fusion/services/service_locator.dart';
import 'package:fusion/services/storage_service.dart';

class LeaveService {

  Future<http.Response> initAuth() async {
    try {
      var storageService = locator<StorageService>();

      if (storageService.userInDB?.token == null) {
        throw Exception('Token Error');
      }

      Map<String, String> body = {
        'username': '21BCS086',
        'password': 'user@123',
      };

      print("Initial Authorization");
      var response = await http.post(
        Uri.http(kLeaveModule, kAuthLogin),
        body: body,
      );

      if (response.statusCode == 200) {
        print("Successfully authorized");
        return response;
      } else {
        throw Exception('Failed to authorize');
      }
    } catch (e) {
      throw Exception('Authorization Error: $e');
    }
  }

  Future<http.Response> getLeaves() async {
    try {
      var response0 = await initAuth();

      if (response0.statusCode ==200) {
        var token = json.decode(response0.body)['token'];

        Map<String, String> headers = {
          'Access-Control-Allow-Origin' : '*',
          'Authorization': 'Token $token',
        };

        print("Fetching leave requests");
        var response = await http.get(
          Uri.http(kLeaveModule, kLeaves),
          headers: headers,
        );

        if (response.statusCode == 201){
          print("Successfully fetched leave requests");
          return response;
        } else {
          throw Exception('Failed to fetch leave requests');
        }
      } else {
        throw Exception('Failed to authorize in Leave Request');
      }
    } catch (e) {
      throw Exception('Leave Request Error: $e');
    }
  }

  Future<http.Response> postLeaves(Map<String, dynamic> data) async {
    try {
      var response0 = await initAuth();

      if (response0.statusCode == 200) {
        var token = json.decode(response0.body)['token'];

        Map<String, String> headers = {
          'Access-Control-Allow-Origin' : '*',
          'Authorization': 'Token $token',
        };

        http.Response profileResponse = await ProfileService().getProfile();
        var id = json.decode(profileResponse.body)['user']['id'];

        // print(id);
        Map<String, dynamic> body = {
          'purpose' : data['purpose'],
          'applicant': id.toString(),
          'timestamp': data['timestamp'].toString(),
        };

        // print(headers);
        // print(body);
        // print(Uri.http(kLeaveModule, kLeaves));

        print("Sending leave requests");
        var response = await http.post(
          Uri.http(kLeaveModule, kLeaves),
          headers: headers,
          body: body
        );

        if (response.statusCode == 201) {
          print("Successfully posted leave request");
          return response;
        } else {
          print(json.decode(response.toString()));
          throw Exception('Failed to post leave request $response');
        }
      } else {
        throw Exception('Failed to authorize in Leave Request');
      }
    } catch (e) {
      throw Exception('Leave Request POST Error: $e');
    }
  }
}
