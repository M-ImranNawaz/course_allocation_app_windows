import 'package:course_allocation/controllers/faculty_controller.dart';
import 'package:course_allocation/database/faculty_adapter.dart';
import 'package:course_allocation/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../views.dart';

class FacultyPage extends StatefulWidget {
  const FacultyPage({Key? key}) : super(key: key);

  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  List<Faculty> facultyList = [];
  late FacultyController controller;
  @override
  void initState() {
    super.initState();
    controller = FacultyController();
  }

  Map<String, List> data = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      header: buildPageHeader(context),
      content: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Column(children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: facultyBox.listenable(),
              builder: (context, Box<Faculty> box, _) {
                if (box.values.isEmpty) {
                  return Center(
                    child: Lottie.asset('assets/nodata.json', repeat: false),
                  );
                }
                return ListView.builder(
                  itemBuilder: (_, int index) {
                    var data = facultyBox.getAt(index)!;
                    return buildMyDataTable(index, data, context, box);
                  },
                  itemCount: box.length,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildMyDataTable(
      int index, Faculty data, BuildContext context, Box<Faculty> box) {
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
          2: FixedColumnWidth(150.0),
          4: FixedColumnWidth(150.0),
          5: FixedColumnWidth(110.0)
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
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
                    data.designation,
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  child: Text(
                data.maxWorkload.toString(),
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                data.department.toString(),
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: Text(
                data.experience.toString(),
                textAlign: TextAlign.center,
              )),
              buildTableActions(data, context, index, box),
            ],
          ),
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
              Obx(
                () => Text('Faculty: ${controller.getLength()}'),
              ),
              FilledButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return buildContentDialog(context, 'Add', 0);
                        });
                  },
                  child: const Text('Add Faculty')),
              FilledButton(
                  onPressed: () {
                    facultyBox.isEmpty
                        ? showSnackbar(
                            context, const Snackbar(content: Text('No Data')),
                            alignment: Alignment.center)
                        : controller.clearData();
                  },
                  child: const Text('Clear Data')),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
              child: const FTableHeadWidget()),
        ],
      ),
    );
  }

  TableCell buildTableActions(
      Faculty data, BuildContext context, int index, Box<Faculty> box) {
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
              controller.departmentC.text = data.department!;
              controller.designationC.text = data.designation;
              controller.comboBoxValue.value = data.designation.toString();
              controller.workloadC.text = data.maxWorkload.toString();
              controller.experienceC.text = data.experience.toString();
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
              }),
        ],
      ),
    );
  }

  ContentDialog buildContentDialog(BuildContext context, String title, index) {
    return ContentDialog(
      //constraints: BoxConstraints.tightForFinite(),
      title: Center(
        child: Text(
          '$title Course',
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
              label: 'Name',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
              },
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Choose Designation')),
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 8),
              width: 400,
              child: Obx(
                () => Combobox<String>(
                  items: controller.desig
                      .map(
                          (e) => ComboboxItem<String>(value: e, child: Text(e)))
                      .toList(),
                  value: controller.comboBoxValue.value,
                  placeholder: const Text('Selected list item'),
                  onChanged: (value) {
                    print(value);
                    if (value != null) {
                      setState(() => controller.comboBoxValue.value = value);
                    }
                    print(controller.comboBoxValue);
                  },
                  isExpanded: false,
                ),
              ),
            ),
            TextBoxWidget(
              controller: controller.workloadC,
              label: 'Maximum Workload',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
                var s = double.tryParse(value) != null;
                if (s == false) {
                  return 'Please Provide Integer Value';
                }
              },
            ),
            TextBoxWidget(
              controller: controller.departmentC,
              label: 'Department',
              validator: (value) {},
            ),
            TextBoxWidget(
              controller: controller.experienceC,
              label: 'Experience',
              validator: (value) {},
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            child: Text(title.contains('Add') ? 'Add' : 'Update'),
            onPressed: () {
              var form = _formKey.currentState!;
              if (form.validate()) {
                title.contains('Add')
                    ? controller.addFaculty()
                    : controller.updateFaculty(index);
                Navigator.of(context).pop();
              }
            }),
        OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () {
              controller.empty();
              Navigator.of(context).pop();
            })
      ],
    );
  }
}

class FTableHeadWidget extends StatelessWidget {
  const FTableHeadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      textDirection: TextDirection.ltr,
      border: TableBorder.symmetric(
        inside: const BorderSide(
          style: BorderStyle.solid,
          width: 1,
        ),
        outside: const BorderSide(width: 1),
      ),
      columnWidths: const {
        2: FixedColumnWidth(150.0),
        4: FixedColumnWidth(150.0),
        5: FixedColumnWidth(110.0)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: const [
        TableRow(children: [
          TableCell(
              child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'Name',
              textAlign: TextAlign.center,
            ),
          )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                'Designation',
                textAlign: TextAlign.center,
              )),
          TableCell(
              child: Text(
            'Workload',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Department',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Experience',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Actions',
            textAlign: TextAlign.center,
          )),
        ]),
      ],
    );
  }
}
