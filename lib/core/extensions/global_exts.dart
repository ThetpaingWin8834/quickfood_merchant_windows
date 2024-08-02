import 'package:quick_merchant_windows/core/debug.dart';

extension ObjExts<T> on T {
  T also(void Function(T) fun) {
    fun(this);
    return this;
  }

  T apply(T Function(T) fun) {
    return fun(this);
  }

  T? handleNull(T? Function(T) fun) {
    try {
      return fun(this);
    } catch (e, s) {
      detailsLog(e, s: s);
    }
    return null;
  }
}
