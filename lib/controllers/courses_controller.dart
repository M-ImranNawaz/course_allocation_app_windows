import 'package:course_allocation/controllers/base_controller.dart';
import 'package:course_allocation/controllers/file_controller.dart';
import 'package:course_allocation/database/courses_adapter.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/models/s_course.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:course_allocation/dialog_helper.dart';

import '../contstants.dart';
import '../services/base_client.dart';

class CoursesController extends GetxController with BaseController {
  Map<String, List> tablesData = {};
  List courseData = [];
  var l = courseBox.length.obs;
  TextEditingController programC = TextEditingController();
  TextEditingController departmentC = TextEditingController();
  TextEditingController contactHoursC = TextEditingController();
  TextEditingController creditHoursC = TextEditingController();
  TextEditingController codeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController semesterC = TextEditingController();

  addCourse() {
    courseBox.add(
      Course(
          name: nameC.text,
          code: codeC.text,
          creditHours: int.parse(creditHoursC.text),
          department: departmentC.text,
          program: programC.text,
          semester: semesterC.text),
    );
    l.value = courseBox.length;
  }

  updateCourse(index) {
    courseBox.putAt(
        index,
        Course(
            name: nameC.text,
            code: codeC.text,
            creditHours: int.parse(creditHoursC.text),
            department: departmentC.text,
            program: programC.text,
            semester: semesterC.text));
  }

  readFile() async {
    /* Map<String, List>  */ var data = await FileController().pickFile();
    if (data != 0) {
      print(data['Courses']?[0]);
      courseData = data['Courses']!;
      print(courseData);
      save();
    }
  }

  save() {
    for (int i = 1; i < courseData.length; i++) {
      Course course = Course(
        name: courseData[i][0] ?? "",
        code: courseData[i][1] ?? "",
        creditHours: int.parse(courseData[i][2].toString()),
        program: courseData[i][3] ?? "",
        department: courseData[i][4] ?? "",
        semester: courseData[i][5].toString(),
      );
      courseBox.add(course);
      l.value = courseBox.length;
    }
  }

  void empty() {
    nameC.clear();
    codeC.clear();
    programC.clear();
    departmentC.clear();
    creditHoursC.clear();
    contactHoursC.clear();
  }

  void delete(int index) {
    DialogHelper.showDeleteAlertDialog(
        'Delete the Course', 'Are you Sure you want to delete this course', () {
      courseBox.deleteAt(index);
      l.value = courseBox.length;
    } /* courseBox, index */);
  }

  void clearData() {
    DialogHelper.showDeleteAlertDialog('Clear the Course Data',
        'Are you Sure you want to delete all courses Data', () {
      courseBox.clear();
      l.value = courseBox.length;
    });
  }

  getLength() {
    return l;
  }

  sendToServer() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    List courses = [];
    for (int i = 0; i < courseBox.values.length; i++) {
      var val = courseBox.getAt(i)!;
      SCourse course = SCourse(
          id: 0,
          name: val.name,
          code: val.code,
          department: val.department!,
          program: val.program!,
          creditHours: val.creditHours.toString(),
          semester: val.semester ?? "");
      courses.add(course.toMap());
    }

    BaseClient baseClient = BaseClient();
    print(courses);
    showLoading();
    var response = await baseClient
        .post(kBaseUrl, 'addallcourses', courses)
        .catchError(handleError);
    hideLoading();
    print(response.toString());
    if (response.toString().contains('true')) {
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'Data saved in server');
    }
    if (response.toString() == null) DialogHelper.showErrorDialog();
    if (response.toString() == null) return;
    DialogHelper.showErrorDialog(
        title: 'Success', description: 'Data saved in server');
    if (response.toString().contains('true')) {}
  }

  void clearServerData() {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    DialogHelper.showDeleteAlertDialog('Delete the Courses',
        'Are you Sure you want to Delete all Courses From Server', () async {
      BaseClient baseClient = BaseClient();
      showLoading();
      var response = await baseClient
          .get(
            kBaseUrl,
            'clearcourses',
          )
          .catchError(handleError);
      hideLoading();
      Navigator.pop(navigatorkey.currentState!.context);
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'All Data Deleted Succesfully');
      
      if (response == null) return;
    });
  }
  Future<void> viewCourses() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    showLoading();
    BaseClient baseClient = BaseClient();
    var response = await baseClient.get(kBaseUrl, 'courses').catchError(handleError);
    var course = response.map<SCourse>(SCourse.fromJson).toList();
    print(course);
    hideLoading();
    DialogHelper.showCourseDialog(course,true);
  }
}
