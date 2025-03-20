import 'package:flutter/material.dart';
import 'package:green_cross_test/view/viewmodel/MemoViewModel.dart';

import 'domain/model/OfficeModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _MemoScreen(
          office: OfficeModel(
              name: "단아치과의원",
              location: "서울 구로구 구로 1동"
          ),
      ),
    );
  }
}

class _MemoScreen extends StatelessWidget {
  late final MemoViewModel _viewModel;

  _MemoScreen({required OfficeModel office}) {
    _viewModel = MemoViewModel(office);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_viewModel.office.name),
            Text(_viewModel.office.location),
          ],
        ),
      ),
    );
  }
}