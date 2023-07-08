/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tiki_sdk_native/src/req.dart';
import 'package:tiki_sdk_native/src/rsp_handler.dart';
import 'package:uuid/uuid.dart';

import '../mocks/mock_gen.mocks.dart';

MethodChannel channel = MockMethodChannel();

Map request<T extends Req>({Map<String, dynamic>? body}) {
  body ??= {};
  body.putIfAbsent("requestId", () => const Uuid().v4());
  return body;
}

String requestId(Map req) => req["requestId"]!;

void throwOnError() =>
    when(channel.invokeMethod(RspHandler.errorMethod, any)).thenAnswer((real) {
      Map<String, dynamic> rsp = real.positionalArguments[1];
      throw TestFailure(rsp["message"]);
    });

void expect(void Function(Map<String, dynamic> rsp) fn) {
  when(channel.invokeMethod(RspHandler.successMethod, any)).thenAnswer((real) {
    fn(real.positionalArguments[1]);
    return Future.value();
  });
}
