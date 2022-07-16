import 'package:mailer/mailer.dart';

class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException(
      {required this.message, required this.prefix, required this.url});
}

class BadRequestException extends AppException {
  BadRequestException({String? message, String? url})
      : super(message: message!, prefix: "Bad Request", url: url!);
}

class FetchDataException extends AppException {
  FetchDataException({String? message, String? url})
      : super(message: message!, prefix: "Unable to Process Data", url: url!);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException({String? message, String? url})
      : super(
            message: message!,
            prefix: "Api Not Responding Exception",
            url: url!);
}

class UnAutthorizedException extends AppException {
  UnAutthorizedException({message, String? url})
      : super(message: message!, prefix: "UnAuthorized request", url: url!);
}

class DataDeletedException extends AppException {
  DataDeletedException({String? message, String? url})
      : super(message: message!, prefix: "Data Deleted", url: url!);
}
