import 'package:hive/hive.dart';
import '../../features/data/models/authentication_user.dart';

void registerAdapters() {
  Hive.registerAdapter(AuthenticationUserAdapter());
}
