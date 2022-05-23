import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_data_source.dart';
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_repository.dart';

/// Repositório referente a api pokemon
class PokemonRepositoryData extends PokemonRepository {
  /// Serviço responsável por solicitar os dados a api
  final IPokemonDataSource _pokemonDataSource;

  PokemonRepositoryData(this._pokemonDataSource);

  /// Obtém a lista de pokemons da api
  @override
  Future<Either<Failure, PokeListModel>> fetchPokemonList() async {
    try {
      final pokeList = await _pokemonDataSource.fetchPokemonList();

      return Right(pokeList);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
