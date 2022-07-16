import 'package:course_allocation/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart' as m;
import '../views.dart';
import 'package:course_allocation/views/pages/faculty_reg_page.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bodyPages = [
    const HomePage(),
    const FacultyPage(),
    const CoursesPage(),
    const RegisterFaculty(),
    const FacultyPreferences(),
    const AllocateCoursesPage()
  ];
  int currentPage = 0;
  String? name;
  bool isSignedIn = false;
  @override
  void initState() {
    super.initState();
    name = 'Guest';
    isSignedIn = false;
    if (loginBox.isOpen && loginBox.isNotEmpty) {
      name = loginBox.values.first.name;
      isSignedIn = loginBox.values.first.isLoggedIn!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: NavigationBody(
        index: currentPage,
        transitionBuilder: (child, animation) {
          return DrillInPageTransition(animation: animation, child: child);
        },
        children: bodyPages,
      ),
      pane: NavigationPane(
          header: buildHeader(context),
          selected: currentPage,
          onChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          size: const NavigationPaneSize(
            openMaxWidth: 200,
          ),
          displayMode: PaneDisplayMode.auto,
          items: [
            PaneItem(
              title: const Text('Home'),
              icon: const Icon(FontAwesomeIcons.house, color: kKfueitblue),
            ),
            PaneItem(
              title: const Text('Faculty'),
              icon: const Icon(m.Icons.person_sharp, color: kKfueitblue),
            ),
            PaneItem(
              title: const Text('Courses'),
              icon: const Icon(FontAwesomeIcons.bookOpen, color: kKfueitblue),
            ),
            PaneItem(
              title: const Text('Register Faculty'),
              icon: const Icon(
                m.Icons.person_add_alt_1,
                color: kKfueitblue,
              ),
            ),
            PaneItem(
              title: const Text('Faculty Preferences'),
              icon: const Icon(FontAwesomeIcons.chalkboardUser,
                  color: kKfueitblue),
            ),
            PaneItem(
              title: const Text('Allocate Courses'),
              icon: const Icon(FontAwesomeIcons.bookOpenReader,
                  color: kKfueitblue),
            ),
          ]),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: IconButton(
        style: ButtonStyle(
            padding: ButtonState.all(
                const EdgeInsets.symmetric(vertical: 4, horizontal: 0))),
        onPressed: () {
          loginBox.isNotEmpty
              ? showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return ContentDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Name:'),
                              Text(loginBox.values.first.name ?? 'Empty'),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Email:'),
                              Text(loginBox.values.first.email ?? 'Empty'),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Department:'),
                              Text(loginBox.values.first.department ?? 'Empty')
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        FilledButton(
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Logout '),
                                  Icon(m.Icons.logout)
                                ]),
                            onPressed: () async {
                              Navigator.pop(context);
                              await loginBox.clear();

                              // Navigator.pushReplacement(
                              //     context,
                              //     FluentPageRoute(
                              //         builder: (context) => const Home()));
                              setState(() {
                                name = 'Guest';
                                isSignedIn = false;
                              });
                            })
                      ],
                    );
                  })
              : showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) {
                    return const ContentDialog(
                        constraints: BoxConstraints.tightForFinite(
                            height: 600, width: 500),
                        content: SignInPage());
                  });
        },
        icon: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: const ShapeDecoration(
                  shape: CircleBorder(), //here we set the circular figure
                  color: kKfueitGreen),
              padding: const EdgeInsets.only(bottom: 5),
              child: loginBox.isNotEmpty == true
                  ? Text(name!.toUpperCase().substring(0, 1),
                      style: const TextStyle(color: Colors.white, fontSize: 22))
                  : const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text('${loginBox.isNotEmpty == true ? name : 'Guest'}')
          ],
        ),
      ),
    );
  }
}
