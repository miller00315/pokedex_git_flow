import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/data/models/specie.dart';

abstract class PokemonV2Repository {
  Future<SpecieModel> fetchSpecie(String number);

  Future<PokemonDetailModel> fetchPokemonDetails(String name);
}
