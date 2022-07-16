import 'dart:io';
import 'dart:math';
import 'package:course_allocation/controllers/base_controller.dart';
import 'package:course_allocation/dialog_helper.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/models/s_course.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../contstants.dart';
import '../models/allocated_course.dart';
import '../services/base_client.dart';

class AllocationController extends GetxController with BaseController {
  var coursesData = courseBox.values.toList();
  var facultyData = facultyBox.values;
  //Map<Faculty, List> aCourse = {};
  //List<Map<Faculty, List>> aCourses = [];
  //RxMap<Faculty, RxList<Course>> aCourse = <Faculty, RxList<Course>>{}.obs;
  //List<Map<Faculty, List>> aCourses = [];
  List<List<dynamic>> aCourses = [];
  List courses = [];
  var serverPrefs = [];
  var filePrefs = [];
  var preferences = [];
  List<SCourse> prefCourses = [];
  List faculty = [];
  getPrefs() {
    //fromServer ? prefs.elementAt(index)['Courses'][0]['name']
    //prefs.elementAt(index)[1]
    preferences = filePrefs.isNotEmpty ? filePrefs : serverPrefs;
  }

  bool isAlreadyExist(List list, String data, String semester) {
    if (list.isEmpty) {
      return false;
    }
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).name == data) {
        return true;
      }
    }
    return false;
  }

  allocateCoursesWithPreferences() {
    getPrefs();
    if (preferences.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please give Preferences First');
      return;
    }
    coursesData = courseBox.values.toList();

    aCourses = [];
    faculty.clear();
    int cLength = coursesData.length;
    for (int i = 0; i < facultyData.length; i++) {
      for (int p = 0; p < preferences.length; p++) {
        if (facultyData.elementAt(i).name.toString() ==
            preferences.elementAt(p)['Faculty'][0]['name'].toString()) {
          prefCourses =
              serverPrefs[p]['Courses'].map<SCourse>(SCourse.fromJson).toList();
          var f = facultyData.elementAt(i);
          faculty.add(preferences.elementAt(p)['Faculty'][0]['id']);
          if (f.maxWorkload == 6.0 && cLength >= 2) {
            allocate(0, 2);
            List myd = [f];
            for (int j = 0; j < courses.length; j++) {
              myd.add(courses.elementAt(j));
            }
            aCourses.add(myd);
          }
          if (f.maxWorkload == 9.0 && cLength >= 3) {
            courses.clear();
            allocate(0, 3);
            List myac = [f];
            for (int j = 0; j < courses.length; j++) {
              myac.add(courses.elementAt(j));
            }
            aCourses.add(myac);
          }
          if (f.maxWorkload == 12.0 && cLength > 4) {
            courses.clear();
            allocate(0, 4);
            List myd = [f];
            for (int j = 0; j < courses.length; j++) {
              myd.add(courses.elementAt(j));
            }
            aCourses.add(myd);
          }
          if (f.maxWorkload == 15.0 && cLength > 5) {
            courses.clear();
            allocate(0, 5);
            List myd = [f];
            for (int j = 0; j < courses.length; j++) {
              myd.add(courses.elementAt(j));
            }
            aCourses.add(myd);
          }
        }
      }
    }
  }

  allocate(int s, int s1) {
    bool flag = true;
    courses.clear();
    for (int j = s; j < prefCourses.length; j++) {
      if (courses.length <= s1) {
        for (int k = 0; k < coursesData.length; k++) {
          if (courses.length < 2 &&
              coursesData.elementAt(k).name == prefCourses.elementAt(j).name &&
              coursesData.elementAt(k).semester ==
                  prefCourses.elementAt(j).semester &&
              coursesData.elementAt(k).program ==
                  prefCourses.elementAt(j).program &&
              coursesData.elementAt(k).department ==
                  prefCourses.elementAt(j).department) {
            courses.add(prefCourses.elementAt(j));
            coursesData.removeAt(k);
            flag = true;
          }
          if (courses.length < s1 && courses.length >= 2) {
            int n = Random().nextInt(coursesData.length);
            courses.add(coursesData.elementAt(n));
          } 
        }
      }
    }
    if (flag = false) {
      allocate(s + 1, s1);
    }
  }

  List cs = [];
  getFromServer() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    BaseClient baseClient = BaseClient();
    showLoading();
    var response = await baseClient
        .get(
          kBaseUrl,
          'getallfacultypreferences',
        )
        .catchError(handleError);
    var cresponse = await baseClient
        .get(
          kBaseUrl,
          'courses',
        )
        .catchError(handleError);
    cs = cresponse;
    print(cs[0]['name']);
    hideLoading();
    if (response == null) return [];
    serverPrefs = response;
  }

  getFacultyPrefs(index) {
    return serverPrefs.elementAt(0)['Courses'];
  }

  Future<void> export() async {
    final PdfDocument document = PdfDocument();
    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    headerTemplate.graphics.drawString('Fauclty\'s Allocated Courses',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: const Rect.fromLTWH(0, 15, 200, 20));
    document.template.top = headerTemplate;
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();

    int length = 2;
    for (int i = 0; i < aCourses.length; i++) {
      var cou = aCourses.elementAt(i);
      if (cou.length > length) {
        length = cou.length;
      }
    }
    grid.columns.add(count: length);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Faculty Name';

    for (int i = 1; i < length; i++) {
      headerRow.cells[i].value = 'Allocated Course $i';
    }
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    for (int i = 0; i < aCourses.length; i++) {
      var cou = aCourses.elementAt(i);
      PdfGridRow row = grid.rows.add();
      for (int j = 0; j < cou.length; j++) {
        row.cells[j].value =
            '${cou.elementAt(j).name.toString()}  ${j != 0 ? cou.elementAt(j).semester.toString() : ''}';
      }
    }
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File('$path/Allocated Courses.pdf').writeAsBytes(document.save());
    document.dispose();
  }

  Future<void> saveToServer() async {
    List courses = [];
    if (aCourses.isEmpty) {
      return;
    }
    for (int i = 0; i < aCourses.length; i++) {
      List c = [];
      var cou = aCourses.elementAt(i);

      for (int j = 1; j < cou.length; j++) {
        String data =
            '${cou.elementAt(j).name.toString()}_${cou.elementAt(j).code.toString()}_'
            '${cou.elementAt(j).creditHours.toString()}_${cou.elementAt(j).program.toString()} '
            '${cou.elementAt(j).department} ${cou.elementAt(j).semester.toString()}';
        print(data);
        c.add(data);
      }
      AllocatedCourse course = AllocatedCourse(
        id: 0,
        faculty: aCourses.elementAt(i).first.name,
        // "_" +
        // aCourses.elementAt(i).first.maxWorkload.toString(),
        courses: c.toString(),
      );
      courses.add(course.toMap());
    }
    showLoading();
    BaseClient baseClient = BaseClient();
    var response = await baseClient
        .post(kBaseUrl, 'addallacs', courses)
        .catchError(handleError);
    hideLoading();
    print(response.toString());
    if (response.toString().contains('true')) {
      DialogHelper.showErrorDialog(
          title: 'Success', description: 'Data saved in server');
    }
    if (response.toString() == null) DialogHelper.showErrorDialog();
    if (response.toString() == null) return;
  }

  void viewData() async {
    if (loginBox.isEmpty) {
      DialogHelper.showErrorDialog(
          description: 'Please Authenticate Yourself First');
      return;
    }
    showLoading();
    BaseClient baseClient = BaseClient();
    var response = await baseClient
        .get(kBaseUrl, 'allocatedcourses')
        .catchError(handleError);
    hideLoading();
    // List<AllocatedCourse> data =
    //     response.map<AllocatedCourse>(AllocatedCourse.fromJson).toList();
    DialogHelper.showACDialog(response);
  }

  Future<void> clearData() async {
    showLoading();
    BaseClient baseClient = BaseClient();
    var response =
        await baseClient.get(kBaseUrl, 'clearacs').catchError(handleError);
    hideLoading();
    Navigator.pop(navigatorkey.currentState!.context);
    if (response.toString().contains('Deleted')) {
      DialogHelper.showErrorDialog(
          title: 'Success', description: response.toString());
    }
  }
}
