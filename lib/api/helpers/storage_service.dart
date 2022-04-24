import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageItemModel {
  final String key;
  final String value;

  const StorageItemModel({ required this.key, required this.value });
}

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<void> write(StorageItemModel item) async {
    await _secureStorage.write(key: item.key, value: item.value, aOptions: _getAndroidOptions());
  }

  Future<bool> has(String key) async {
    return _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
  }

  Future<String?> read(String key) async {
    return _secureStorage.read(key: key, aOptions: _getAndroidOptions());
  }

  Future<List<StorageItemModel>> readAll() async {
    Map<String, String> items = await _secureStorage.readAll(aOptions: _getAndroidOptions());

    return items.entries.map((item) => StorageItemModel(key: item.key, value: item.value)).toList();
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}
