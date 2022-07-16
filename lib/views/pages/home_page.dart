import 'package:course_allocation/controllers/home_controller.dart';
import 'package:course_allocation/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';

import '../views.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController controller;
  @override
  void initState() {
    controller = HomePageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: facultyBox.isEmpty
          ? Column(
              children: [
                Image.asset('assets/icon.png', width: 150),
                const SizedBox(
                  height: 10,
                ),
                Lottie.asset('assets/nodata.json', repeat: false, width: 500),
                const SizedBox(
                  height: 13,
                ),
                loginBox.isEmpty
                    ? buildRegisterData(context)
                    : const SizedBox.shrink(),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icon.png', width: 170),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 100,
                      ),
                      Text('Faculty Data'),
                      SizedBox(
                        width: 400,
                      ),
                      Text('Courses Data'),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  margin: const EdgeInsets.only(left: 120, right: 100),
                  child: Row(
                    children: [
                      Container(
                        width: 370,
                        height: double.infinity,
                        padding: const EdgeInsets.only(right: 10),
                        child: Card(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: ScrollController(),
                            itemCount: facultyBox.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? const Color.fromARGB(
                                            255, 230, 230, 230)
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Row(
                                  children: [
                                    Text(
                                      "${index + 1} ${facultyBox.getAt(index)!.name}     ",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                        "${facultyBox.getAt(index)!.designation}    "),
                                    Text(
                                      "${facultyBox.getAt(index)!.maxWorkload}    ",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 114, 113, 112)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      Flexible(
                          child: courseBox.isNotEmpty
                              ? Card(
                                  child: ListView.builder(
                                      itemCount: courseBox.length,
                                      itemBuilder: ((context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? const Color.fromARGB(
                                                      255, 230, 230, 230)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "${courseBox.values.elementAt(index).name}  "),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                "${courseBox.values.elementAt(index).code}  ",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 48, 47, 47)),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "${courseBox.values.elementAt(index).semester}  ",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 114, 113, 112)),
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                                )
                              : const SizedBox()),
                    ],
                  ),
                ),
                loginBox.isEmpty
                    ? buildRegisterData(context)
                    : const SizedBox.shrink(),
              ],
            ),
    );
  }

  Column buildRegisterData(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Its Good to See You',
          style: TextStyle(
              color: kKfueitblue, fontSize: 40, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('Want to Secure Your Data',
            style: TextStyle(
                color: kKfueitGreen,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                child: const Text('LOGIN'),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) {
                        return const ContentDialog(
                            constraints: BoxConstraints.tightForFinite(
                                height: 600, width: 500),
                            content: SignInPage());
                      });
                }),
            const SizedBox(
              width: 8,
            ),
            const Text('OR'),
            const SizedBox(
              width: 8,
            ),
            Button(
                child: const Text('REGISTER'),
                onPressed: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) {
                        return const ContentDialog(
                          constraints: BoxConstraints.tightForFinite(
                              height: 600, width: 500),
                          content: SignUpPage(),
                        );
                      });
                }),
          ],
        )
      ],
    );
  }
}
