import 'package:course_allocation/controllers/faculty_pref_controller.dart';
import 'package:course_allocation/models/reg_faculty.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../main.dart';
import '../views.dart';

class FacultyPreferences extends StatefulWidget {
  const FacultyPreferences({Key? key}) : super(key: key);

  @override
  State<FacultyPreferences> createState() => _FacultyPreferencesState();
}

class _FacultyPreferencesState extends State<FacultyPreferences> {
  bool isLoggedIn = true;
  late FacultyPrefController controller;
  @override
  void initState() {
    controller = FacultyPrefController();
    if (loginBox.isEmpty) {
      isLoggedIn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      header: buildPageHeader(context),
      content: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Column(children: [
          Expanded(
              child: isLoggedIn
                  ? FutureBuilder(
                      future: controller.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: ProgressBar(),
                          );
                        }
                        return ListView.builder(
                          controller: ScrollController(),
                          itemBuilder: (context, index) {
                            return buildMyDataTable(
                                index, context, controller.prefs);
                          },
                          itemCount: controller.prefs.length,
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                          'Please Authenticate Your Self To Avail this Service'),
                    ))
          // : Obx(
          //     () => ListView.builder(
          //       itemBuilder: (context, int index) {
          //         return buildMyDataTable(
          //             index, context, controller.prefs);
          //       },
          //       itemCount: controller.prefs.length,
          //     ),
          //   )),
        ]),
      ),
    );
  }

  Widget buildMyDataTable(int index, BuildContext context, prefs) {
    var course = prefs.elementAt(index)['Courses'];
    RegFaculty faculty = controller.getFacultyData(index).elementAt(0);
    return OnHover(
      index: index,
      child: Table(
        textDirection: TextDirection.ltr,
        border: TableBorder.symmetric(
          inside: const BorderSide(
            style: BorderStyle.solid,
            width: 1,
          ),
          outside: const BorderSide(width: 1),
        ),
        // columnWidths: const {5: FixedColumnWidth(100.0)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Tooltip(
                  message:
                      '${faculty.id.toString()}, ${faculty.name}, ${faculty.email}',
                  child: Text(
                    faculty.name.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    isLoggedIn
                        ? '${course[0]['name']}, ${course[0]['code']}'
                        : prefs[index][0],
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  child: Text(
                isLoggedIn
                    ? '${course[1]['name']}, ${course[1]['code']}'
                    : prefs[index][1],
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                isLoggedIn
                    ? '${course[2]['name']}, ${course[2]['code']}'
                    : prefs[index][2].toString(),
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                isLoggedIn
                    ? '${course[3]['name']}, ${course[3]['code']}'
                    : prefs[index][2].toString(),
                textAlign: TextAlign.center,
              )),
              //buildTableActions()
            ],
          ),
        ],
      ),
    );
  }

  TableCell buildTableActions() {
    return TableCell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 2,
          ),
          const SizedBox(
            width: 2,
          ),
          IconButton(
              icon: Icon(
                FluentIcons.delete,
                color: Colors.red,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget buildPageHeader(BuildContext context) {
    return Card(
      padding: const EdgeInsets.only(
        /* left: 8, */ top: 6,
        bottom: 0.5, /* right: 8 */
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                  onPressed: () {
                    controller.clearData();
                  },
                  child: const Text('Clear Data')),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
              child: const FPTableHeadWidget()),
        ],
      ),
    );
  }
}