import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:poke_dex/mock/repositories/pokemon_v2_repository_mock.dart';

@GenerateMocks([PokemonV2RepositoryMock])
void main() {
  //final pokemonV2RepositoryMock = MockPokemonV2RepositoryMock();

  //final pokemonV2Store = PokemonV2Store(pokemonV2RepositoryMock);
  group('Pokemonv2Store group', () {
    test('should set a pokemonList empty', () {});
  });
}
