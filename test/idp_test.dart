/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tiki_idp/tiki_idp.dart';
import 'package:tiki_sdk_platform_channel/src/idp/idp_handler.dart';
import 'package:tiki_sdk_platform_channel/src/idp/idp_wrapper.dart';
import 'package:tiki_sdk_platform_channel/src/rsp_handler.dart';
import 'package:uuid/uuid.dart';

import 'fixtures/mc_fixture.dart' as mc_fixture;
import 'mocks/shared_mocks.mocks.dart';

void main() {
  group('handler', () {
    TikiIdp idp = MockTikiIdp();
    IdpHandler handler =
        IdpHandler(IdpWrapper(idp: idp), RspHandler(mc_fixture.channel));

    setUp(() {
      mc_fixture.throwOnError();
    });

    test('isInitialized', () async {
      Map req = mc_fixture.request();
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
        expect(rsp["isInitialized"], true);
      });
      await handler
          .handler(MethodCall("com.mytiki.sdk.idp.isInitialized", req));
    });

    test('key', () async {
      String keyId = const Uuid().v4();
      Map req = mc_fixture.request(body: {"keyId": keyId});
      when(idp.key(keyId)).thenAnswer((_) => Future.value());
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.key", req));
    });

    test('export', () async {
      String keyId = const Uuid().v4();
      String key = const Uuid().v4();
      Map req = mc_fixture.request(body: {"keyId": keyId, "public": true});
      when(idp.export(keyId, public: true))
          .thenAnswer((_) => Future.value(key));
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
        expect(rsp["key"], key);
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.export", req));
    });

    test('import', () async {
      String keyId = const Uuid().v4();
      String key = const Uuid().v4();
      Map req = mc_fixture
          .request(body: {"keyId": keyId, "key": key, "public": false});
      when(idp.import(keyId, key, public: false))
          .thenAnswer((_) => Future.value());
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.import", req));
    });

    test('sign', () async {
      String keyId = const Uuid().v4();
      Uint8List message = Uint8List.fromList(utf8.encode(const Uuid().v4()));
      Uint8List signature = Uint8List.fromList(utf8.encode(const Uuid().v4()));
      Map req = mc_fixture
          .request(body: {"keyId": keyId, "message": base64.encode(message)});
      when(idp.sign(keyId, message)).thenAnswer((_) => Future.value(signature));
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
        expect(rsp["signature"], base64.encode(signature));
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.sign", req));
    });

    test('verify', () async {
      String keyId = const Uuid().v4();
      Uint8List message = Uint8List.fromList(utf8.encode(const Uuid().v4()));
      Uint8List signature = Uint8List.fromList(utf8.encode(const Uuid().v4()));
      Map req = mc_fixture.request(body: {
        "keyId": keyId,
        "message": base64.encode(message),
        "signature": base64.encode(signature)
      });
      when(idp.verify(keyId, message, signature))
          .thenAnswer((_) => Future.value(true));
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
        expect(rsp["isVerified"], true);
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.verify", req));
    });

    test('token', () async {
      String accessToken = const Uuid().v4();
      String tokenType = "Bearer";
      DateTime expires = DateTime.now();
      String refreshToken = const Uuid().v4();
      List<String> scope = List.of([const Uuid().v4()]);

      Map req = mc_fixture.request();
      when(idp.token).thenAnswer((_) => Future.value(JWT(
          accessToken, tokenType, expires,
          refreshToken: refreshToken, scope: scope)));
      mc_fixture.expect((rsp) {
        expect(rsp["request_id"], mc_fixture.requestId(req));
        expect(rsp["accessToken"], accessToken);
        expect(rsp["tokenType"], tokenType);
        expect(rsp["expires"], expires.millisecondsSinceEpoch);
        expect(rsp["refreshToken"], refreshToken);
        List scopeList = rsp["scope"] as List;
        for (String scp in scope) {
          expect(scopeList.contains(scp), true);
        }
      });
      await handler.handler(MethodCall("com.mytiki.sdk.idp.token", req));
    });

    test('no_handler', () async {
      Map req = mc_fixture.request();
      expect(
          () async => await handler.handler(
              MethodCall("com.mytiki.sdk.idp.${const Uuid().v4()}", req)),
          throwsA(isA<TestFailure>()));
    });
  });
}
