import 'package:course_allocation/contstants.dart';
import 'package:course_allocation/views/pages/signup_page.dart';
import 'package:course_allocation/views/widgets/password_field_widget.dart';
import 'package:course_allocation/views/widgets/text_box_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/signin_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController emailC, passwordC;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SignInPageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    controller = SignInPageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(236, 255, 255, 245),
      child: Container(
        height: 750,
        alignment: Alignment.center,
        child: Column(children: [
          Image.asset(
            'assets/icon.png',
            width: 100,
          ),
          // const Text(
          //   'KFUEIT Smart Course Allocation App',
          //   style: kLoginText,
          // ),
          const SizedBox(
            height: 8,
          ),
          //const Text('Welcome', style: kLoginText),
          SizedBox(
            width: 500,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Card(
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 320,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: kLoginText,
                            ),
                            TextBoxWidget(
                                controller: emailC,
                                icon: FluentIcons.edit_mail,
                                label: 'Email',
                                validator: (value) {
                                  if (!GetUtils.isEmail(value.toString())) {
                                    return 'Please Provide Correct Email Address';
                                  }
                                  if (value.toString().length < 6) {
                                    return 'Length is Too Short';
                                  }
                                }),
                            const SizedBox(height: 10),
                            PasswordField(
                                controller: passwordC, validator: () {}),
                            const SizedBox(
                              height: 12,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: FilledButton(
                                onPressed: () {
                                  validate();
                                },
                                style: kButtonStyle,
                                child: const Text('Sign In'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an Account? '),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (_) {
                                            return const ContentDialog(
                                              constraints:
                                                  BoxConstraints.tightForFinite(
                                                      height: 600, width: 500),
                                              content: SignUpPage(),
                                            );
                                          });
                                    },
                                    child: const MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        'Register Here',
                                        style: kLoginTextButton,
                                      ),
                                    ) /* () {
                                      widget.onRegister
                                      navTo(const SignUpPage());
                                    } */
                                    )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 295,
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
    );
  }

  navTo(page) {
    Navigator.push(context, FluentPageRoute(builder: (context) => page));
  }

  validate() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      await controller.loginHOD(emailC.text, passwordC.text);
    }
  }
}
