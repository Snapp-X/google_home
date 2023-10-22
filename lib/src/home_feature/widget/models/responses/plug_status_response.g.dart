// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plug_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlugStatusResponse _$PlugStatusResponseFromJson(Map<String, dynamic> json) =>
    PlugStatusResponse(
      relays: (json['relays'] as List<dynamic>)
          .map((e) => RelayResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      meters: (json['meters'] as List<dynamic>)
          .map((e) => MeterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: (json['temperature'] as num).toDouble(),
      overtemperature: json['overtemperature'] as bool,
    );

Map<String, dynamic> _$PlugStatusResponseToJson(PlugStatusResponse instance) =>
    <String, dynamic>{
      'relays': instance.relays,
      'meters': instance.meters,
      'temperature': instance.temperature,
      'overtemperature': instance.overtemperature,
    };
