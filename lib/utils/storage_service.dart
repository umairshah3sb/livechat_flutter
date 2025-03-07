import 'package:get_storage/get_storage.dart';

class StorageService {
  final store = GetStorage();
  Future<void> initStorage() async {
    await GetStorage.init();
  }

  Future<void> writeData({required String key, required String data}) async {
    await store.write(key, data);
  }

  String? readData({required String key}) {
    return store.read(key);
  }

  Future<void> removeData({required String key}) async {
    await store.remove(key);
  }

  Future<void> clearAll() async {
    await store.erase();
  }
}
