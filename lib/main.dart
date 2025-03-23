import 'package:flutter/material.dart';
import 'package:green_cross_test/domain/model/AccountModel.dart';
import 'package:green_cross_test/view/state/UiState.dart';
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

class _MemoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MemoState();
}

class MemoState extends State {
  final MemoViewModel _viewModel = MemoViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      // TODO: base 정보 입력
        future: _viewModel.init("단아치과의원", "서울 구로구 구로 1동", "CE"),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _viewModel.office.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                      _viewModel.office.location,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                            tabs: [
                              Tab(text: "메모"),
                              Tab(text: "일정"),
                            ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: Colors.black,
                        ),
                        SizedBox(
                          height: 600,
                          child: TabBarView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("총 ${_viewModel.memos.size()}개"),
                                    ),
                                    SizedBox(height: 12),
                                    Expanded(
                                      child: ListView.separated(
                                        itemBuilder: (BuildContext context, int index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _viewModel.memos.get(index).author.role,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            _viewModel.memos.get(index).author.office.name,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "(${_viewModel.memos.get(index).createdAt.toString()})",
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: Text("수정"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          _viewModel.deleteMemo(_viewModel.memos.get(index))
                                                              .then((state) {
                                                            if (state is Success) {
                                                              setState(() {});
                                                            } else {
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: Text("에러"),
                                                                    content: Text(_viewModel.error),
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          });
                                                        },
                                                        child: Text("삭제"),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(_viewModel.memos.get(index).content),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemCount: _viewModel.memos.size(),
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ),
                                  ],
                                ),
                                Container()
                              ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButton: FloatingActionButton.extended(
                label: Text("메모 작성하기"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("메모 작성하기"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _viewModel.office.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          Text(
                            _viewModel.office.location,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: TextField(
                              controller: _viewModel.memoContentController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey
                                      )
                                  )
                              ),
                              maxLines: 8,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "취소",
                                    style: TextStyle(
                                        color: Colors.black45
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey.withOpacity(0.4)
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    // TODO: 메모 작성
                                    _viewModel.createMemoAndLoad().then((state) {
                                      if (state is Success) {
                                        Navigator.pop(context);
                                        setState(() {});
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("에러"),
                                                content: Text(_viewModel.error),
                                              );
                                            },
                                        );
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "완료",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
    );
  }
}