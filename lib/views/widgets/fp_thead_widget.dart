import 'package:fluent_ui/fluent_ui.dart';

class FPTableHeadWidget extends StatelessWidget {
  const FPTableHeadWidget({
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
                '1st Preference',
                textAlign: TextAlign.center,
              )),
          TableCell(
              child: Text(
            '2nd Preference',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            '3rd Preference',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            '4th Preference',
            textAlign: TextAlign.center,
          )),
        ]),
      ],
    );
  }
}
