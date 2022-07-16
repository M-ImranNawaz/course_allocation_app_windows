import 'package:course_allocation/controllers/base_controller.dart';
import 'package:course_allocation/models/s_course.dart';
import 'package:get/get.dart';
import '../contstants.dart';
import '../dialog_helper.dart';
import '../main.dart';
import '../models/reg_faculty.dart';
import '../services/base_client.dart';

class FacultyPrefController extends GetxController with BaseController {
  List prefs = [];
  List<RegFaculty> faculty = [];
  List<SCourse> course = [];
  List fileData = [];
  getData() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    BaseClient baseClient = BaseClient();
    var response = await baseClient
        .get(
          kBaseUrl,
          'getallfacultypreferences',
        )
        .catchError(handleError);
    if (response == null) {
      DialogHelper.showErrorDialog(
          description: 'Courses or Faculty Data is not Available');
      return;
    }
    var pref = response[0];
    faculty = pref['Faculty'].map<RegFaculty>(RegFaculty.fromJson).toList();
    prefs = response;
  }

  List<RegFaculty> getFacultyData(int index) {
    return prefs[index]['Faculty']
        .map<RegFaculty>(RegFaculty.fromJson)
        .toList();
  }

  getCourseData(index) {
    return prefs[index]['courses'].toString();
  }

  clearData() {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    DialogHelper.showDeleteAlertDialog(
        'Delete the Faculty', 'Are you Sure you want to Delete all Preferences',
        () async {
      showLoading();
      BaseClient baseClient = BaseClient();
      var response = await baseClient
          .get(
            kBaseUrl,
            'clearpreferences',
          )
          .catchError(handleError);
      hideLoading();
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'All Data Deleted Succesfully');
      if (response == null) return;
    });
  }

  /* */
}
