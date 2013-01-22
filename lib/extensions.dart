// Copyright 2012, Google Inc
// Author: Ali Afshar


library extensions;

import 'dart:async';

/**
 * The function type of a plugin.
 */
typedef dynamic Extension(dynamic pluggable);


/**
 * An extension loader that collects extensions and waits on their loading.
 *
 * You can inherit this if you want, but I'd rather compose it.
 */
class Extensible {

  /**
   * The instance being extended, will be passed to all extensions.
   */
  final dynamic _pluggable;

  /**
   * The list of futures that this loader will wait on.
   */
  final List<Future> waitingFor = <Future>[];

  /**
   * Create a new extension loader for the given pluggable.
   */
  Extensible([this._pluggable]);

  /**
   * The argument passed during plugin setup.
   *
   * Either passed on instantiation, or will be this,
   */
  dynamic get pluggable => _pluggable != null ? _pluggable : this;

  /**
   * Load an extension.
   */
  dynamic extend(Extension plugin) {
    var result = plugin(pluggable);
    if (result is Future) {
      waitingFor.add(result);
    }
    return result;
  }

  /**
   * Wait for all the extensions to load.
   */
  Future start() {
    return Future.wait(waitingFor);
  }

}