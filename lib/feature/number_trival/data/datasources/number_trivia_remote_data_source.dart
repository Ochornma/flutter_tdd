import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../error/exception.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  /* @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number');*/

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final response = await _getTriviaFromUrl('$number');
    return NumberTriviaModel.fromJson(response);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final response = await _getTriviaFromUrl('random');
    return NumberTriviaModel.fromJson(response);
  }

  Future<Map<String, dynamic>> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse('http://numbersapi.com/$url'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
    //  var jsonResponse =  json.decode(response.body);
    //  final message = jsonResponse["dddd"];
      throw ServerException(message: 'Error in fetching random number');
    }
  }

  /*Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Error in fetching random number');
    }
  }*/
}
