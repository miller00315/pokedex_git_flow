import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/domain/repositories/secure_storage_repository.dart';

abstract class ISetFavoritesUsecase
    implements UseCase<void, SetFavoritesParams> {}

class SetFavoritesUsecase implements ISetFavoritesUsecase {
  final SecureStorageRepository repository;

  SetFavoritesUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetFavoritesParams params) async {
    return await repository.setFavoritesItem(params.ids);
  }
}

class SetFavoritesParams extends Equatable {
  final List<int> ids;

  const SetFavoritesParams(this.ids);

  @override
  List<Object?> get props => [ids];

  @override
  String toString() => '''
  Params {
    ids: $ids,
  }
  ''';
}
