import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failure.dart';
import '../../../../usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repository/number-trivial-repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
