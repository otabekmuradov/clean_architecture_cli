import 'dart:convert';
import 'dart:io';

void createDirectoryAndFile(String path) {
  var dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    print('Created directory: $path');
  } else {
    print('Directory already exists: $path');
  }
}

void createFile(String path, {required String content}) {
  var file = File(path);
  if (!file.existsSync()) {
    file.writeAsStringSync(content);
    print('Created file: $path');
  } else {
    print('File already exists: $path');
  }
}

Future<String> readContentFromFile(String filePath) async {
  var file = File(filePath);
  var content = StringBuffer();

  await for (var chunk in file.openRead().transform(utf8.decoder)) {
    content.write(chunk);
  }

  return content.toString();
}
