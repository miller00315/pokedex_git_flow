import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_v2_repository.dart';

class FetchPokemonDetailsUseCase {
  final PokemonV2Repository pokemonRepository;

  FetchPokemonDetailsUseCase(this.pokemonRepository);

  Future<PokemonDetailModel> call(String number) async {
    return await pokemonRepository.fetchPokemonDetails(number);
  }
}
