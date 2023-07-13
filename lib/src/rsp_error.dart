/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'rsp.dart';

class RspError extends Rsp {
  String? message;
  StackTrace? stackTrace;

  RspError({String? requestId, this.message, this.stackTrace})
      : super(requestId);

  RspError.fromError(Error e, {String? requestId})
      : message = e.toString(),
        stackTrace = e.stackTrace,
        super(requestId);

  RspError.fromException(Exception e, {String? requestId})
      : message = e.toString(),
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "message": message,
        "stacktrace": stackTrace.toString(),
        "requestId": requestId
      };
}
