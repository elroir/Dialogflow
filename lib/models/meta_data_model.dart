// To parse this JSON data, do
//
//     final metaDataModel = metaDataModelFromJson(jsonString);

import 'dart:convert';

MetaDataModel metaDataModelFromJson(String str) => MetaDataModel.fromJson(json.decode(str));

String metaDataModelToJson(MetaDataModel data) => json.encode(data.toJson());

class MetaDataModel {
  Metadata metadata;

  MetaDataModel({
    this.metadata,
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) => MetaDataModel(
    metadata: Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "metadata": metadata.toJson(),
  };
}

class Metadata {
  String intentId;
  String intentName;
  String webhookUsed;
  String webhookForSlotFillingUsed;
  String isFallbackIntent;

  Metadata({
    this.intentId,
    this.intentName,
    this.webhookUsed,
    this.webhookForSlotFillingUsed,
    this.isFallbackIntent,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    intentId: json["intentId"],
    intentName: json["intentName"],
    webhookUsed: json["webhookUsed"],
    webhookForSlotFillingUsed: json["webhookForSlotFillingUsed"],
    isFallbackIntent: json["isFallbackIntent"],
  );

  Map<String, dynamic> toJson() => {
    "intentId": intentId,
    "intentName": intentName,
    "webhookUsed": webhookUsed,
    "webhookForSlotFillingUsed": webhookForSlotFillingUsed,
    "isFallbackIntent": isFallbackIntent,
  };
}
