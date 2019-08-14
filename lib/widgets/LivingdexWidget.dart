import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Pokemon.dart';
import 'package:living_dex_tracker/widgets/LivingdexElement.dart';
import 'package:living_dex_tracker/model/Livingdex.dart' as LivingdexModel;

class LivingdexWidget extends StatefulWidget {
  final int livingdexId;
  String searchCriteria;

  LivingdexWidget(
      @required this.livingdexId,
      @required this.searchCriteria,
      );

  State<StatefulWidget> createState() => LivingdexState();
}

class LivingdexState extends State<LivingdexWidget> {
  LivingdexModel.Livingdex livingdex;
  bool isLoading = true;

  initState() {
    super.initState();
    load();
  }

  load() async {
    livingdex = await Repository.get().getLivingdex(widget.livingdexId);
    this.setState(() => isLoading = false);
  }

  Widget build(BuildContext context) {
    if (this.isLoading) {
      return Text('Loading Pokemon');
    }
    else {
      List<Pokemon> pokemons = livingdex.pokemons.where((pokemon) =>
          pokemon.name.toLowerCase().contains(widget.searchCriteria.toLowerCase())).toList();
      var myGrid = new GridView.builder(
        itemCount: pokemons.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          final itemPokemon = pokemons[index];
          return LivingdexElement(
            pokemon: itemPokemon,
            isShiny: livingdex.shiny,
            livingdexId: widget.livingdexId,
            initialCapturedState: pokemons[index].captured,
            key: Key(itemPokemon.name),
            onCaptureStatusChange: (bool captured) => this.setState(() =>
                livingdex.pokemons = livingdex.pokemons.map((pokemon) {
                  if(pokemon.id == itemPokemon.id) {
                    pokemon.captured = captured;
                  }
                  return pokemon;
                }).toList()
            )
          );
        },
      );
      return myGrid;
    }
  }
}