import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_v2_repository.dart';

abstract class IFetchPokemonDetailsUseCase
    implements UseCase<PokemonDetailModel, PokemonDetailsParams> {}

class FetchPokemonDetailsUseCase implements IFetchPokemonDetailsUseCase {
  final PokemonV2Repository pokemonRepository;

  FetchPokemonDetailsUseCase(this.pokemonRepository);

  @override
  Future<Either<Failure, PokemonDetailModel>> call(
      PokemonDetailsParams params) async {
    return await pokemonRepository.fetchPokemonDetails(params.name);
  }
}

class PokemonDetailsParams extends Equatable {
  final String name;

  const PokemonDetailsParams(this.name);

  @override
  List<Object?> get props => [name];

  @override
  String toString() => '''
  Params {
    number: $name,
  }
  ''';
}
