import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/domain/repositories/secure_storage_repository.dart';

abstract class IFetchFavoritesUsecase implements UseCase<List<int>, NoParams> {}

class FetchFavoritesUsecase implements IFetchFavoritesUsecase {
  final SecureStorageRepository repository;

  FetchFavoritesUsecase(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return await repository.getFavoritesItems();
  }
}
