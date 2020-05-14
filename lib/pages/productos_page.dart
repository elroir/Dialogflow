import 'dart:async';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:dialogflowtopicos/models/product_model.dart';

import 'input_page.dart';


class ProductoPage extends StatefulWidget {
  final dibujador;
  ProductoPage({@required this.dibujador});
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  List<ProductModel> _productList;
  final _estilo =new TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Query _query;

  StreamSubscription<Event> _onAddedSubscription;
  StreamSubscription<Event> _onChangedSubscription;
  @override
  void initState() {
    super.initState();
    _productList = new List();
    _query = _database
        .reference().child("Productos");
    _onAddedSubscription = _query.onChildAdded.listen(onEntryAdded);
    _onChangedSubscription = _query.onChildChanged.listen(onEntryChanged);
    _onChangedSubscription = _query.onChildRemoved.listen(onEntryDeleted);
  }
  onEntryAdded(Event event) {
    setState(() {
      _productList.add(ProductModel.fromSnapshot(event.snapshot));
    });
  }

  onEntryDeleted(Event event) {

      var deleted = _productList.singleWhere((entry){
        return entry.key == event.snapshot.key;
      });

      setState(() {
        _productList.removeAt(_productList.indexOf(deleted));
      });

  }

  onEntryChanged(Event event) {
    var oldEntry = _productList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _productList[_productList.indexOf(oldEntry)] = ProductModel.fromSnapshot(event.snapshot);
    });
  }

  @override
  void dispose() {
    _onAddedSubscription.cancel();
    _onChangedSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:(widget.dibujador) ? Text('Productos en oferta') : Text('Productos'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.add,color: Colors.white,),
            onPressed: (){
              final route = MaterialPageRoute(
                  builder: (context) {
                    return InputPage();
                  }
              );
              Navigator.push(context, route);
            },

          ),

        ],
      ),
      body: _showList(),
    );
  }


  Widget _showList() {

    if (_productList.length > 0) {
      List<ProductModel> aDibujar = new List();
      if (widget.dibujador){
        _productList.forEach((i){
          if (i.promocion)
            aDibujar.add(i);
        });
      }else{
        aDibujar = _productList;
      }

      return ListView.builder(
          shrinkWrap: true,
          itemCount: aDibujar.length,
          itemBuilder: (BuildContext context, int index) {
            String descripcion = aDibujar[index].descripcion;
            double cantidad = aDibujar[index].cantidad;
            double precio = aDibujar[index].precio;
            int codigo = aDibujar[index].codigo;
            return Card(
                elevation: 2.0,
                margin:EdgeInsets.fromLTRB(15.0,5.0, 15.0, 5.0) ,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.photo_album, color: Colors.blue,),
                      title: Text('$descripcion',style: _estilo,textAlign: TextAlign.start),
                      subtitle: Text('Codigo: $codigo'+'\n''Cantidad: $cantidad'+'\n'+'Precio: $precio',style:TextStyle(fontSize: 16)),
                      trailing: Icon(Icons.edit,color: Colors.grey,),
                      onTap: (){},
                    ),
                  ],
                ),

              );

          });
    } else {
      return Center( child: CircularProgressIndicator(),);
    }
  }

}