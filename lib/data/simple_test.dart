// Create a Configuration object
import 'package:flutter/rendering.dart';
import 'package:realm/realm.dart';
import 'package:test_realm/model/dog.dart';

final realmInstance = RealmHandler();

class RealmHandler {
  late Configuration config;
  late Realm realm;

  Future<void> onInit() async {
    final app = App(AppConfiguration('application-0-iwypt'));
    final user = await app.logIn(Credentials.anonymous());

    realm = Realm(Configuration.flexibleSync(user, [Dog.schema]));
    realm.subscriptions.update((mutableSubscriptions) {});
    await onSyncData();
  }

  void onClose() {
    realm.close();
  }

  void onAdd() {
    realm.write(() {
      realm.add(Dog(ObjectId(), 'Clifford', 12));
    });
  }

  RealmResults<Dog> onGetAll() {
    return realm.all<Dog>();
  }

  Dog onGetById(int id) {
    final item = onGetAll().firstWhere((element) => element.id == id);
    return item;
  }

  Dog? onGetByIndex(int index) {
    var itemByKey = realm.find<Dog>(index);
    return itemByKey;
  }

  void onDelete(Dog item) {
    realm.write(() {
      realm.delete(item);
    });
  }

  Future<void> onSyncData() async {
    await realm.subscriptions.waitForSynchronization();
  }
}
