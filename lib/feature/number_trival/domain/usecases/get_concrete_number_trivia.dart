import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';
import '../entities/number_trivia.dart';
import '../repository/number-trivial-repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({
    required int number,
  }) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
