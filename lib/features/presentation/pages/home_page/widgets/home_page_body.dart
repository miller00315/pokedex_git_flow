import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:poke_dex/features/data/models/pokemon_model.dart';
import 'package:poke_dex/features/presentation/pages/home_page/widgets/poke_item/poke_item.dart';

/// Body referente a página de home
class HomePageBody extends StatelessWidget {
  static const homePagePokeItem = 'homepagePokeItem';

  /// Lista de pokemons que serão renderizados
  final List<PokemonModel>? pokemons;

  /// O texto deve ser traduzido ao cria os Widgets
  final bool shouldTranslate;

  final void Function({
    required PokemonModel pokemon,
    required int index,
  }) handlePokemonItemClicked;

  const HomePageBody({
    Key? key,
    required this.pokemons,
    required this.handlePokemonItemClicked,
    this.shouldTranslate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        addAutomaticKeepAlives: true,
        itemCount: pokemons != null ? pokemons!.length : 0,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final pokemon = pokemons!.elementAt(index);

          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            child: ScaleAnimation(
              child: GestureDetector(
                key: Key('$homePagePokeItem$index'),
                onTap: () => handlePokemonItemClicked(
                  pokemon: pokemon,
                  index: index,
                ),
                child: PokeItem(
                  shouldTranslate: shouldTranslate,
                  pokemon: pokemon,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
