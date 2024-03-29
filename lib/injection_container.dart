
import 'package:clean_architecure_course/feature/number_trival/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecure_course/feature/number_trival/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecure_course/platform/network_info.dart';
import 'package:clean_architecure_course/util/input_converter.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/number_trival/data/datasources/number_trivia_local_data_source.dart';
import 'feature/number_trival/data/datasources/number_trivia_remote_data_source.dart';
import 'feature/number_trival/data/repositories/number_trivia_repository_impl.dart';
import 'feature/number_trival/domain/repository/number-trivial-repository.dart';
import 'feature/number_trival/domain/usecases/get_random_number_trivia.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

//we are using future because of the shared prefrence but if not it should be
// void init() async {
Future<void> init() async {
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  //usecases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //repository
  sl.registerLazySingleton<NumberTriviaRepository>(
        () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}