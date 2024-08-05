import 'package:flutter/cupertino.dart';

abstract class Failure implements Exception {
  final String errorMessage;

  Failure({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
  }
}

class GetFailureMovies extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetFailureMovies({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureMovies',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}

class GetFailureMovieDetails extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetFailureMovieDetails({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureMovieDetails',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}

class UnknownError extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  UnknownError({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'Unknown Error',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
