import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Truc {
  final int id;
  final String prenom;
  const Truc(this.id, this.prenom);
}

final List<Truc> trucs = List.generate(
  5,
      (i) => Truc(i, "prénom $i"),
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    trucs.shuffle(Random());
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _uplist(int index) {
    if (index > 0) {
      setState(() {
        final temp = trucs[index - 1];
        trucs[index - 1] = trucs[index];
        trucs[index] = temp;
        _checkListSorted();
      });
    }
  }

  void _downlist(int index) {
    if (index < trucs.length - 1) {
      setState(() {
        final temp = trucs[index + 1];
        trucs[index + 1] = trucs[index];
        trucs[index] = temp;
        _checkListSorted();
      });
    }
  }

  void _checkListSorted() {
    bool estOrdre = true;
    for (int i = 0; i < trucs.length - 1; i++) {
      if (trucs[i].id > trucs[i + 1].id) {
        estOrdre = false;
        break;
      }
    }
    if (estOrdre) {
      _showToast("GOOD");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: trucs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(trucs[index].prenom),
              trailing: SizedBox(
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _uplist(index);
                      },
                      child: Text("UP"),
                    ),
                    TextButton(
                      onPressed: () {
                        _downlist(index);
                      },
                      child: Text("DOWN"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
