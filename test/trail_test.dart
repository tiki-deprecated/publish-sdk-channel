/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tiki_sdk_native/src/rsp_handler.dart';
import 'package:tiki_sdk_native/src/trail/trail_handler.dart';
import 'package:tiki_sdk_native/src/trail/trail_wrapper.dart';
import 'package:tiki_trail/tiki_trail.dart';
import 'package:uuid/uuid.dart';

import 'fixtures/mc_fixture.dart' as mc_fixture;
import 'mocks/mock_tiki_trail.dart';

void main() {
  group('handler', () {
    MockTikiTrail trail = MockTikiTrail();
    TrailHandler handler = TrailHandler(
        TrailWrapper(trail: trail), RspHandler(mc_fixture.channel));

    setUp(() {
      mc_fixture.throwOnError();
    });

    test('isInitialized', () async {
      Map req = mc_fixture.request();
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["isInitialized"], true);
      });
      await handler
          .handler(MethodCall("com.mytiki.sdk.trail.isInitialized", req));
    });

    test('address', () async {
      String address = const Uuid().v4();
      Map req = mc_fixture.request();
      when(trail.address).thenReturn(address);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["address"], address);
      });
      await handler.handler(MethodCall("com.mytiki.sdk.trail.address", req));
    });

    test('id', () async {
      String id = const Uuid().v4();
      Map req = mc_fixture.request();
      when(trail.id).thenReturn(id);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
      });
      await handler.handler(MethodCall("com.mytiki.sdk.trail.id", req));
    });

    test('guard', () async {
      String ptr = const Uuid().v4();
      Map req = mc_fixture.request(body: {"ptr": ptr, "usecases": []});
      when(trail.guard(ptr, any,
              onPass: anyNamed("onPass"), onFail: anyNamed("onFail")))
          .thenAnswer((real) {
        Function onPass = real.namedArguments[const Symbol("onPass")];
        onPass();
        return true;
      });
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["success"], true);
      });
      await handler.handler(MethodCall("com.mytiki.sdk.trail.guard", req));
    });

    test('title.create', () async {
      String id = const Uuid().v4();
      String ptr = const Uuid().v4();
      Map req = mc_fixture.request(body: {"ptr": ptr});
      when(trail.title.create(ptr, tags: anyNamed("tags"))).thenAnswer((_) {
        return Future.value(TitleRecord(id, ptr));
      });
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["hashedPtr"], ptr);
      });
      await handler
          .handler(MethodCall("com.mytiki.sdk.trail.title.create", req));
    });
  });
}
