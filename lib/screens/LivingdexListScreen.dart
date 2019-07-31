import 'package:flutter/material.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Livingdex.dart';
import 'CreateLivingdexScreen.dart';
import '../widgets/LivingdexListElement.dart';

class LivingdexListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        FutureBuilder<List<Livingdex>>(
          future: Repository.get().listLivingdexes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Text('Loading Livingdexes');
              default:
                if (snapshot.hasError)
                  return Text('Oops, something wrong happened. Please Reload the app.');
                else {
                  List<Livingdex> livingdexes = snapshot.data;
                  return ListView.builder(
                    itemCount: livingdexes.length,
                    itemBuilder: (BuildContext context, int index) {
                      var livingdex = livingdexes[index];
                      return new LivingdexListElement(
                        name: livingdex.name,
                        game: 'emerald',
                        totalPokemon: livingdex.pokemons.length,
                        type: livingdex.shiny ? 'shiny' : 'regular',
                      );
                    }
                  );
                }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateLivingdexScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
    );
  }
}
