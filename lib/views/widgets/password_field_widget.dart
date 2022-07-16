import 'package:fluent_ui/fluent_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key, required this.controller, required this.validator})
      : super(key: key);
  final Function validator;
  final TextEditingController controller;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormBox(
      validator: (value) {
        if (value.toString().length < 5) {
          return 'Password Length Should be 6';
        }
      },
      header: 'Password',
      prefix: const Padding(
        padding: EdgeInsets.only(
          left: 8.0,
        ),
        child: Icon(FluentIcons.lock),
      ),
      placeholder: 'Type your Password here',
      obscureText: _hidePassword,
      maxLines: 1,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      suffixMode: OverlayVisibilityMode.editing,
      suffix: IconButton(
        icon: Icon(_hidePassword == true
            ? FontAwesomeIcons.eye
            : FontAwesomeIcons.eyeSlash),
        onPressed: () => setState(() => _hidePassword = !_hidePassword),
      ),
    );
  }
}
