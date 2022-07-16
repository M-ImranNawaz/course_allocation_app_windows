import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class FileController {
  List<String> sheets = [];
  Map<String, List> tablesData = {};
  List<Map<String, List>> data = [];

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Add Data ',
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls']);
    if (result != null) {
      PlatformFile file = result.files.first;
      readFile(File(file.path!));
    } else {
      print('fail');
      return 0;
    }
    return tablesData;
  }

  readFile(File file) {
    var bytes = file.readAsBytesSync();
    var decoder = SpreadsheetDecoder.decodeBytes(bytes);
    sheets.addAll(decoder.tables.keys);
    for (var sheet in sheets) {
      tablesData[sheet] = decoder.tables[sheet]!.rows;
    }
  }
}
