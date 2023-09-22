import 'dart:convert';
import 'dart:io';

import 'package:dms_attendance_app/export.dart';
import 'package:dms_attendance_app/source/widget/faileddialugue.dart';
import 'package:http/http.dart' as http;

import '../widget/sucessDialugue.dart';

class RegisterUser extends ChangeNotifier {
  bool changeindicator = false;

  change(bool indicator) {
    changeindicator = indicator;
    notifyListeners();
  }

  Future<void> sendUserRegister(
    List<String> imagePaths,
    String name,
  ) async {

    final url = Uri.parse('http://192.168.1.11:3000/upload');

    // Create a multipart request
    final request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields.addAll({
      'name': name,
      'store': '1',
      'collections': 'OSO',
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
        ZBotToast.showToastSuccess(message: data['message']);
      } else {
        var data = jsonDecode(response.reasonPhrase!);
        ZBotToast.showToastError(message: data['message']);
        debugPrint(data['message']);
      }
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
      debugPrint('Error: $e');

    }
  }

  Future<void> MarkAttendance(
      String image,
      BuildContext context
      ) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.11:3000/verify'));
    request.fields.addAll({
      'collections': 'OSO'
    });
    request.files.add(await http.MultipartFile.fromPath('photos',image));
    change(true);
    http.StreamedResponse response = await request.send();
    change(false);
    if (response.statusCode == 200) {
      var respo=await response.stream.bytesToString();
      List<dynamic> data=jsonDecode(respo);
      if(data.isEmpty){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomFailedDialugue(
              message: 'Person Not Found',
            );
          },
        );
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomSucessDialugue(
              message: '${data[0]['name']} Your Attendance Marked',
            );
          },
        );
      }

      // ZBotToast.showToastError(message: data.toString());
      debugPrint(data.toString());
    }
    else {
      debugPrint(response.reasonPhrase);
    }
  }
}
