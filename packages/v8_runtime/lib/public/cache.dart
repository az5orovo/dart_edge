import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;

import '../interop/utils_interop.dart' as interop;
import 'request.dart';
import 'response.dart';
import 'resource.dart';

class Cache {
  final interop.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(Resource resource) async {
    await _delegate.add(interop.requestFromResource(resource));
  }

  Future<void> addAll(List<Resource> resources) async {
    await _delegate.addAll(resources.map(interop.requestFromResource));
  }

  Future<void> delete(
    Resource resource, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    await _delegate.delete(
      interop.requestFromResource(resource),
      interop.CacheQueryOptions(
        ignoreMethod: ignoreMethod,
        ignoreSearch: ignoreSearch,
        ignoreVary: ignoreVary,
      ),
    );
  }

  Future<Response?> match(
    Resource resource, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final deleObj = await promiseToFuture(_delegate.match(
        interop.requestFromResource(resource),
        interop.CacheQueryOptions(
          // These need conditional setting (don't set if null) otherwise errors below
          // on CF.
          ignoreMethod: ignoreMethod,
          // Error: The 'ignoreSearch' field on 'CacheQueryOptions' is not implemented.
          // ignoreSearch: ignoreSearch,
          // Error: The 'ignoreVary' field on 'CacheQueryOptions' is not implemented.
          // ignoreVary: ignoreVary,
        )));
    if (deleObj == interop.jsUndefined) {
      return null;
    }
    return deleObj == null ? null : responseFromJsObject(deleObj);
  }

  Future<Iterable<Response>> matchAll({
    Resource? resource,
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final matches = await _delegate.matchAll(
        resource == null ? null : interop.requestFromResource(resource),
        interop.CacheQueryOptions(
          ignoreMethod: ignoreMethod,
          ignoreSearch: ignoreSearch,
          ignoreVary: ignoreVary,
        ));
    return matches.map((obj) => responseFromJsObject(obj));
  }

  Future<void> put(
    Request request,
    Response response,
  ) async {
    return _delegate.put(request.delegate, response.delegate);
  }
}

Cache cacheFromJsObject(interop.Cache delegate) {
  return Cache._(delegate);
}
