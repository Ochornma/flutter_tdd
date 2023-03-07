part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [props];
}


//these are the different possible states

//empty state
class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

//loading state
class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

//loaded state
class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const Loaded({required this.numberTrivia});
  @override
  List<Object> get props => [numberTrivia];
}

class Error extends NumberTriviaState {
  final String errorMessage;

  const Error({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
