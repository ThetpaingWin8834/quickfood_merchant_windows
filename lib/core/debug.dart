import 'dart:developer';

void dlog(dynamic error, {StackTrace? s}) {
  log(' $error, \n stacktrace $s');
}
