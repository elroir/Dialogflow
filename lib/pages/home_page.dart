import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:dialogflowtopicos/pages/productos_page.dart';
import 'package:dialogflowtopicos/providers/dialogflow_provider.dart';
import 'package:dialogflowtopicos/providers/tts_provider.dart';
import 'package:dialogflowtopicos/widgets/message_widget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  final _speechController = TextEditingController();
  String resultText = "";
  String response = '';
  final dialogflow = new DialogflowProvider();
  ProductoPage productoPage = new ProductoPage(dibujador: true,);
  TtsProvider ttsProvider = TtsProvider();

  @override
  void initState() {
    ttsProvider.hablar('Bienvenido, ¿que deseas hacer?');
    super.initState();
    initSpeechRecognizer();
  }



  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result)
    );

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(()=> _isListening = true)
    );

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech)
    );

    _speechRecognition.setRecognitionCompleteHandler(
            () => setState((){_isListening = false;
            _speechController.text  = resultText;})
    );

    _speechRecognition.activate().then(
        (result) => setState (() => _isAvailable = result)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Dialogflow'),
      ),
        body: ListView(
         children: <Widget>[
           _principal()
      ],

      ),
    );
  }


  void _dibujarOfertas(BuildContext context){
    _getData();

    dialogflow.getIntentName(_speechController.text).then((String value){
      setState(() {

        if(value=='Promociones'){
          final route = MaterialPageRoute(
              builder: (context) {
                return productoPage;
              }
          );
          Navigator.push(context, route);

        }else if(value=='Productos'){
          final route = MaterialPageRoute(
              builder: (context) {
                return ProductoPage(dibujador: false,);
              }
          );
          Navigator.push(context, route);
        }
      });
    });

  }


  Widget _principal(){

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // _createButtons(),
          SizedBox(height: 20.0,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              children: <Widget>[
                Text(response,style: TextStyle(fontSize: 16),)
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(),
            ),
          ),
          SizedBox(height: 20.0,width: 20.0,),
          MessageWidget(

            textController: _speechController,
            onPressedMic: _speaking,
            onPressedEnviar:() => _dibujarOfertas(context),),
        ],
      ),

    );
  }
  _getData() {

    dialogflow.getBotMessage(_speechController.text).then((String value){
      setState(() {
        ttsProvider.hablar(value);
        response = value;
        resultText = '';
        _speechController.clear();
      });

    });

  }

  _speaking(){

  if(_isAvailable && !_isListening)
      _speechRecognition.listen(locale: "es_ES").then(
     (result) => resultText = result
      );
  else
    _speechRecognition.stop().then(
    (result) => setState(() => _isListening = result),
      );

  }

}
