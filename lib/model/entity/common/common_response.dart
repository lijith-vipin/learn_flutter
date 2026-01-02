import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CommonResponse<T> {
  final String status;
  final T result;

  CommonResponse({required this.status, required this.result});

  factory CommonResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CommonResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class EmptyResponse {
  EmptyResponse();

  factory EmptyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);
}
