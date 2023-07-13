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
  MockTikiTrail trail = MockTikiTrail();
  TrailHandler handler =
      TrailHandler(TrailWrapper(trail: trail), RspHandler(mc_fixture.channel));

  group('handler - trail', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('isInitialized', () async {
      Map req = mc_fixture.request();
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["isInitialized"], true);
      });
      await handler.handler(MethodCall("trail.isInitialized", req));
    });

    test('address', () async {
      String address = const Uuid().v4();
      Map req = mc_fixture.request();
      when(trail.address).thenReturn(address);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["address"], address);
      });
      await handler.handler(MethodCall("trail.address", req));
    });

    test('id', () async {
      String id = const Uuid().v4();
      Map req = mc_fixture.request();
      when(trail.id).thenReturn(id);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
      });
      await handler.handler(MethodCall("trail.id", req));
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
      await handler.handler(MethodCall("trail.guard", req));
    });
  });

  group('handler - title', () {
    setUp(() {
      mc_fixture.throwOnError();
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
      await handler.handler(MethodCall("trail.title.create", req));
    });

    test('title.get', () async {
      String id = const Uuid().v4();
      String ptr = const Uuid().v4();
      Map req = mc_fixture.request(body: {"ptr": ptr});
      when(trail.title.get(ptr)).thenReturn(TitleRecord(id, ptr));
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["hashedPtr"], ptr);
      });
      await handler.handler(MethodCall("trail.title.get", req));
    });

    test('title.id', () async {
      String id = const Uuid().v4();
      String ptr = const Uuid().v4();
      Map req = mc_fixture.request(body: {"id": id});
      when(trail.title.id(id)).thenReturn(TitleRecord(id, ptr));
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["hashedPtr"], ptr);
      });
      await handler.handler(MethodCall("trail.title.id", req));
    });
  });

  group('handler - license', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('license.create', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String id = const Uuid().v4();
      String terms = const Uuid().v4();
      List<LicenseUse> uses = [
        LicenseUse([LicenseUsecase.custom("test")], destinations: ["test"])
      ];

      Map req = mc_fixture.request(body: {
        "titleId": titleId,
        "uses": uses.map((use) => use.toMap()).toList(),
        "terms": terms
      });
      when(trail.license.create(any, any, any)).thenAnswer((_) {
        return Future.value(LicenseRecord(id, title, uses, terms));
      });

      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["title"]["id"], titleId);
        LicenseUse use = LicenseUse.fromMap(rsp["uses"][0]);
        expect(use.usecases[0].value, uses[0].usecases[0].value);
        expect(use.destinations?[0], uses[0].destinations?[0]);
        expect(rsp["terms"], terms);
      });
      await handler.handler(MethodCall("trail.license.create", req));
    });

    test('license.get', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());

      String id = const Uuid().v4();
      String terms = const Uuid().v4();

      Map req = mc_fixture.request(body: {"id": id});
      when(trail.license.get(id))
          .thenReturn(LicenseRecord(id, title, [], terms));

      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["title"]["id"], titleId);
        expect((rsp["uses"] as List).length, 0);
        expect(rsp["terms"], terms);
      });
      await handler.handler(MethodCall("trail.license.get", req));
    });

    test('license.all', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String id = const Uuid().v4();
      String terms = const Uuid().v4();

      Map req = mc_fixture.request(body: {"titleId": titleId});
      when(trail.license.all(any))
          .thenReturn([LicenseRecord(id, title, [], terms)]);

      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect((rsp["licenses"] as List).length, 1);
        expect(rsp["licenses"][0]["id"], id);
      });
      await handler.handler(MethodCall("trail.license.all", req));
    });
  });

  group('handler - payable', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('payable.create', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      String type = const Uuid().v4();
      Map req = mc_fixture.request(
          body: {"licenseId": licenseId, "amount": amount, "type": type});

      when(trail.payable.create(any, any, any)).thenAnswer((_) {
        return Future.value(PayableRecord(id, license, amount, type));
      });
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["license"]["id"], licenseId);
        expect(rsp["amount"], amount);
        expect(rsp["type"], type);
      });
      await handler.handler(MethodCall("trail.payable.create", req));
    });

    test('payable.get', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      String type = const Uuid().v4();
      Map req = mc_fixture.request(body: {"id": id});

      when(trail.payable.get(id))
          .thenReturn(PayableRecord(id, license, amount, type));
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["license"]["id"], licenseId);
        expect(rsp["amount"], amount);
        expect(rsp["type"], type);
      });
      await handler.handler(MethodCall("trail.payable.get", req));
    });

    test('payable.all', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      String type = const Uuid().v4();
      Map req = mc_fixture.request(body: {"licenseId": licenseId});

      when(trail.payable.all(any))
          .thenReturn([PayableRecord(id, license, amount, type)]);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect((rsp["payables"] as List).length, 1);
        expect(rsp["payables"][0]["id"], id);
      });
      await handler.handler(MethodCall("trail.payable.all", req));
    });
  });

  group('handler - receipt', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('receipt.create', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String payableId = const Uuid().v4();
      PayableRecord payable = PayableRecord(payableId, license, "", "");
      when(trail.payable.get(payableId)).thenReturn(payable);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      Map req =
          mc_fixture.request(body: {"payableId": payableId, "amount": amount});

      when(trail.receipt.create(any, any)).thenAnswer((_) {
        return Future.value(ReceiptRecord(id, payable, amount));
      });
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["payable"]["id"], payableId);
        expect(rsp["amount"], amount);
      });
      await handler.handler(MethodCall("trail.receipt.create", req));
    });

    test('receipt.get', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String payableId = const Uuid().v4();
      PayableRecord payable = PayableRecord(payableId, license, "", "");
      when(trail.payable.get(payableId)).thenReturn(payable);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      Map req = mc_fixture.request(body: {"id": id});

      when(trail.receipt.get(id))
          .thenReturn(ReceiptRecord(id, payable, amount));
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect(rsp["id"], id);
        expect(rsp["payable"]["id"], payableId);
        expect(rsp["amount"], amount);
      });
      await handler.handler(MethodCall("trail.receipt.get", req));
    });

    test('receipt.all', () async {
      String titleId = const Uuid().v4();
      TitleRecord title = TitleRecord(titleId, const Uuid().v4());
      when(trail.title.id(titleId)).thenReturn(title);

      String licenseId = const Uuid().v4();
      LicenseRecord license = LicenseRecord(licenseId, title, [], "");
      when(trail.license.get(licenseId)).thenReturn(license);

      String payableId = const Uuid().v4();
      PayableRecord payable = PayableRecord(payableId, license, "", "");
      when(trail.payable.get(payableId)).thenReturn(payable);

      String id = const Uuid().v4();
      String amount = const Uuid().v4();
      Map req = mc_fixture.request(body: {"payableId": payableId});

      when(trail.receipt.all(any))
          .thenReturn([ReceiptRecord(id, payable, amount)]);
      mc_fixture.expect((rsp) {
        expect(rsp["requestId"], mc_fixture.requestId(req));
        expect((rsp["receipts"] as List).length, 1);
        expect(rsp["receipts"][0]["id"], id);
      });
      await handler.handler(MethodCall("trail.receipt.all", req));
    });
  });

  group('handler - other', () {
    setUp(() {
      mc_fixture.throwOnError();
    });

    test('no_handler', () async {
      Map req = mc_fixture.request();
      expect(
          () async => await handler
              .handler(MethodCall("trail.${const Uuid().v4()}", req)),
          throwsA(isA<TestFailure>()));
    });
  });
}
