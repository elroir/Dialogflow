// To parse this JSON data, do
//
//     final fullfillmentModel = fullfillmentModelFromJson(jsonString);

import 'dart:convert';

FullfillmentModel fullfillmentModelFromJson(String str) => FullfillmentModel.fromJson(json.decode(str));

String fullfillmentModelToJson(FullfillmentModel data) => json.encode(data.toJson());

class FullfillmentModel {
  Fulfillment fulfillment;

  FullfillmentModel({
    this.fulfillment,
  });

  factory FullfillmentModel.fromJson(Map<String, dynamic> json) => FullfillmentModel(
    fulfillment: Fulfillment.fromJson(json["fulfillment"]),
  );

  Map<String, dynamic> toJson() => {
    "fulfillment": fulfillment.toJson(),
  };
}

class Fulfillment {
  String speech;
  List<Message> messages;

  Fulfillment({
    this.speech,
    this.messages,
  });

  factory Fulfillment.fromJson(Map<String, dynamic> json) => Fulfillment(
    speech: json["speech"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "speech": speech,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {
  String lang;
  int type;
  String speech;

  Message({
    this.lang,
    this.type,
    this.speech,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    lang: json["lang"],
    type: json["type"],
    speech: json["speech"],
  );

  Map<String, dynamic> toJson() => {
    "lang": lang,
    "type": type,
    "speech": speech,
  };
}
