import 'package:bloc/bloc.dart';
import 'package:clean_architecure_course/feature/number_trival/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../util/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String UNKNOWN_FAILURE_MESSAGE = 'Unknown Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter}) : super(Empty()) {
    on<NumberTriviaEvent>(mapEventToState);
  }

  Stream<NumberTriviaState> mapEventToState(
      NumberTriviaEvent event,
      Emitter<NumberTriviaState> emit,
      ) async* {
    try {

      emit(Loading());
      if (event is GetTriviaForConcreteNumber) {
    final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
    yield* inputEither.fold((failure) async* {
      emit(const Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE));
    }, (integer) async* {
         final numberTrivia = await getConcreteNumberTrivia.call(Params(number: integer));
      // emit(Loaded(numberTrivia: numberTrivia))
    });
      }

      if (event is GetTriviaForRandomNumber) {
        final numberTrivia = await getRandomNumberTrivia.call(NoParams());
      }

    //  final categoriesModel = await _apiRepository.fetchCategoriesList();

    //  emit(AllCategoriesLoaded(categoriesModel));

    /*  if (categoriesModel.error != null) {
        emit(AllCategoriesError(categoriesModel.error));
      }*/
    } catch (e) {
      emit(const Error(errorMessage: UNKNOWN_FAILURE_MESSAGE));
    }
  }

  Stream<NumberTriviaState> mapEventToState2(
      NumberTriviaEvent event,
      ) async* {
    // Immediately branching the logic with type checking, in order
    // for the event to be smart casted
    if (event is GetTriviaForConcreteNumber) {
      inputConverter.stringToUnsignedInteger(event.numberString);
    }
  }
}
