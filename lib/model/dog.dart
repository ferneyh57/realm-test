import 'package:realm/realm.dart';
part 'dog.g.dart';

@RealmModel()
class _Dog {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String name;

  late int age;
}
