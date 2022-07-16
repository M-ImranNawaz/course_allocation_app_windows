import 'package:course_allocation/controllers/base_controller.dart';
import 'package:course_allocation/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../contstants.dart';
import '../main.dart';
import '../models/reg_faculty.dart';
import '../services/base_client.dart';
import 'file_controller.dart';

class FacultyRegController extends GetxController with BaseController {
  List regFacultyData = [].obs;
  TextEditingController nameC = TextEditingController(),
      emailC = TextEditingController(),
      passwordC = TextEditingController();
  var rFaculty = <RegFaculty>[].obs;
  var isLoading = false.obs;

  regFaculty() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient.post(kBaseUrl, 'registerfaculty', {
      'name': nameC.text,
      'email': emailC.text,
      'password': passwordC.text
    }).catchError(handleError);
    hideLoading();
    if (response == null) return;
    if (response.toString() == '0') {}

    getData();
    if (response.toString().contains(emailC.text)) {
      print(response);
      List lDetails = response.toString().split('"');

      //navTo(Home(data: lDetails, isSignedIn: true));
      return lDetails;
    }
  }

  readFile() async {
    var sheet = await FileController().pickFile();
    if (sheet != 0) {
      regFacultyData.addAll(sheet['RegFaculty']); // = sheet['RegFaculty']!;
      //print(sheet['RegFaculty']);
      //save();
      Navigator.pop(navigatorkey.currentState!.context);
      DialogHelper.showCourseDialog(regFacultyData, false);
    }
  }

  sendData(regData) async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    List jsonData = [];
    for (int i = 1; i < regData.length; i++) {
      RegFaculty regFaculty = RegFaculty(
          id: 0,
          name: regData[i][0],
          email: regData[i][1],
          password: regData[i][2].toString());
      jsonData.add(regFaculty.toMap());
    }
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient
        .post(kBaseUrl, 'addallfaculty', jsonData)
        .catchError(handleError);
    hideLoading();
    Navigator.pop(navigatorkey.currentState!.context);
    DialogHelper.showErrorDialog(
        title: 'Success', description: 'Data saved in server');
    // Navigator.pop(navigatorkey.currentState!.context);
    // Navigator.pop(navigatorkey.currentState!.context);
    getData();
    // print(response);
    // print(regFacultyData);
    if (response == null) return;
    if (response.toString().contains('true')) {}
  }

  var l = facultyBox.length.obs;

  //getData
  Future<List<RegFaculty>> getData() async {
    isLoading(true);
    BaseClient baseClient = BaseClient();
    var response = await baseClient
        .get(
          kBaseUrl,
          'faculty',
        )
        .catchError(handleError);
    isLoading(false);
    if (response == null) return [];
    rFaculty.value = response.map<RegFaculty>(RegFaculty.fromJson).toList();
    print(rFaculty);
    return response.map<RegFaculty>(RegFaculty.fromJson).toList();
  }

  clearServerData() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    DialogHelper.showDeleteAlertDialog('Delete the Faculty',
        'Are you Sure you want to Delete all Faculty From Server', () async {
      BaseClient baseClient = BaseClient();
      showLoading();
      var response = await baseClient
          .get(
            kBaseUrl,
            'clearfaculty',
          )
          .catchError(handleError);
      hideLoading();
      rFaculty.clear();
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'All Data Deleted Succesfully');
      if (response == null) return;
    });
  }

  deleteFaculty(String id) async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    // DialogHelper.showDeleteAlertDialog('Delete the Faculty',
    //     'Are you Sure you want to Delete this Faculty From Server', () async {
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient
        .post(kBaseUrl, 'deletefaculty', {"id": id}).catchError(handleError);
    hideLoading();

    if (response.toString().contains('Data Deleted')) {
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'All Data Deleted Succesfully');
    }
    getData();
    if (response == null) return;
    //});
  }
}
