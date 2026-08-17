import 'package:digimon/api/digimon_api.dart';
import 'package:digimon/controller/cubit/data_cubit.dart';
import 'package:digimon/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final digimonApi = DigimonApi();
  runApp(MyApp(digimonApi: digimonApi));
}

class MyApp extends StatelessWidget {
  final DigimonApi digimonApi;

  const MyApp({super.key, required this.digimonApi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(digimonApi),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
