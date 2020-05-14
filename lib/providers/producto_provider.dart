
import 'package:firebase_database/firebase_database.dart';

class ProductoProvider {
 String nombreNodo = "Productos";
 FirebaseDatabase database = FirebaseDatabase.instance;
 DatabaseReference _databaseReference;
 Map map;

 ProductoProvider(this.map);

  addProduct(){
    _databaseReference = database.reference().child(nombreNodo);
    _databaseReference.push().set(map);
  }
}