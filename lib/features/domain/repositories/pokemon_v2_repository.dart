import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/data/models/specie.dart';

abstract class PokemonV2Repository {
  Future<Either<Failure, SpecieModel>> fetchSpecie(String number);

  Future<Either<Failure, PokemonDetailModel>> fetchPokemonDetails(String name);
}
