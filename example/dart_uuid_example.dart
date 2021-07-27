import 'package:dart_uuid/dart_uuid.dart';

void main() {
  var uuid = UUID();
  print(uuid.toString());
  print(uuid.bytes);
}
