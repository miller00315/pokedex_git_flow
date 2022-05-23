import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poke_dex/features/domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryMock extends SecureStorageRepository {
  List<int> favorites = [];

  @override
  Future<Either<Failure, List<int>>> getFavoritesItems() {
    // TODO: implement getFavoritesItems
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoParams>> setFavoritesItem(List<int> ids) {
    // TODO: implement setFavoritesItem
    throw UnimplementedError();
  }

  /* @override
  Future<List<int>> getFavoritesItems() async {
    return Future.value(favorites);
  }

  @override
  Future setFavoritesItem(List<int> ids) async {
    await Future.delayed(const Duration(milliseconds: 100));

    favorites = ids;
  } */
}
