import 'package:mobx/mobx.dart';
import 'package:poke_dex/features/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/data/models/specie.dart';
import 'package:poke_dex/features/domain/entities/status_entity.dart';

import 'package:poke_dex/features/domain/usecases/fetch_pokemon_details_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_species_usecase.dart';

part 'pokemon_v2_store.g.dart';

class PokemonV2Store = _PokemonV2StoreBase with _$PokemonV2Store;

abstract class _PokemonV2StoreBase with Store {
  final IFetchPokemonDetailsUseCase fetchPokemonDetailsUseCase;
  final IFetchSpeciesUseCase fetchSpeciesUseCase;

  _PokemonV2StoreBase({
    required this.fetchPokemonDetailsUseCase,
    required this.fetchSpeciesUseCase,
  });

  @observable
  SpecieModel? specie;

  @observable
  PokemonDetailModel? pokemonDetail;

  @observable
  StatusEntity? fetchSpecieStatus;

  @observable
  StatusEntity? fetchPokemonDetailStatus;

  @action
  Future fetchPokemonDetails(String name) async {
    fetchPokemonDetailStatus = InProgressStatus();

    final res = await fetchPokemonDetailsUseCase(PokemonDetailsParams(name));

    if (res.isRight()) {
      pokemonDetail = res.getOrElse(() => const PokemonDetailModel());
      fetchPokemonDetailStatus = DoneStatus();
    } else if (res.isLeft()) {
      fetchPokemonDetailStatus = ErrorStatus();
    }
  }

  @action
  Future fetchSpecie(int number) async {
    fetchSpecieStatus = InProgressStatus();

    final res =
        await fetchSpeciesUseCase(FetchSpeciesParams(number.toString()));

    if (res.isRight()) {
      specie = res.getOrElse(() => SpecieModel());
      fetchSpecieStatus = DoneStatus();
    } else if (res.isLeft()) {
      fetchSpecieStatus = ErrorStatus();
    }
  }
}
