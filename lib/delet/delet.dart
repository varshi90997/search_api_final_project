import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key ?key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int get count => list.length;

  List<int> list = [];

  void initState() {
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
  }

  void load() {
    print("load");
    setState(() {
      list.addAll(List.generate(15, (v) => v));
      print("data count = ${list.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: LoadMore(
          isFinish: count >= 60,
          onLoadMore: _loadMore,
          whenEmptyLoad: false,
          delegate: const DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40.0,
                alignment: Alignment.center,
                child: Text(list[index].toString(),style: TextStyle(color: Colors.black)),
              );
            },
            itemCount: count,
          ),
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    list.clear();
    load();
  }
}