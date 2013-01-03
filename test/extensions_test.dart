
import 'package:unittest/unittest.dart';
import 'package:extensions/extensions.dart';

class DummyPluggable {
  int count = 0;
}


main() {

  group('Extensions', () {

    test('Create', () {
      var e = new Extensible();
      expect(e.pluggable, equals(e));
    });

    test('Create with pluggable', () {
      var p = 'Hello';
      var e = new Extensible(p);
      expect(e.pluggable, equals(p));
    });

    test('Extend', () {
      var p = new DummyPluggable();
      var e = new Extensible(p);
      e.extend((DummyPluggable a) => a.count += 1);
      expect(p.count, equals(1));
    });

    test('Extend multi', () {
      var p = new DummyPluggable();
      var e = new Extensible(p);
      e.extend((DummyPluggable a) => e.extend((DummyPluggable b) => b.count += 1));
      expect(p.count, equals(1));
    });

    test('Extend twice', () {
      var p = new DummyPluggable();
      var e = new Extensible(p);
      e.extend((DummyPluggable a) => a.count += 1);
      e.extend((DummyPluggable a) => a.count += 1);
      expect(p.count, equals(2));
    });

    test('Extend', () {
      var p = new DummyPluggable();
      var e = new Extensible(p);
      e.extend((DummyPluggable a) => a.count += 1);
      expect(p.count, equals(1));
    });

  });
}

