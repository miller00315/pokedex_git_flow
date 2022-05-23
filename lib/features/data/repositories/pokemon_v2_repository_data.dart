import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_v2_data_source.dart';
import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/data/models/specie.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_v2_repository.dart';

/// Repositório referente a api pokemonV2
class PokemonV2RepositoryData extends PokemonV2Repository {
  /// Serviço reposnsável por solicitar a api os dados da api
  final IPokemonV2DataSource _pokemonV2DataSource;

  PokemonV2RepositoryData(this._pokemonV2DataSource);

  /// Obtem os dados sobre os detalhes dos pokemons, [name] representa o nome do pookemon
  @override
  Future<Either<Failure, PokemonDetailModel>> fetchPokemonDetails(
      String name) async {
    try {
      final pokemonDetail =
          await _pokemonV2DataSource.fetchPokemonDetails(name);

      return Right(pokemonDetail);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  /// Obetém os dados sobre a espécie do pokemon, [number] representa o número do pokemon enviado pela api
  @override
  Future<Either<Failure, SpecieModel>> fetchSpecie(String number) async {
    try {
      final specie = await _pokemonV2DataSource.fetchSpecie(number);

      return Right(specie);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
