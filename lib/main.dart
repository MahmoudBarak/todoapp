import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Cubit/AppCubit/app_cubit.dart';
import 'package:todoapp/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDataBase(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomeScreen() ,

      ),
    );
  }
}

