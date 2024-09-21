import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hl_assugnment_test/model/joke_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'joke_state.dart';

String APIKey = "sOcK061y8PP9ZzUE0CbJ2w==C2AGS7W72k89ZBsC";

class JokeCubit extends Cubit<JokeState> {
  JokeCubit() : super(JokeInitial());

  int jokeCountToday = 1;
  List<JokeModel?> listJoke = [];

  void getJokeFromApi() async {
    emit(JokeLoading());
    try {
      var url = Uri.https('api.api-ninjas.com', 'v1/jokes');
      var response = await http.get(url, headers: {'X-Api-Key': APIKey});

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        JokeModel jokeModel = JokeModel();
        jokeModel.content = json[0]["joke"];
        jokeModel.index = jokeCountToday += 1;
        jokeCountToday >= 10
            ? emit(JokeEnough(
                jokeContent:
                    'That is all the jokes for today! Come back another day!'))
            : emit(JokeLoaded(
                jokeModel: jokeModel, jokeCountToday: jokeModel.index));
      } else {
        emit(JokeError());
      }
    } catch (e) {
      emit(JokeError());
    }
  }

  void saveJokeToDatabase({JokeModel? joke}) async {
    listJoke.add(joke);
    final jokeBox = await Hive.openBox<List<JokeModel?>>('jokeBox');

    if (joke != null) {
      jokeBox.put("joke", listJoke);
      print(jokeBox.get('joke'));
    }
  }

  void voteJoke({JokeModel? joke}) {
    saveJokeToDatabase(joke: joke);
    getJokeFromApi();
  }
}
