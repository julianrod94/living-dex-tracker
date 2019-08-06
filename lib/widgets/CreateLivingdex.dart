import 'package:flutter/material.dart';
import 'package:living_dex_tracker/data/Repository.dart';
import 'package:living_dex_tracker/model/Game.dart';

class AddLivingdex extends StatefulWidget {
  @override
  AddLivingdexState createState() {
    return AddLivingdexState();
  }
}

class AddLivingdexState extends State<AddLivingdex> {
  final formKey = GlobalKey<FormState>();
  bool isShiny = false;
  String name = "";
  Game game;
  Future<List<Game>> _future;

  initState() {
    super.initState();
    _future = Repository.get().listGames();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            child: Center(
              child: TextFormField(
                //initialValue: null,
                decoration: InputDecoration(
                    labelText: 'Livingdex Name'
                ),
                validator: (value) => value.isEmpty ? 'Enter some text' : null,
                onSaved: (String value) {
                  name = value;
                },
              ),
            ),
          ),
          FutureBuilder<List<Game>>(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading games');
                default:
                  if (snapshot.hasError)
                    return Container();
                  else {
                    var games = snapshot.data;
                    game ??= games[0];
                    return Container(
                      height: 100,
                      child: Center(
                        child: DropdownButtonFormField<Game>(
                          decoration: InputDecoration(
                              labelText: 'Livingdex Game'
                          ),
                          value: game,
                          items: games.map<DropdownMenuItem<Game>>((game) =>
                              DropdownMenuItem<Game>(
                                  child: Text(game.name),
                                  value: game))
                              .toList(),
                          onChanged: (value) => setState(() => game = value)
                        ),
                      ),
                    );
                  }
              }
            },
          ),
          Container(
            height: 100,
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                    "Shiny",
                    textAlign: TextAlign.left,
                    style: DefaultTextStyle
                        .of(context)
                        .style
                        .apply(fontSizeFactor: 1.2),
                  ),
                  Checkbox(
                    value: isShiny,
                    onChanged: (bool value) => setState(() => isShiny = value),
                  ),
                ],
              ),
            ),
          ),
          Container(
            //width: screenSize.width,
            child: new RaisedButton(
              child: new Text(
                "Let's Go!",
                style: new TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  Repository.get().createLivingdex(
                    name,
                    game.id,
                    isShiny,
                    false,
                  );
                  Navigator.pop(context);
                }
              },
              color: Colors.red,
            ),
            margin: new EdgeInsets.only(
                top: 20.0
            ),
          )
        ],
      ),
    );
  }
}