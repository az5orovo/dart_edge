import 'dart:js_util' as js_util;
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:edge/runtime/interop/promise_interop.dart';

import 'environment_interop.dart' as interop;

@anonymous
@JS()
@staticInterop
class DurableObject {
  external factory DurableObject();
}

extension PropsDurableObject on DurableObject {
  Function get init => js_util.getProperty(this, 'init');
  set init(Function init) {
    js_util.setProperty(this, 'init', init);
  }

  DurableObjectState get state => js_util.getProperty(this, 'state');
  set state(DurableObjectState state) {
    js_util.setProperty(this, 'state', state);
  }

  interop.Environment get env => js_util.getProperty(this, 'env');
  set env(interop.Environment env) {
    js_util.setProperty(this, 'env', env);
  }

  set fetch(
      Promise<interop.Response> Function(interop.Request request) function) {
    js_util.setProperty(this, 'fetch', function);
  }

  Promise<interop.Response> Function(interop.Request request) get fetch =>
      js_util.getProperty(this, 'fetch');

  Promise<void> Function() get alarm => js_util.getProperty(this, 'alarm');
  set alarm(Promise<void> Function() function) {
    js_util.setProperty(this, 'alarm', function);
  }
}

@anonymous
@JS()
@staticInterop
class DurableObjectStorage {
  external factory DurableObjectStorage();
}

extension PropsDurableObjectStorage on DurableObjectStorage {
  Future<dynamic> get(/* String | List<String> */ dynamic keys,
      DurableObjectGetOptions options) async {
    return js_util.promiseToFuture(
      js_util.callMethod(this, 'get', [keys, options]),
    );
  }

  Future<dynamic> put(
      String key, dynamic value, DurableObjectPutOptions options) {
    var newValue = value;
    if (value is Map || value is Iterable) {
      newValue = jsify(value);
    }
    return js_util.promiseToFuture(
        js_util.callMethod(this, 'put', [key, newValue, options]));
  }

  Future<void> putEntries<T>(
          Map<Object, T> entries, DurableObjectPutOptions options) =>
      js_util.promiseToFuture(
          js_util.callMethod(this, 'put', [jsify(entries), options]));

  Future<bool> delete<T>(String key, DurableObjectPutOptions options) => js_util
      .promiseToFuture(js_util.callMethod(this, 'delete', [key, options]));

  Future<void> deleteAll(DurableObjectPutOptions options) =>
      js_util.promiseToFuture(js_util.callMethod(this, 'deleteAll', [options]));

  Future<bool> deleteEntries<T>(Iterable<String> keys,
          [DurableObjectPutOptions? options]) =>
      js_util
          .promiseToFuture(js_util.callMethod(this, 'delete', [keys, options]));

  Future<Map<Object, T>> list<T>([DurableObjectListOptions? options]) =>
      js_util.promiseToFuture(js_util.callMethod(this, 'list', [options]));

  Future<int?> getAlarm([DurableObjectGetAlarmOptions? options]) =>
      js_util.promiseToFuture(js_util.callMethod(this, 'getAlarm', [options]));

  Future<void> setAlarm(DateTime scheduled,
          [DurableObjectSetAlarmOptions? options]) =>
      js_util.promiseToFuture(js_util.callMethod(this, 'setAlarm', [
        scheduled.millisecondsSinceEpoch,
        options,
      ]));

  Future<void> deleteAlarm([DurableObjectSetAlarmOptions? options]) =>
      js_util.promiseToFuture(js_util.callMethod(this, 'deleteAlarm', [
        options,
      ]));

  Future<void> sync() =>
      js_util.promiseToFuture(js_util.callMethod(this, 'sync', []));

  Future<void> transaction(
      Future<void> Function(DurableObjectTransaction tsx) callback) {
    return js_util.promiseToFuture(
      js_util.callMethod(this, 'transaction', [
        allowInterop((tsx) async {
          await callback(tsx);
        })
      ]),
    );
  }
}

@anonymous
@JS()
@staticInterop
class DurableObjectGetOptions {
  external factory DurableObjectGetOptions({
    bool? allowConcurrency,
    bool? noCache,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectGetAlarmOptions {
  external factory DurableObjectGetAlarmOptions({
    bool? allowConcurrency,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectSetAlarmOptions {
  external factory DurableObjectSetAlarmOptions({
    bool? allowConcurrency,
    bool? allowUnconfirmed,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectPutOptions {
  external factory DurableObjectPutOptions({
    bool? allowConcurrency,
    bool? allowUnconfirmed,
    bool? noCache,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectListOptions {
  external factory DurableObjectListOptions({
    String? start,
    String? startAfter,
    String? end,
    String? prefix,
    bool? reverse,
    bool? limit,
    bool? allowConcurrency,
    bool? noCache,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectNamespaceNewUniqueIdOptions {
  external factory DurableObjectNamespaceNewUniqueIdOptions({
    String? jurisdiction,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectState {
  external factory DurableObjectState();
}

extension PropsDurableObjectState on DurableObjectState {
  DurableObjectId get id => js_util.getProperty(this, 'id');

  DurableObjectStorage get storage => js_util.getProperty(this, 'storage');

  void waitUntil(Future<void> f) =>
      js_util.callMethod(this, 'waitUntil', [futureToPromise(f)]);

  Future<T> blockConcurrencyWhile<T>(Future<T> Function() callback) {
    return js_util.promiseToFuture(
      js_util.callMethod(
        this,
        'blockConcurrencyWhile',
        [allowInterop(callback)],
      ),
    );
  }
}

@anonymous
@JS()
@staticInterop
class DurableObjectNamespace {
  external factory DurableObjectNamespace();
}

extension PropsDurableObjectNamespace on DurableObjectNamespace {
  DurableObjectId newUniqueId(
          [DurableObjectNamespaceNewUniqueIdOptions? options]) =>
      js_util.callMethod(this, 'newUniqueId', [options]);
  DurableObjectId idFromName(String name) =>
      js_util.callMethod(this, 'idFromName', [name]);
  DurableObjectId idFromString(String id) =>
      js_util.callMethod(this, 'idFromString', [id]);
  DurableObjectStub get(DurableObjectId id) =>
      js_util.callMethod(this, 'get', [id]);
}

@anonymous
@JS()
@staticInterop
class DurableObjectId {
  external factory DurableObjectId();
}

extension PropsDurableObjectId on DurableObjectId {
  String get name => js_util.getProperty(this, 'name');
  bool equals(DurableObjectId other) =>
      js_util.callMethod(this, 'equals', [other]);
  String mToString() => js_util.callMethod(this, 'toString', []);
}

@anonymous
@JS()
@staticInterop
class Fetcher {
  external factory Fetcher();
}

extension PropsFetcher on Fetcher {
  // TODO RequestInit<RequestInitCfProperties>
  Future<interop.Response> fetch(interop.Request resource,
          [interop.RequestInit? init]) =>
      js_util
          .promiseToFuture(js_util.callMethod(this, 'fetch', [resource, init]));

  Socket connect(String address, [SocketOptions? options]) =>
      js_util.callMethod(this, 'connect', [address, options]);
}

@anonymous
@JS()
@staticInterop
class Socket {
  external factory Socket();
}

extension PropsSocket on Socket {
  Future<interop.ReadableStream> get readable =>
      js_util.getProperty(this, 'readable');
  Future<interop.ReadableStream> get writable =>
      js_util.getProperty(this, 'writable');
  Future<bool> get closed => js_util.getProperty(this, 'closed');
  Future<void> close() => js_util.callMethod(this, 'close', []);
}

@anonymous
@JS()
@staticInterop
class SocketOptions {
  external factory SocketOptions({bool tsl});
}

extension PropsSocketOptions on SocketOptions {
  bool get tsl => js_util.getProperty(this, 'tsl');
  set tsl(bool newValue) {
    js_util.setProperty(this, 'tsl', newValue);
  }
}

@anonymous
@JS()
@staticInterop
class DurableObjectStub extends Fetcher {
  external factory DurableObjectStub();
}

extension PropsDurableObjectStub on DurableObjectStub {
  DurableObjectId get id => js_util.getProperty(this, 'id');
  String get name => js_util.getProperty(this, 'name');
}

@anonymous
@JS()
@staticInterop
class DurableObjectTransaction extends DurableObjectStorage {
  external factory DurableObjectTransaction();
}

extension PropsDurableObjectTransaction on DurableObjectTransaction {
  void rollback() => js_util.callMethod(this, 'rollback', []);
}
