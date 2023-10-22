// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightResponse _$LightResponseFromJson(Map<String, dynamic> json) =>
    LightResponse(
      ison: json['ison'] as bool,
      source: json['source'] as String,
      hasTimer: json['has_timer'] as bool,
      timerStarted: json['timer_started'] as int,
      timerDuration: json['timer_duration'] as int,
      timerRemaining: json['timer_remaining'] as int,
      mode: json['mode'] as String,
      red: json['red'] as int,
      green: json['green'] as int,
      blue: json['blue'] as int,
      white: json['white'] as int,
      gain: json['gain'] as int,
      temp: json['temp'] as int,
      brightness: json['brightness'] as int,
      effect: json['effect'] as int,
    );

Map<String, dynamic> _$LightResponseToJson(LightResponse instance) =>
    <String, dynamic>{
      'ison': instance.ison,
      'source': instance.source,
      'has_timer': instance.hasTimer,
      'timer_started': instance.timerStarted,
      'timer_duration': instance.timerDuration,
      'timer_remaining': instance.timerRemaining,
      'mode': instance.mode,
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'white': instance.white,
      'gain': instance.gain,
      'temp': instance.temp,
      'brightness': instance.brightness,
      'effect': instance.effect,
    };
