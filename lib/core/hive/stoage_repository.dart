import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  static HiveService? _instance;
  late Box _box;

  factory HiveService() {
    if (_instance == null) {
      _instance = HiveService._();
    }
    return _instance!;
  }

  HiveService._();

  Future<void> initHive() async {
    final appDocumentDir =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _box = await Hive.openBox('myBox');
  }

  Box get box => _box;
}