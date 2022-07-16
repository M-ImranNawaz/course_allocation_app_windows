import 'package:course_allocation/controllers/faculty_reg_controller.dart';
import 'package:course_allocation/dialog_helper.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../views.dart';

class RegisterFaculty extends StatefulWidget {
  const RegisterFaculty({Key? key}) : super(key: key);

  @override
  State<RegisterFaculty> createState() => _RegisterFacultyState();
}

class _RegisterFacultyState extends State<RegisterFaculty> {
  late FacultyRegController controller;
  bool isLoggedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller = FacultyRegController();
    if (loginBox.isNotEmpty) {
      isLoggedIn = true;
      controller.getData();
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
          Obx(() {
            if (controller.isLoading.value) {
              return const Expanded(
                child: Center(
                  child: ProgressBar(),
                ),
              );
            }
            if (controller.rFaculty.isEmpty) {
              return Expanded(
                  child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your Empty',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        icon: const Text('Refresh Data',
                            style: TextStyle(
                                color: kKfueitblue,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          controller.getData();
                        })
                  ],
                ),
              ));
            }
            return Expanded(
                child: Obx(
              () => ListView.builder(
                  itemBuilder: ((context, index) {
                    return buildMyDataTable(
                        index, context, controller.rFaculty);
                  }),
                  itemCount: controller.rFaculty.length),
            ));
          })
        ]),
      ),
    );
  }

  Widget buildMyDataTable(int index, BuildContext context, rfData) {
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
          0: FixedColumnWidth(100.0),
          4: FixedColumnWidth(100.0)
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              TableCell(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SelectableText(
                  rfData.elementAt(index).id.toString(),
                  textAlign: TextAlign.center,
                ),
              )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SelectableText(
                    rfData.elementAt(index).name,
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  child: SelectableText(
                rfData.elementAt(index).email,
                textAlign: TextAlign.center,
              )),
              TableCell(
                  child: SelectableText(
                rfData.elementAt(index).password.toString(),
                textAlign: TextAlign.center,
              )),
              buildTableActions(rfData.elementAt(index).id.toString())
            ],
          ),
        ],
      ),
    );
  }

  TableCell buildTableActions(String id) {
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
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ContentDialog(
                        content: Container(
                          height: 135,
                          width: 260,
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              const Center(
                                child: Text(
                                  "Delete Faculty",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Center(
                                child: Text(
                                  'Are You Want to Delete This Faculty',
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.headline6,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FilledButton(
                                    autofocus: true,
                                    onPressed: () async {
                                      controller.deleteFaculty(id);
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
              }),
        ],
      ),
    );
  }

  ContentDialog buildContentDialog(BuildContext context, String title, index) {
    return ContentDialog(
      title: Center(
        child: SelectableText(
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
                RegExp rex = RegExp(
                    r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                if (!rex.hasMatch(value)) {
                  return 'Name should only contains Alphabet Charracter';
                }
              },
            ),
            TextBoxWidget(
              controller: controller.emailC,
              label: 'Email',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
                if (!value!.toString().isEmail) {
                  return 'Please Provide Correct Email Address';
                }
              },
            ),
            TextBoxWidget(
              controller: controller.passwordC,
              label: 'Password',
              validator: (value) {
                if (value!.isEmpty) return 'Please Fill Necessary Field';
                if (value!.toString().length < 5) {
                  return 'Password Length Should be Greater than 4';
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            child: Text(title.contains('Add') ? 'Add' : 'Update'),
            onPressed: () {
              validate();
              
            }),
        OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }

  validate() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      Navigator.of(context).pop();
      await controller.regFaculty();
    }
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
                    if (loginBox.isEmpty) {
                      DialogHelper.showErrorDialog(
                          description: 'Please Authenticate Yourself First');
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (_) {
                          return buildContentDialog(context, 'Add', 0);
                        });
                  },
                  child: const Text('Add Faculty')),
              FilledButton(
                  onPressed: () async {
                    controller.clearServerData();
                  },
                  child: const Text('Clear Data')),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
              child: const RFTableHeadWidget()),
        ],
      ),
    );
  }
}
