import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_repository.dart';

abstract class IFetchPokemonUseCase
    implements UseCase<PokeListModel, NoParams> {}

class FetchPokemonUseCase implements IFetchPokemonUseCase {
  final PokemonRepository pokemonRepository;

  FetchPokemonUseCase(this.pokemonRepository);

  @override
  Future<Either<Failure, PokeListModel>> call(NoParams params) async {
    return await pokemonRepository.fetchPokemonList();
  }
}
