/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tiki_idp/tiki_idp.dart';
import 'package:tiki_sdk_native/src/channel.dart';
import 'package:tiki_sdk_native/src/idp/key_flutter.dart';
import 'package:tiki_sdk_native/src/rsp_handler.dart';
import 'package:tiki_sdk_native/src/trail/rsp/rsp_initialized.dart';
import 'package:uuid/uuid.dart';

import 'fixtures/mc_fixture.dart' as mc_fixture;
import 'mocks/mock_gen.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MockIdpWrapper idp = MockIdpWrapper();
  MockTrailWrapper trail = MockTrailWrapper();
  RspHandler rsp = RspHandler(mc_fixture.channel);
  Channel channel = Channel(idp: idp, trail: trail, rsp: rsp);

  group('handler', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('initialize', () async {
      String id = const Uuid().v4();
      String publishingId = const Uuid().v4();
      String origin = const Uuid().v4();
      String address = const Uuid().v4();
      TikiIdp tikiIdp = TikiIdp([], "", KeyFlutter());

      when(idp.initialize(any)).thenReturn(tikiIdp);
      when(trail.initialize(id, publishingId, origin, tikiIdp)).thenAnswer((_) {
        return Future.value(RspInitialized(id, address));
      });

      Map req = mc_fixture.request(
          body: {"publishingId": publishingId, "origin": origin, "id": id});
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["address"], address);
      });

      await channel.handler(MethodCall("com.mytiki.sdk.initialize", req));
    });

    test('no_handler', () async {
      Map req = mc_fixture.request();
      expect(
          () async => await channel
              .handler(MethodCall("com.mytiki.sdk.${const Uuid().v4()}", req)),
          throwsA(isA<TestFailure>()));
    });
  });
}
