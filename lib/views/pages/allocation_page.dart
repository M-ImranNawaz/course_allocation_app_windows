import 'package:course_allocation/contstants.dart';
import 'package:course_allocation/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';

import '../../controllers/allocation_controller.dart';

class AllocateCoursesPage extends StatefulWidget {
  const AllocateCoursesPage({Key? key}) : super(key: key);

  @override
  State<AllocateCoursesPage> createState() => _AllocateCoursesPageState();
}

class _AllocateCoursesPageState extends State<AllocateCoursesPage> {
  final controller = AllocationController();

  List prefs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      header: buildPageHeader(context),
      content: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.1,
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 210,
                  height: double.infinity,
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: facultyBox.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? const Color.fromARGB(255, 230, 230, 230)
                                : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Text(
                            "${index + 1} ${facultyBox.getAt(index)!.name}  "
                            "${facultyBox.getAt(index)!.maxWorkload}"),
                      );
                    }),
                  ),
                ),
                SizedBox(
                    height: double.infinity,
                    width: 680,
                    child: prefs.isNotEmpty
                        ? ListView.builder(
                            controller: ScrollController(),
                            itemCount: prefs.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? const Color.fromARGB(
                                            255, 230, 230, 230)
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: ScrollController(),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${prefs.elementAt(index)['Courses'][0]['name']}"),
                                      buildTextDivider(),
                                      Text(
                                          "${prefs.elementAt(index)['Courses'][1]['name']}"),
                                      buildTextDivider(),
                                      Text(
                                          "${prefs.elementAt(index)['Courses'][2]['name']}"),
                                      buildTextDivider(),
                                      Text(
                                          "${prefs.elementAt(index)['Courses'][3]['name']}"),
                                    ],
                                  ),
                                ),
                              );
                            }))
                        : const SizedBox()),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                    child: controller.cs.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.cs.length,
                            controller: ScrollController(),
                            itemBuilder: ((context, index) {
                              return Text(
                                  controller.cs.elementAt(index)['name']);
                            }),
                          )
                        : const SizedBox())
              ],
            ),
          ),
          const Divider(
            size: double.infinity,
            direction: Axis.horizontal,
            style: DividerThemeData(
                thickness: 1,
                decoration: BoxDecoration(color: kKfueitGreen),
                horizontalMargin: EdgeInsets.all(2)),
          ),
          //ShowAllocated Courses
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: controller.aCourses.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return buildACourseCard(controller.aCourses.elementAt(index));
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: const Divider(
        direction: Axis.vertical,
        size: 10,
        style: DividerThemeData(
          thickness: 2,
          verticalMargin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: kKfueitGreen,
          ),
        ),
      ),
    );
  }

  Widget buildACourseCard(List list) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 167, 166, 165),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 2),
              child: Text(
                ('${list.first.name}:'),
                style: const TextStyle(fontSize: 15),
              ),
            ),
            for (int i = 1; i < list.length; i++)
              SingleChildScrollView(
                controller: ScrollController(),
                child: Container(
                    margin: const EdgeInsets.only(left: 25, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${list.elementAt(i).name}, ${list.elementAt(i).semester}'),
                        // Text(
                        //   list.elementAt(i).code,
                        //   style: const TextStyle(fontSize: 11),
                        // ),
                      ],
                    )),
              ),
          ]),
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
              FilledButton(
                  onPressed: () {
                    controller.allocateCoursesWithPreferences();
                    setState(() {});
                  },
                  child: const Text('Allocate Courses')),
              FilledButton(
                  onPressed: () async {
                    await controller.getFromServer();
                    prefs = controller.serverPrefs;
                    setState(() {});
                  },
                  child: const Text('Get Preferences')),
              FilledButton(
                  onPressed: controller.aCourses.isNotEmpty
                      ? () {
                          controller.export();
                        }
                      : null,
                  child: const Text('Export File')),
              FilledButton(
                  onPressed: controller.aCourses.isNotEmpty
                      ? () {
                          controller.saveToServer();
                        }
                      : null,
                  child: const Text('Upload Data')),
              FilledButton(
                  onPressed: () {
                    controller.viewData();
                  },
                  child: const Text('View Data')),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 3),
            //child: const ATableHeadWidget()
          ),
        ],
      ),
    );
  }
}
