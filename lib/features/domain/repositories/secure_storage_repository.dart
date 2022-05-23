import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/core/usecase/usecase.dart';

abstract class SecureStorageRepository {
  Future<Either<Failure, NoParams>> setFavoritesItem(List<int> ids);

  Future<Either<Failure, List<int>>> getFavoritesItems();
}
