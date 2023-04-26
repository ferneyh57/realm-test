import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:test_realm/data/simple_test.dart';
import 'package:test_realm/model/dog.dart';

class DogListScreen extends StatefulWidget {
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  List<Dog> _dogs = []; // Lista de perros para mostrar en el ListView

  @override
  void initState() {
    super.initState();
    _loadDogs(); // Cargamos los perros desde la base de datos
  }

  Future<void> _loadDogs() async {
    final dogs = realmInstance.onGetAll().toList();
    setState(() {
      _dogs = dogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          realmInstance.onAdd();

          _loadDogs();
        },
      ),
      appBar: AppBar(
        title: Text('Lista de perros'),
      ),
      body: ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          // Creamos un ListTile para cada perro en la lista
          var dog = _dogs[index];
          return ListTile(
              title: Text(dog.name),
              subtitle: Text('Edad: ${dog.age}'),
              trailing: IconButton(
                onPressed: () {
                  realmInstance.onDelete(dog);
                  _loadDogs();
                },
                icon: Icon(Icons.delete),
              ));
        },
      ),
    );
  }
}
