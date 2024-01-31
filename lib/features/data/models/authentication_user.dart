// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'authentication_user.g.dart';

@HiveType(typeId: 0)
class AuthenticationUser extends HiveObject {
  @HiveField(0)
  String photo;
  @HiveField(1)
  // ignore: non_constant_identifier_names
  String snfn;
  @HiveField(2)
  String location;
  AuthenticationUser({
    required this.photo,
    // ignore: non_constant_identifier_names
    required this.snfn,
    required this.location,
  });

  @override
  String toString() => 'AuthenticationUser(id: $photo, firstName: $snfn, lastName: $location)';
}
