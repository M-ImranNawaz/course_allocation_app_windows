import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:course_allocation/main.dart';

import '../database/faculty_adapter.dart';
import '../dialog_helper.dart';
import 'file_controller.dart';

class FacultyController extends GetxController {
  List<String> tables = [];
  Map<String, List> tablesData = {};
  List facultyData = [];
  var l = facultyBox.length.obs;
  var comboBoxValue = 'Lecturer'.obs;
  //List<Map<String, List>> data = [];
  final desig = ['Lecturer', 'Assistant Professor', 'Associate Professor'];
  TextEditingController nameC = TextEditingController();
  TextEditingController departmentC = TextEditingController();
  TextEditingController designationC = TextEditingController();
  TextEditingController workloadC = TextEditingController();
  TextEditingController experienceC = TextEditingController();

  readFile() async {
    var sheet = await FileController().pickFile();
    if (sheet != 0) {
      facultyData = sheet['Teachers']!;
      print(sheet['Teachers']);
      save();
    }
  }

  save() {
    for (int i = 1; i < facultyData.length; i++) {
      var exp = facultyData[i][4];
      if (exp.runtimeType == 'String') {
        exp = double.parse(exp);
      }
      exp = exp.toDouble();
      Faculty faculty = Faculty(
        name: facultyData[i][0],
        designation: facultyData[i][1],
        maxWorkload: int.parse(facultyData[i][2].toString()),
        department: facultyData[i][3],
        experience: exp,
      );
      facultyBox.add(faculty);
      l.value = facultyBox.length;
    }
  }

  addFaculty() {
    facultyBox.add(Faculty(
        name: nameC.text,
        department: departmentC.text,
        designation: comboBoxValue.toString(),
        maxWorkload: int.parse(workloadC.text),
        experience: double.parse(experienceC.text)));
    l.value = facultyBox.length;
  }

  updateFaculty(index) {
    var value = Faculty(
        name: nameC.text,
        department: departmentC.text,
        designation: comboBoxValue.value,
        maxWorkload: int.parse(workloadC.text),
        experience: double.parse(experienceC.text));
    facultyBox.putAt(index, value);
  }

  void empty() {
    nameC.clear();
    designationC.clear();
    workloadC.clear();
    departmentC.clear();
    experienceC.clear();
  }

  void delete(int index) {
    DialogHelper.showDeleteAlertDialog(
        'Delete the Faculty', 'Are you Sure you want to Delete this', () {
      facultyBox.deleteAt(index);
      l.value = facultyBox.length;
    });
  }

  void clearData() {
    if (facultyBox.isNotEmpty) {
      DialogHelper.showDeleteAlertDialog('Clear the Faculty Data',
          'Are you Sure you want to Delete all Faculty Data', () {
        //print('object');
        facultyBox.clear();
        l.value = facultyBox.length;
      });
    }
  }

  getLength() {
    return l;
  }
}
