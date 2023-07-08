/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:mockito/mockito.dart';
import 'package:tiki_trail/tiki_trail.dart';

import 'mock_tiki_trail_payable.dart';

class MockTikiTrailReceipt extends Mock implements Receipt {
  static final ReceiptRecord dummy =
      ReceiptRecord("", MockTikiTrailPayable.dummy, "");

  @override
  Future<ReceiptRecord> create(PayableRecord? payable, String? amount,
          {String? description, String? reference}) =>
      super.noSuchMethod(
          Invocation.method(#create, [
            payable,
            amount
          ], {
            const Symbol("description"): description,
            const Symbol("reference"): reference,
          }),
          returnValue: Future.value(dummy));

  @override
  List<ReceiptRecord> all(PayableRecord? payable) =>
      super.noSuchMethod(Invocation.method(#create, [payable]),
          returnValue: [dummy]);
}
