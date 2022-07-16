import 'package:fluent_ui/fluent_ui.dart';

class RFTableHeadWidget extends StatelessWidget {
  const RFTableHeadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(100.0),
        4: FixedColumnWidth(100.0)
      },
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
              'id',
              textAlign: TextAlign.center,
            ),
          )),
          TableCell(
              child: Text(
            'Name',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Email',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Password',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Actions',
            textAlign: TextAlign.center,
          )),
        ]),
      ],
    );
  }
}
