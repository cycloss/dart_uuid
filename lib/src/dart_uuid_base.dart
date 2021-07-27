import 'dart:math';

class UUID {
  final Random _rand = Random();
  static const List<int> _lengths = [4, 2, 2, 2, 6];
  final List<int> _bytes = [];

  UUID() {
    // generate 16 random bytes (each a single hex digit)
    for (int i = 0; i < 16; i++) {
      var byte = _rand.nextInt(256);
      _bytes.add(byte);
    }
    // 7th byte always starts with 0100b
    _bytes[6] = (4 << 4) | _rand.nextInt(16);
    // 9th byte always starts with 10b, so either 8, 9, a or b
    _bytes[8] = (2 << 6) | _rand.nextInt(64);
  }

  @override
  String toString() {
    var groups = <String>[];
    var sb = StringBuffer();
    // i is for _bytes index, j for how many done in current group
    for (var i = 0, j = 0, lenInd = 0; i < _bytes.length; i++) {
      var groupLen = _lengths[lenInd];
      sb.write(_bytes[i].toRadixString(16).padLeft(2, '0'));
      if (++j >= groupLen) {
        groups.add(sb.toString());
        sb.clear();
        j = 0;
        lenInd++;
      }
    }
    return groups.join('-');
  }

  List<int> get bytes => _bytes;
}
