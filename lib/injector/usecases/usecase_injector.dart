import 'package:get_it/get_it.dart';
import 'package:poke_dex/features/domain/usecases/fetch_favorites_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_details_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_species_usecase.dart';
import 'package:poke_dex/features/domain/usecases/set_favorites_usecase.dart';

void useCasesInjector(GetIt serviceLocator) {
  serviceLocator.registerFactory<IFetchPokemonUseCase>(
    () => FetchPokemonUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<IFetchPokemonDetailsUseCase>(
    () => FetchPokemonDetailsUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<IFetchSpeciesUseCase>(
    () => FetchSpeciesUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ISetFavoritesUsecase>(
    () => SetFavoritesUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<IFetchFavoritesUsecase>(
    () => FetchFavoritesUsecase(
      serviceLocator(),
    ),
  );
}
