import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  Directory tempDir = await getTemporaryDirectory();
  final String path = tempDir.path;

  final file = File('$path/$fileName');

  await file.writeAsBytes(bytes, flush: true);

  OpenFile.open('$path/$fileName');
  // Directory tempDir = await getTemporaryDirectory();
  // String tempPath = tempDir.path;

  // Directory appDocDir = await getApplicationDocumentsDirectory();
  // String appDocPath = appDocDir.path;
}
