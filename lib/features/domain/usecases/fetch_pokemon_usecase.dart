import 'package:poke_dex/features/data/models/pokemon_list_model.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_repository.dart';

class FetchPokemonUseCase {
  final PokemonRepository pokemonRepository;

  FetchPokemonUseCase(this.pokemonRepository);

  Future<PokeListModel> call() async {
    return await pokemonRepository.fetchPokemonList();
  }
}
