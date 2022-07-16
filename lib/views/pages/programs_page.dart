import 'package:course_allocation/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../database/programs_adapter.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: prosBox.listenable(),
        builder: (context, Box<Program> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          }
          return ListView.builder(
            itemBuilder: (_, int index) {
              return GestureDetector(child: Text(box.getAt(index)!.name));
            },
            itemCount: box.length,
          );
        },
      ),
    );
  }
}
