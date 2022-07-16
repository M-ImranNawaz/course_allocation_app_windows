import 'package:fluent_ui/fluent_ui.dart';

import 'main.dart';

const kKfueitGreen = Color(0xFF22B24C);
const kKfueitblue = Color(0xFF153980);
const url = '127.0.0.1';
const kBaseUrl = 'http://$url/course_allocation/api/';
const kLoginText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: kKfueitblue,
);
navTo(page) {
  Navigator.push(navigatorkey.currentState!.context,
      FluentPageRoute(builder: (context) => page));
}

var kDelButtonStyle = ButtonStyle(
    padding: ButtonState.all(
        const EdgeInsets.symmetric(horizontal: 30, vertical: 6)));

final kButtonStyle = ButtonStyle(
    padding: ButtonState.all(const EdgeInsets.symmetric(vertical: 8, horizontal: 30))
/*       backgroundColor: ButtonState.resolveWith((states) {
  if (states.isHovering) {
    return Color.fromARGB(255, 34, 178, 77);
  }
  if (states.isPressing) {
    return Colors.green.withOpacity(50);
  }
  return Color(0xFF22B24C);

}) */
    );
const kLoginTextButton = TextStyle(color: kKfueitblue);

// const kSendButtonTextStyle = TextStyle(
//   color: Colors.lightBlueAccent,
//   fontWeight: FontWeight.bold,
//   fontSize: 18.0,
// );

// const kMessageTextFieldDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   hintText: 'Type your message here...',
//   border: InputBorder.none,
// );

// const kMessageContainerDecoration = BoxDecoration(
//   border: Border(
//     top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//   ),
// );
// const kTextFieldDecoration = InputDecoration(
//   hintText: 'Enter your value',
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );
