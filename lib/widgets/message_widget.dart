import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {

  final Function onPressedMic; // es el metodo para el boton del micropfono
  final Function onPressedEnviar; //metodo para el boton de enviar
  final Color colorMicrofono; //color del icono del mic
  final String ayuda; //el hint del text field
  final TextEditingController textController; //el controlador para el text field

  MessageWidget({@required this.onPressedMic,
                 @required this.onPressedEnviar,
                 this.colorMicrofono,
                 this.ayuda,
                 this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: ayuda!=null ? ayuda : 'Escriba algo..' ,
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: onPressedEnviar,
                  ),

                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: colorMicrofono != null ? colorMicrofono : Theme.of(context).primaryColor, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                Icons.keyboard_voice,
                color: Colors.white,
              ),
              onTap: onPressedMic
            ),
          )
        ],
      ),
    );
  }
}
