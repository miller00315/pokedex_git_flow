import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokeListModel>> fetchPokemonList();
}
