import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hl_assugnment_test/cubit/joke_cubit.dart';
import 'package:hl_assugnment_test/model/joke_model.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: BlocBuilder<JokeCubit, JokeState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (state is JokeLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is JokeEnough)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Text(
                      state.jokeContent ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                )
              else if (state is JokeLoaded) ...[
                _bodyHeaderBuild(),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Text(
                      state.jokeModel?.content ?? '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ),
                _bodyButtonBuild(context, joke: state.jokeModel)
              ] else if (state is JokeError)
                const Center(
                  child: Text('Error!!!'),
                )
              else
                Center(
                    child: TextButton(
                  onPressed: () => context.read<JokeCubit>().getJokeFromApi(),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    visualDensity: const VisualDensity(vertical: -1),
                    minimumSize: const Size(150, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Tap to get joke',
                      style: TextStyle(color: Colors.white)),
                ))
            ],
          );
        },
      ),
    );
  }

  Padding _bodyButtonBuild(BuildContext context, {JokeModel? joke}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () =>
                  context.read<JokeCubit>().voteJoke(joke: joke?..vote = true),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                visualDensity: const VisualDensity(vertical: -1),
                minimumSize: const Size(150, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text('This is Funny!',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: TextButton(
              onPressed: () =>
                  context.read<JokeCubit>().voteJoke(joke: joke?..vote = false),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                visualDensity: const VisualDensity(vertical: -1),
                minimumSize: const Size(150, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text('This is not funny',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Container _bodyHeaderBuild() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 12),
      decoration: const BoxDecoration(
          color: Colors.green,
          boxShadow: [BoxShadow(offset: Offset(0, -2), color: Colors.black12)]),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A joke a day keeps the doctor away',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'If you joke wrong way, your teeth have to pay. (Serious)',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image.asset(
          'assets/images/hl_logo.png',
          height: 60,
        ),
      ),
      actions: const [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Text('Handicrafted by'), Text('Tien Dat')],
        ),
        SizedBox(
          width: 8,
        ),
        CircleAvatar(
          child: Text('D'),
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
