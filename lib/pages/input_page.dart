import 'package:flutter/material.dart';
import 'package:dialogflowtopicos/models/product_model.dart';

import 'package:dialogflowtopicos/providers/producto_provider.dart';

import 'package:dialogflowtopicos/utils/widget_utils.dart' as widUtils;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _idController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _precioController = TextEditingController();
  ProductModel _productModel = ProductModel(0.0,0,'',0.0,false);

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Datos'),
          backgroundColor: Theme.of(context).primaryColor ,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0) ,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                widUtils.crearInputNumeric('Codigo','Codigo',0.0,_idController),
                Divider(),
                widUtils.crearInputString('Descripcion','Descripcion',_descripcionController),
                Divider(),
                widUtils.crearInputNumeric('Cantidad','Cantidad',0.0,_cantidadController),
                Divider(),
                widUtils.crearInputNumeric('Precio','Precio',0.0,_precioController),
                Divider(),

              ],
            ),
          ),
        ),


        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            _submit();

          },
          backgroundColor: Colors.blue,
          label: Text('Guardar'),
          icon: Icon(Icons.save),)
    );
  }
  void _submit(){
    final FormState form = formKey.currentState;
    if (form.validate()) {

      _productModel.codigo = int.parse(_idController.text);
      _productModel.descripcion = _descripcionController.text;
      _productModel.cantidad = double.parse(_cantidadController.text);
      _productModel.precio = double.parse(_precioController.text);
      ProductoProvider productoProvider = ProductoProvider(
          _productModel.toMap());
      productoProvider.addProduct();

      Navigator.pop(context);
    }

  }



}
