import 'package:firebase_database/firebase_database.dart';

class ProductModel{
  String key;
  double cantidad;
  int codigo;
  String descripcion;
  double precio;
  bool promocion;


  ProductModel(this.cantidad, this.codigo, this.descripcion, this.precio,this.promocion);

  ProductModel.fromSnapshot(DataSnapshot snapshot) :
        key         = snapshot.key,
        codigo      = snapshot.value["codigo"],
        cantidad    =  snapshot.value["cantidad"].toDouble(),
        descripcion = snapshot.value["descripcion"],
        precio      = snapshot.value["precio"].toDouble(),
        promocion   = snapshot.value["promocion"];
  Map toMap() {
    return {
      "codigo"      : codigo,
      "cantidad"    : cantidad,
      "descripcion" : descripcion,
      "precio"      : precio,
      "promocion"   : promocion
    };
  }

}

