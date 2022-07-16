import 'package:course_allocation/controllers/signup_controller.dart';
import 'package:course_allocation/models/hod.dart';
import 'package:course_allocation/contstants.dart';
import 'package:course_allocation/views/pages/signin_page.dart';
import 'package:course_allocation/views/widgets/password_field_widget.dart';
import 'package:course_allocation/views/widgets/text_box_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final bool _hidePassword = true;
  late TextEditingController nameC, emailC, passw1C, passw2C, departmentC;
  late SignUpPageController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameC = TextEditingController();
    departmentC = TextEditingController();
    emailC = TextEditingController();
    passw1C = TextEditingController();
    passw2C = TextEditingController();
    controller = SignUpPageController();
  }

  @override
  void dispose() {
    super.dispose();
    nameC.dispose();
    emailC.dispose();
    passw1C.dispose();
    passw2C.dispose();
    departmentC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(236, 255, 255, 245),
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 500,
              child: Stack(
                children: [
                  const Positioned(
                    bottom: 275,
                    right: 1,
                    left: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 33),
                    child: Card(
                      backgroundColor: Colors.white,
                      child: Container(
                        height: 460,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            clipBehavior: Clip.none,
                            shrinkWrap: true,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Sign Up',
                                style: kLoginText,
                                textAlign: TextAlign.center,
                              ),
                              TextBoxWidget(
                                  controller: nameC,
                                  icon: FontAwesomeIcons.user,
                                  label: 'Name',
                                  validator: (String value) {
                                    if (value.toString().isEmpty) {
                                      return 'Please Fill Required Field';
                                    }
                                    //if(value.isNumericOnly && value.is)
                                    RegExp rex = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                                    if (!rex.hasMatch(value) ) {
                                      return 'Name should only contains Alphabet Charracter';
                                    }
                                  }),
                              TextBoxWidget(
                                  controller: departmentC,
                                  icon: FluentIcons.home,
                                  label: 'Department',
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'Please Fill Required Field';
                                    }
                                    if(!value.contains(RegExp(r'[A-z]')) ) {
                                return 'Department should only contains Alphabet Charracter';
                            }
                                  }),
                              TextBoxWidget(
                                  controller: emailC,
                                  icon: FluentIcons.edit_mail,
                                  label: 'Email',
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'Please Fill Required Field';
                                    }
                                    if (!GetUtils.isEmail(value.toString())) {
                                      return 'Please Provide Correct Email Address';
                                    }
                                  }),
                              PasswordField(
                                  controller: passw1C, validator: () {}),
                              const SizedBox(
                                height: 12,
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: FilledButton(
                                  onPressed: () async {
                                    validate();
                                  },
                                  style: kButtonStyle,
                                  child: const Text('Sign Up'),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              buildLastOption(context)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 435,
                    right: 1,
                    left: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(FontAwesomeIcons.user,
                          size: 70, color: kKfueitGreen),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Row buildLastOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Already have an Account? '),
        GestureDetector(
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'Sign In',
                style: kLoginTextButton,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return const ContentDialog(
                      constraints: BoxConstraints.tightForFinite(
                          height: 600, width: 500),
                      content: SignInPage(),
                    );
                  });
            })
      ],
    );
  }

  validate() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      HOD hod = HOD(
        id: '',
        name: nameC.text,
        department: departmentC.text,
        email: emailC.text,
        password: passw1C.text,
      );
      await controller.registerHOD(hod);
    }
  }
}
