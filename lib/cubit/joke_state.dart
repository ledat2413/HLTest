part of 'joke_cubit.dart';

@immutable
sealed class JokeState {}

final class JokeInitial extends JokeState {}

final class JokeLoading extends JokeState {}

final class JokeLoaded extends JokeState {
  final JokeModel? jokeModel;
  final int? jokeCountToday;

  JokeLoaded({required this.jokeModel, this.jokeCountToday});
}

final class JokeEnough extends JokeState {
  final String? jokeContent;

  JokeEnough({required this.jokeContent});
}

final class JokeError extends JokeState {}
