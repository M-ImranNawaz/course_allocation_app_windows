import 'package:course_allocation/controllers/allocation_controller.dart';
import 'package:course_allocation/controllers/courses_controller.dart';
import 'package:course_allocation/controllers/faculty_reg_controller.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/contstants.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class DialogHelper {
  static int c = 0;

  static void showLoading(String message) {
    c = 1;
    showDialog(
      context: navigatorkey.currentState!.context,
      builder: ((context) => ContentDialog(
            content: Container(
              height: 130,
              width: 170,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProgressRing(activeColor: kKfueitblue),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(message),
                ],
              ),
            ),
          )),
    );
  }

  //hide Loading
  static void hideLoading() {
    if (c == 1) {
      Navigator.of(navigatorkey.currentState!.context).pop();
      c = 0;
    }
  }

  static void showErrorDialog({
    String title = 'Error',
    String description = 'Something went wrong',
  }) {
    showDialog(
      context: navigatorkey.currentState!.context,
      builder: (context) => ContentDialog(
        content: Container(
          height: 130,
          width: 170,
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline4,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: FilledButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showCDialog(
      String title, String description, Function onPressed) {
    showDialog(
      context: navigatorkey.currentState!.context,
      builder: (context) => ContentDialog(
        content: Container(
          height: 130,
          width: 170,
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline4,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: FilledButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDeleteAlertDialog(
      String title, String description, Function onPressed) {
    showDialog(
        context: navigatorkey.currentState!.context,
        builder: (context) {
          return ContentDialog(
            content: Container(
              height: 135,
              width: 260,
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                        autofocus: true,
                        onPressed: () async {
                          onPressed();
                          Navigator.pop(context);
                        },
                        style: kDelButtonStyle,
                        child: const Text('Yes'),
                      ),
                      OutlinedButton(
                          style: kDelButtonStyle,
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showgetDialog(String title, String description, Function fromFile,
      Function fromServer) {
    showDialog(
      context: navigatorkey.currentState!.context,
      builder: (context) => ContentDialog(
        backgroundDismiss: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineLarge,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: FilledButton(
              autofocus: true,
              onPressed: () {
                Navigator.pop(context);
                fromFile();
              },
              child: const Text('From File'),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Button(
              autofocus: true,
              onPressed: () {
                Navigator.pop(context);
                fromServer();
              },
              child: const Text('From Server'),
            ),
          ),
          Button(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  static void showCourseDialog(courses, isCourse) {
    showDialog(
      context: navigatorkey.currentState!.context,
      barrierDismissible: true,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxWidth: 600),
        backgroundDismiss: true,
        title: Card(
            child: isCourse
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Added Courses on Server'),
                      Button(
                          child: const Text('Clear Courses'),
                          onPressed: () {
                            CoursesController().clearServerData();
                          }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Faculty Data'),
                      Button(
                          child: const Text('Add Faculty to Server'),
                          onPressed: () {
                            FacultyRegController().sendData(courses);
                          }),
                    ],
                  )),
        content: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            if (courses.isEmpty) {
              return const Center(child: Text('Empty'));
            }
            var course = courses.elementAt(index);
            if (isCourse) {
              return ListTile(
                leading: Text(course.id.toString()),
                title: Text(course.name),
                subtitle: Text(
                    "${course.program}, ${course.department}, ${course.semester}"),
                trailing: Text(course.code.toString()),
                contentPadding: const EdgeInsets.only(right: 12),
              );
            }
            return ListTile(
              //leading: Text(course.id.toString()),
              title: Text(course[0]),
              subtitle: Text(
                  "Email:  ${course[1]}, Password:  ${course[2].toString()}"),
              //trailing: Text(course.code.toString()),
              contentPadding: const EdgeInsets.only(right: 12),
            );
          },
        ),
      ),
    );
  }

  static void showACDialog(data) {
    showDialog(
      context: navigatorkey.currentState!.context,
      barrierDismissible: true,
      builder: (context) => ContentDialog(
        constraints: const BoxConstraints(maxWidth: 600),
        backgroundDismiss: true,
        title: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Allocated Courses Data'),
            Button(
                child: const Text('Clear Data'),
                onPressed: () {
                  AllocationController().clearData();
                }),
          ],
        )),
        content: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (data.isEmpty) {
              return const Center(child: Text('Empty'));
            }
            var course = data.elementAt(index);
            String d = course['courses'].toString();
            d = d.substring(1, d.length - 1);
            List ac = d.split(',');
            List c = [];
            for (int i = 0; i < ac.length; i++) {
              c.add(ac.elementAt(i).toString().split('_'));
            }

            return Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['faculty'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  for (int i = 0; i < c.length; i++)
                    Text(
                      "    ${c.elementAt(i).first}, "
                      "    ${c.elementAt(i).elementAt(1)}, "
                      "    ${c.elementAt(i).elementAt(2)}, "
                      "    ${c.elementAt(i).elementAt(3)}, ",
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
