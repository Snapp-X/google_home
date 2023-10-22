// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeterResponse _$MeterResponseFromJson(Map<String, dynamic> json) =>
    MeterResponse(
      power: (json['power'] as num).toDouble(),
      isValid: json['is_valid'] as bool,
      timestamp: json['timestamp'] as int,
      counters: (json['counters'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      total: json['total'] as int,
    );

Map<String, dynamic> _$MeterResponseToJson(MeterResponse instance) =>
    <String, dynamic>{
      'power': instance.power,
      'is_valid': instance.isValid,
      'timestamp': instance.timestamp,
      'counters': instance.counters,
      'total': instance.total,
    };
