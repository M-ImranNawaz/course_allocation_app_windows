import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'database/faculty_reg_adapter.dart';
import 'database/courses_adapter.dart';
import 'database/faculty_adapter.dart';
import 'database/login_cred_adapter.dart';
import 'database/programs_adapter.dart';
import 'views/views.dart';

final navigatorkey = GlobalKey<NavigatorState>();
late Box<Faculty> facultyBox;
late Box<FacultyReg> facultyRegBox;
late Box<Program> prosBox;
late Box<Course> courseBox;
late Box<LoginCred> loginBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDb();
  runApp(const MyApp());
}

initDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FacultyAdapter());
  Hive.registerAdapter(ProgramAdapter());
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(FacultyRegAdapter());
  Hive.registerAdapter(LoginCredAdapter());
  facultyBox = await Hive.openBox<Faculty>('Faculty');
  prosBox = await Hive.openBox<Program>('Programs');
  courseBox = await Hive.openBox<Course>('Courses');
  facultyRegBox = await Hive.openBox<FacultyReg>('FacultyReg');
  loginBox = await Hive.openBox<LoginCred>('loginCred');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final int myColor = 0xFF22B24C;
  static final AccentColor my = AccentColor('normal', const <String, Color>{
    'darkest': Color.fromARGB(255, 1, 138, 42),
    'darker': Color.fromARGB(255, 4, 168, 54),
    'dark': Color.fromARGB(255, 11, 150, 52),
    'normal': Color(0xFF22B24C),
    'light': Color.fromARGB(255, 57, 206, 102),
    'lighter': Color.fromARGB(255, 69, 194, 106),
    'lightest': Color.fromARGB(255, 63, 177, 97),
  });
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'KFUEIT Smart Course Allocation App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      theme: ThemeData(
        focusTheme:
            FocusThemeData(primaryBorder: BorderSide(color: Colors.green)),
        accentColor: my,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
    );
  }
}
