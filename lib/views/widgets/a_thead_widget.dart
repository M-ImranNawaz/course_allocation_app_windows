import 'package:fluent_ui/fluent_ui.dart';

class ATableHeadWidget extends StatelessWidget {
  const ATableHeadWidget({
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
                'S 1',
                textAlign: TextAlign.center,
              )),
          TableCell(
              child: Text(
            'S 2',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'S 3',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'S 4',
            textAlign: TextAlign.center,
          )),
          TableCell(
              child: Text(
            'S 5',
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
