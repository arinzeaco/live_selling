import 'package:flutter_test/flutter_test.dart';
import 'package:live_selling/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('InventoryViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
