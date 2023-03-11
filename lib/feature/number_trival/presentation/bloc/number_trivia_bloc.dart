import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:clean_architecure_course/error/failure.dart';
import 'package:clean_architecure_course/feature/number_trival/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
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

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
        required this.getRandomNumberTrivia,
        required this.inputConverter})
      : super(Empty())  {
    on<NumberTriviaEvent>(mapEventToState);
  }

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  Future<void>  mapEventToState(
      NumberTriviaEvent event,
      Emitter<NumberTriviaState> emit,
      ) async {
    try {
      emit(Loading());
      if (event is GetTriviaForConcreteNumber) {


        try {
          final integer = int.parse(event.numberString);
          if (integer < 0) throw Exception();
          emit( Loading());
          final numberTriviaEither = await getConcreteNumberTrivia.call(Params(number: integer));
          _eitherLoadedOrErrorState(numberTriviaEither, emit);
        } on Exception {
          emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        }

      } else if (event is GetTriviaForRandomNumber) {

        emit(Loading());
        final numberTriviaEither = await getRandomNumberTrivia.call(NoParams());
        _eitherLoadedOrErrorState(numberTriviaEither, emit);
      }
    } catch (e) {
      emit(( Error(message: UNKNOWN_FAILURE_MESSAGE)));
    }
  }



  void _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> either,
      Emitter<NumberTriviaState> emit){
    emit(either.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (trivia) => Loaded(trivia: trivia),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
