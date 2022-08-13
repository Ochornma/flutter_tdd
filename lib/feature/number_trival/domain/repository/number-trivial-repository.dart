import 'package:clean_architecure_course/error/failure.dart';
import 'package:clean_architecure_course/feature/number_trival/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumber();
}
