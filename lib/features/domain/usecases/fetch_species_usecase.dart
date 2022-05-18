import 'package:poke_dex/features/data/models/specie.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_v2_repository.dart';

class FetchSpeciesUseCase {
  final PokemonV2Repository pokemonRepository;

  FetchSpeciesUseCase(this.pokemonRepository);

  Future<SpecieModel> call(String number) async {
    return await pokemonRepository.fetchSpecie(number);
  }
}
