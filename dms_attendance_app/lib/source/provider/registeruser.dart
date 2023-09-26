import 'dart:convert';
import 'dart:io';

import 'package:dms_attendance_app/export.dart';
import 'package:http/http.dart' as http;
class RegisterUser extends ChangeNotifier {
  bool changeindicator = false;

  change(bool indicator) {
    changeindicator = indicator;
    notifyListeners();
  }

  Future<void> sendUserRegister(List<String> imagePaths, String name, email,
      phone,siteid, BuildContext context) async {
    final url = Uri.parse('http://67.205.136.201:3001/api/enrollUser');

    // Create a multipart request
    final request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields.addAll({
      'name': name,
      'store': '1',
      'collections': 'OSO',
      'email': email,
      'phone': phone,
      'siteID':siteid
    });

    // Add image files
    for (final imagePath in imagePaths) {
      final file = File(imagePath);
      final fileName = file.path.split('/').last;

      request.files.add(await http.MultipartFile.fromPath('photos', imagePath,
          filename: fileName));
    }
    try {
      change(true);
      final response = await request.send();
      change(false);
      if (response.statusCode == 200) {
        var responsecheck = await response.stream.bytesToString();
        var data = jsonDecode(responsecheck);
        debugPrint(data.toString());
        showDialog(
          context: NavigationService.navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return CustomOptionDialugue(
              message: data['message'],
              status: data['status'],
            );
          },
        );
        // ZBotToast.showToastSuccess(message: data['message']);
        change(false);
      } else {
        change(false);
        var data = jsonDecode(response.reasonPhrase!);
        ZBotToast.showToastError(message: data['message']);
        debugPrint(data['message']);
      }
    } catch (e) {
      change(false);
      ZBotToast.showToastError(message: e.toString());
      debugPrint('Error: $e');
    }
  }

  Future<void> MarkAttendance(
      String image,siteid,method,
      BuildContext context
      ) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://67.205.136.201:3001/api/faceRecognize'));
      request.fields.addAll({'collections': 'OSO','siteID':siteid,'method':method});
      request.files.add(await http.MultipartFile.fromPath('photos', image));
      change(true);
      http.StreamedResponse response = await request.send();
      change(false);
      if (response.statusCode == 200) {
        var respo = await response.stream.bytesToString();
        Map<String, dynamic> data = jsonDecode(respo);
        if (data['status'] == 'Success') {
          showDialog(
            context: NavigationService.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CustomSucessDialugue(
                message: data['message'],
              );
            },
          );
        } else {
          showDialog(
            context: NavigationService.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CustomFailedDialugue(
                message: data['message'],
              );
            },
          );
        }

        debugPrint(data.toString());
      } else {
        change(false);
        debugPrint(response.reasonPhrase);
        var respo = await response.stream.bytesToString();
        Map<String, dynamic> data = jsonDecode(respo);

        // ZBotToast.showToastError(message:da.toString());
        showDialog(
          context: NavigationService.navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return CustomFailedDialugue(
              message: data['message'],
            );
          },
        );
      }
    } catch (e) {
      change(false);
      ZBotToast.showToastError(message: e.toString());
    }
  }

  //Login User
  Future<void> SiteMangerLogin(
      String email,password,
      BuildContext context
      ) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('http://67.205.136.201:3001/api/login'));
      request.body = json.encode({
        "email": "admin@example.com",
        "password": "12345!@#\$%"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var convert=await response.stream.bytesToString();
        Map<String,dynamic>data=jsonDecode(convert);
        if(data['status']=="Success")
          {

            Get.off(RegisterScreen());
            ZBotToast.showToastSuccess(message: "Login Successful");
          }
        else{
          ZBotToast.showToastError(message: "There is Some Error");
        }
      }
      else {
        var convert=await response.stream.bytesToString();
        Map<String,dynamic>data=jsonDecode(convert);
        if(data['status']==' Error')
          {
            ZBotToast.showToastError(message:data['message']);
          }
        else{
          ZBotToast.showToastError(message: "There is Some thing Wrong");
        }
      }
    } catch (e) {
      change(false);
      ZBotToast.showToastError(message: e.toString());
    }
  }

  //Get Sites
Future<Map<String, dynamic>> getsites()async{
    Map<String,dynamic>data={};
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('http://67.205.136.201:3001/api/allSites'));
      request.body = json.encode({
        "name": "Dev Sinc",
        "address": "Air Port",
        "city": "Lahore",
        "postalCode": "5412",
        "siteManagerName": "Dev Admin",
        "siteManagerEmail": "sitemanage2r@example.com",
        "password": "12345!@#\$%"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var convert=await response.stream.bytesToString();
        Map<String,dynamic>datai=jsonDecode(convert);
        data=datai;
        print(datai);
  }
  else {
  print(response.reasonPhrase);
  }
    }
        catch(e){

        }
    return data;
  }
}
