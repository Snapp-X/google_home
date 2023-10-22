// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulb_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulbStatusResponse _$BulbStatusResponseFromJson(Map<String, dynamic> json) =>
    BulbStatusResponse(
      lights: (json['lights'] as List<dynamic>)
          .map((e) => LightResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BulbStatusResponseToJson(BulbStatusResponse instance) =>
    <String, dynamic>{
      'lights': instance.lights,
    };
