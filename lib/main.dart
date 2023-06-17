import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_filter_flutter/DataModel.dart';

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

class _MyHomePageState extends State<MyHomePage> {

  List<DataModel> listOfEmp=allEmp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Search Textfield"),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CupertinoSearchTextField(
                // controller: controller,
                onChanged: searchQuery,
                onSubmitted: (value) {},
                autocorrect: true,
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: listOfEmp.length, itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(listOfEmp[index].name),
                  subtitle: Text(listOfEmp[index].salary.toString()),
                );
            },
            ))
          ],
        ),
      ),
      );
  }

  void searchQuery(String query) {
  final suggestions=listOfEmp.where((emp) {
    var name=emp.name;
    var input=query.toLowerCase();
    return name.contains(input);
  }).toList();
  setState(() {
    listOfEmp=suggestions;
    if(query.isEmpty){
      listOfEmp=allEmp;
    }
  });
  }
}
