import 'package:get_it/get_it.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_data_source.dart';
import 'package:poke_dex/features/data/data_sources/pokemon_v2_data_source.dart';
import 'package:poke_dex/features/data/data_sources/secure_storage_data_source.dart';

void dataSourcesInjector(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<IPokemonDataSource>(
    () => PokemonDataSource(),
  );

  serviceLocator.registerLazySingleton<IPokemonV2DataSource>(
    () => PokemonV2DataSource(),
  );

  serviceLocator.registerLazySingleton<ISecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );
}
