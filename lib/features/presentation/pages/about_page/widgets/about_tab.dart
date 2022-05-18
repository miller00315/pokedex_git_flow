import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_dex/config/consts/app_text.dart';
import 'package:poke_dex/config/consts/font_sizes.dart';
import 'package:poke_dex/features/data/models/specie.dart';
import 'package:poke_dex/features/domain/entities/status_entity.dart';
import 'package:poke_dex/injector/main.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_store.dart';
import 'package:poke_dex/features/presentation/stores/pokemon/pokemon_v2_store.dart';
import 'package:poke_dex/features/presentation/widgets/layout/error_page.dart';

class AboutTab extends StatelessWidget {
  AboutTab({
    Key? key,
  }) : super(key: key);

  final PokemonStore _pokemonStore = serviceLocator<PokemonStore>();
  final PokemonV2Store _pokemonV2Store = serviceLocator<PokemonV2Store>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            AppText.description,
            style: TextStyle(
              fontSize: FontSizes.medium,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Observer(
            builder: (context) {
              switch (_pokemonV2Store.fetchSpecieStatus.runtimeType) {
                case InProgressStatus:
                  return const CircularProgressIndicator();

                case DoneStatus:
                  {
                    SpecieModel? _specie = _pokemonV2Store.specie;

                    return SingleChildScrollView(
                      child: _specie != null
                          ? Text(
                              _specie.flavorTextEntries!
                                  .where((item) => item.language!.name == 'en')
                                  .first
                                  .flavorText!,
                              style: const TextStyle(
                                fontSize: FontSizes.small,
                              ),
                            )
                          : const Center(
                              child: Text(AppText.noData),
                            ),
                    );
                  }

                case ErrorStatus:
                  return const ErrorPage();

                default:
                  return Container();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            AppText.biology,
            style: TextStyle(
              fontSize: FontSizes.medium,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Observer(
              builder: (context) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          AppText.height,
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokemonStore.currentPokemon!.height!,
                          style: const TextStyle(
                            fontSize: FontSizes.small,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          AppText.weight,
                          style: TextStyle(
                            fontSize: FontSizes.small,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokemonStore.currentPokemon!.weight!,
                          style: const TextStyle(
                            fontSize: FontSizes.small,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
