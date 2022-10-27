import '../../../locator.dart';

mixin Screen<B extends Object> {
  final bloc = locator<B>();
}
