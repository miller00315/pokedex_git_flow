import 'package:get_it/get_it.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_details_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_pokemon_usecase.dart';
import 'package:poke_dex/features/domain/usecases/fetch_species_usecase.dart';

void useCasesInjector(GetIt serviceLocator) {
  serviceLocator.registerFactory<FetchPokemonUseCase>(
    () => FetchPokemonUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<FetchPokemonDetailsUseCase>(
    () => FetchPokemonDetailsUseCase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<FetchSpeciesUseCase>(
    () => FetchSpeciesUseCase(
      serviceLocator(),
    ),
  );
}
