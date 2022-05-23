import 'package:equatable/equatable.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/data/models/specie.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_v2_repository.dart';

abstract class IFetchSpeciesUseCase
    implements UseCase<SpecieModel, FetchSpeciesParams> {}

class FetchSpeciesUseCase implements IFetchSpeciesUseCase {
  final PokemonV2Repository pokemonRepository;

  FetchSpeciesUseCase(this.pokemonRepository);

  @override
  Future<Either<Failure, SpecieModel>> call(FetchSpeciesParams params) async {
    return await pokemonRepository.fetchSpecie(params.number);
  }
}

class FetchSpeciesParams extends Equatable {
  final String number;

  const FetchSpeciesParams(this.number);

  @override
  List<Object?> get props => [number];

  @override
  String toString() => '''
  Params {
    number: $number,
  }
  ''';
}
