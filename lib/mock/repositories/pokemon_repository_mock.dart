import 'dart:async';
import 'package:poke_dex/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poke_dex/features/domain/repositories/pokemon_repository.dart';
import 'package:poke_dex/mock/fake_data/pokemon_fake_data.dart';
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';

class PokemonRepositoryMock extends PokemonRepository {
  @override
  Future<Either<Failure, PokeListModel>> fetchPokemonList() {
    return Future.delayed(
      const Duration(microseconds: 2000),
      () => const Right(
        PokeListModel(
          pokemonList: PokemonFakeData.pokemonList,
        ),
      ),
    );
  }
}
