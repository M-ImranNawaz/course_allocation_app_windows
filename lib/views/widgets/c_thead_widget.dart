import 'package:fluent_ui/fluent_ui.dart';

class CTableHeadWidget extends StatelessWidget {
  const CTableHeadWidget({
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
      columnWidths: const {
        2: FixedColumnWidth(120.0),
        3: FixedColumnWidth(120.0),
        6: FixedColumnWidth(120.0)
      },
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
                'Code',
                textAlign: TextAlign.center,
              )),
          TableCell(
              child: Text(
            'Credit Hours',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Program',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Department',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'Semester',
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
