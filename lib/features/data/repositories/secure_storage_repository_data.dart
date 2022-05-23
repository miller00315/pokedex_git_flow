import 'package:poke_dex/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/data/data_sources/secure_storage_data_source.dart';
import 'package:poke_dex/features/domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryData extends SecureStorageRepository {
  final ISecureStorageDataSource secureStorageDataSource;

  SecureStorageRepositoryData(this.secureStorageDataSource);

  @override
  Future<Either<Failure, List<int>>> getFavoritesItems() async {
    try {
      final res = await secureStorageDataSource.getFavoritesItems();

      return Right(res);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> setFavoritesItem(List<int> ids) async {
    try {
      await secureStorageDataSource.setFavoritesItem(ids);

      return Right(NoParams());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
