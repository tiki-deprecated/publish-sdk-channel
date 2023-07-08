/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:mockito/mockito.dart';
import 'package:tiki_trail/tiki_trail.dart';

class MockTikiTrailTitle extends Mock implements Title {
  @override
  Future<TitleRecord> create(String ptr,
          {String? origin, List<TitleTag>? tags, String? description}) =>
      super.noSuchMethod(
          Invocation.method(#create, [
            ptr
          ], {
            const Symbol("origin"): origin,
            const Symbol("tags"): tags,
            const Symbol("description"): description,
          }),
          returnValue: Future.value(TitleRecord("mockme", "mockme")));
}
