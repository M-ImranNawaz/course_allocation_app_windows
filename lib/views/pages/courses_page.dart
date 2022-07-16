import 'package:course_allocation/controllers/courses_controller.dart';
import 'package:course_allocation/main.dart';
import 'package:course_allocation/views/views.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../database/courses_adapter.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  final controller = CoursesController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      header: buildPageHeader(context),
      content: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: courseBox.listenable(),
                builder: (context, Box<Course> box, _) {
                  if (box.values.isEmpty) {
                    return Center(
                        child:
                            Lottie.asset('assets/nodata.json', repeat: false));
                  }
                  return ListView.builder(
                    itemBuilder: (_, int index) {
                      var data = courseBox.getAt(index)!;
                      return buildMyDataTable(index, data, context, box);
                    },
                    itemCount: box.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageHeader(BuildContext context) {
    return Card(
      padding: const EdgeInsets.only(top: 6, bottom: 0.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => Text('Courses: ${controller.getLength()}'),
              ),
              FilledButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return buildContentDialog(context, 'Add', 0);
                        });
                  },
                  child: const Text('Add Course')),
              FilledButton(
                  onPressed: () {
                    controller.clearData();
                  },
                  child: const Text('Clear Data')),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Divider(
                      direction: Axis.vertical,
                      size: 20,
                      style: DividerThemeData(
                        thickness: 2,
                        verticalMargin: EdgeInsets.zero,
                        horizontalMargin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: kKfueitGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text('Server Side'),
                ],
              ),
              Button(
                  child: const Text('View Data'),
                  onPressed: () {
                    controller.viewCourses();
                  }),
              Button(
                  onPressed: () {
                    controller.sendToServer();
                  },
                  child: Row(
                    children: const [
                      Text('Send Data'),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        FluentIcons.upload,
                        color: kKfueitGreen,
                      ),
                    ],
                  )),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
              child: const CTableHeadWidget()),
        ],
      ),
    );
  }

  Widget buildMyDataTable(
      int index, Course data, BuildContext context, Box<Course> box) {
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
          columnWidths: const {
            2: FixedColumnWidth(120.0),
            3: FixedColumnWidth(120.0),
            6: FixedColumnWidth(120.0)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  data.name,
                  textAlign: TextAlign.center,
                ),
              )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    data.code,
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  child: Text(
                data.creditHours.toString(),
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                '${data.program}',
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                '${data.department}',
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                '${data.semester}',
                textAlign: TextAlign.center,
              )),
              buildTableActions(data, context, index, box),
            ]),
          ],
        ));
  }

  TableCell buildTableActions(
      Course data, BuildContext context, int index, Box<Course> box) {
    return TableCell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 2,
          ),
          IconButton(
            icon: Icon(
              FluentIcons.edit,
              color: Colors.green,
            ),
            onPressed: () {
              controller.nameC.text = data.name;
              controller.codeC.text = data.code;
              controller.creditHoursC.text = data.creditHours.toString();
              controller.programC.text = data.program ?? "Empty";
              controller.departmentC.text = data.department ?? "Empty";
              controller.semesterC.text = data.semester ?? "Empty";
              showDialog(
                  context: context,
                  builder: (_) {
                    return buildContentDialog(context, 'Edit', index);
                  });
            },
          ),
          const SizedBox(
            width: 2,
          ),
          IconButton(
              icon: Icon(
                FluentIcons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                controller.delete(index);

                //box.deleteAt(index);
              }),
        ],
      ),
    );
  }

  ContentDialog buildContentDialog(BuildContext context, String title, index) {
    return ContentDialog(
      style: ContentDialogThemeData.standard(
          ThemeData(scaffoldBackgroundColor: Colors.white)),
      title: Center(
        child: Text(
          '$title Courses',
          textAlign: TextAlign.center,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: (() {
                controller.readFile();
                Navigator.pop(context);
              }),
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Import from a file',
                    style: TextStyle(color: kKfueitblue),
                  ),
                  Icon(
                    FluentIcons.upload,
                    color: kKfueitGreen,
                  )
                ],
              ),
            ),
            TextBoxWidget(
              controller: controller.nameC,
              label: 'Course Name',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
              },
            ),
            TextBoxWidget(
              controller: controller.codeC,
              label: 'Course Code',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
              },
            ),
            TextBoxWidget(
              controller: controller.creditHoursC,
              label: 'Course Credit Hours',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
                var s = double.tryParse(value) != null;
                if (s == false) {
                  return 'Please Provide Integer Value';
                }
              },
              //textInputType: TextInputType.number,
              //textInputType: TextInputType.number,
            ),
            TextBoxWidget(
              controller: controller.programC,
              label: 'Course Program',
              validator: (value) {},
            ),
            TextBoxWidget(
              controller: controller.departmentC,
              label: 'Course Department',
              validator: (value) {},
            ),
            TextBoxWidget(
              controller: controller.semesterC,
              label: 'Course Semester',
              validator: (value) {},
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            child: Text(title.contains('Add') ? 'Add' : 'Update'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                title.contains('Add')
                    ? controller.addCourse()
                    : controller.updateCourse(index);
                Navigator.pop(context);
              }
              // title.contains('Add')
              //     ? controller.addCourse()
              //     : controller.updateCourse(index);
            }),
        OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
              controller.empty();
            })
      ],
    );
  }
}
