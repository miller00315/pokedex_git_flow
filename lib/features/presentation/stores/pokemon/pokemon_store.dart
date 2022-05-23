import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:poke_dex/config/consts/palette.dart';
import 'package:poke_dex/config/consts/urls.dart';
import 'package:poke_dex/core/usecase/usecase.dart';
import 'package:poke_dex/core/utils/string_replace.dart';
import 'package:poke_dex/features/data/models/pokemon_list_model.dart';
import 'package:poke_dex/features/data/models/pokemon_model.dart';
import 'package:poke_dex/features/domain/entities/status_entity.dart';
import 'package:poke_dex/features/domain/usecases/fetch_favorites_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/set_favorites_usecase.dart';

part 'pokemon_store.g.dart';

class PokemonStore = _PokemonStoreBase with _$PokemonStore;

abstract class _PokemonStoreBase with Store {
  final IFetchPokemonUseCase fetchPokemonUseCase;

  final IFetchFavoritesUsecase fetchFavoritesUsecase;

  final ISetFavoritesUsecase setFavoritesUsecase;

  _PokemonStoreBase(
    this.fetchPokemonUseCase,
    this.fetchFavoritesUsecase,
    this.setFavoritesUsecase,
  );

  @observable
  PokeListModel? _pokeList;

  @observable
  PokemonModel? _currentPokemon;

  @observable
  ObservableList<int> favorites = <int>[].asObservable();

  @observable
  Color? pokemonColor;

  @observable
  int? currentPosition;

  @observable
  StatusEntity fetchStatus = IdleStatus();

  @computed
  PokeListModel? get pokeList => _pokeList;

  @computed
  PokemonModel? get currentPokemon => _currentPokemon;

  @action
  Future fetchPokemonList() async {
    _pokeList = null;

    fetchStatus = InProgressStatus();

    final res = await fetchPokemonUseCase(NoParams());

    if (res.isRight()) {
      _pokeList = res.getOrElse(() => const PokeListModel(pokemonList: []));

      fetchStatus = DoneStatus();
    } else if (res.isLeft()) {
      fetchStatus = ErrorStatus();
    }
  }

  PokemonModel getPokemon({required int index}) {
    return _pokeList!.pokemonList![index];
  }

  @action
  setCurrentPokemon({required int index}) {
    _currentPokemon = _pokeList!.pokemonList![index];

    pokemonColor = Palette.getColorType(type: _currentPokemon!.type![0]);

    currentPosition = index;
  }

  @action
  Widget getImage({required String number}) {
    return Image.network(
      replaceVariables(
        text: Urls.pokemonImageUrl,
        variables: {Urls.pokemonImageReplaceNumberParameter: number},
      ),
    );
  }

  @action
  Future favoriteUnfavorite(int id) async {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }

    await setFavoritesUsecase(SetFavoritesParams(favorites));
  }

  @action
  Future getFavorites() async {
    final res = await fetchFavoritesUsecase(NoParams());

    if (res.isRight()) {
      favorites = (res.getOrElse(() => [])).asObservable();
    } else if (res.isLeft()) {}
  }
}
