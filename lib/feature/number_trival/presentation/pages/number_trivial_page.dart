import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';


class NumberTriviaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
          child: buildBody(context)),
    );
  }

BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Top half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(builder: (context, state){
              if (state is Empty){
                return const MessageDisplay(message: 'Start searching!');
              }else if (state is Loading){

                return const LoadingWidget();
              }
              else if (state is Error) {

                return MessageDisplay(
                  message: state.message,
                );
              }else if (state is Loaded) {

                return TriviaDisplay(
                  numberTrivia: state.trivia,
                );
              }else{
                return Container();
              }

            }),

            SizedBox(height: 20),
            // Bottom half
            TriviaControls()
          ],
        ),
      ),
    ),
  );
}
}
