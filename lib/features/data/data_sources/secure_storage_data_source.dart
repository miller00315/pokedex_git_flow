import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureStorageDataSource {
  Future setFavoritesItem(List<int> ids);
  Future<List<int>> getFavoritesItems();
}

class SecureStorageDataSource implements ISecureStorageDataSource {
  final FlutterSecureStorage storage;

  SecureStorageDataSource() : storage = const FlutterSecureStorage();

  @override
  Future<List<int>> getFavoritesItems() async {
    final data = await storage.read(key: 'favorites');

    if (data == null || data.isEmpty) {
      return [];
    }

    return List<int>.from(jsonDecode(data));
  }

  @override
  Future setFavoritesItem(List<int> ids) async {
    await storage.write(key: 'favorites', value: jsonEncode(ids));
  }
}
