import 'package:flutter/material.dart';
import 'package:green_cross_test/domain/model/AccountModel.dart';
import 'package:green_cross_test/view/viewmodel/MemoViewModel.dart';

import 'domain/model/OfficeModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoApplication',
      home: _MemoScreen(),
    );
  }
}

class _MemoScreen extends StatelessWidget {
  final MemoViewModel _viewModel = MemoViewModel();

  _MemoScreen();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _viewModel.init("단아치과의원", "서울 구로구 구로 1동", "CE"),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8A00),
              ),
            );
          } else {
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
                    Text(_viewModel.user.office.name),
                    Text(_viewModel.user.role),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}