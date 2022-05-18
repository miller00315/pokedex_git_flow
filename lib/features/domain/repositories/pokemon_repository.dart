import 'package:poke_dex/features/data/models/pokemon_list_model.dart';

abstract class PokemonRepository {
  Future<PokeListModel> fetchPokemonList();
}
