import 'package:flutter/material.dart';
import 'package:project_login/modal/items.dart';
import 'package:project_login/widget/card_body_widget.dart';
import 'package:project_login/widget/card_modal_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DataItems>items = [];
  void _handleAddTask(String name){
    final newItem = DataItems(id: DateTime.now().toString(), name: name);
   setState(() {
     items.add(newItem);
   });

  }
  void _hadleDeleteTask(String id){
   setState(() {
     items.removeWhere((item) => item.id == id);
   });
  }
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'quyen',
          style: TextStyle(fontSize: 40) ,
        ),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: items.map((item) =>  CardBody(item: item,hadleDelete:_hadleDeleteTask)).toList(),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.grey[400],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext content){
              return ModalBottom(addTask:_handleAddTask);
            }
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}



