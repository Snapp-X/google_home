// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelayResponse _$RelayResponseFromJson(Map<String, dynamic> json) =>
    RelayResponse(
      ison: json['ison'] as bool,
      hasTimer: json['has_timer'] as bool,
      overpower: json['overpower'] as bool,
    );

Map<String, dynamic> _$RelayResponseToJson(RelayResponse instance) =>
    <String, dynamic>{
      'ison': instance.ison,
      'has_timer': instance.hasTimer,
      'overpower': instance.overpower,
    };
