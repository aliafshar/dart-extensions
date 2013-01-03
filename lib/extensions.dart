// Copyright 2012, Google Inc
// Author: Ali Afshar


library extensions;

/**
 * The function type of a plugin.
 */
typedef Future Extension(dynamic pluggable);


/**
 * An extension loader that collects extensions and waits on their loading.
 *
 * You can inherit this if you want, but I'd rather compose it.
 */
class Extensible {

  /**
   * The instance being extended, will be passed to all extensions.
   */
  final dynamic pluggable;

  /**
   * The list of futures that this loader will wait on.
   */
  final List<Future> waitingFor = <Future>[];

  /**
   * Create a new extension loader for the given pluggable.
   */
  Extensible([this.pluggable]);

  /**
   * Load an extension.
   */
  Future extend(Extension plugin) {
    Future f = plugin(pluggable != null ? pluggable : this);
    if (f != null) {
      waitingFor.add(f);
    }
    return f;
  }

  /**
   * Wait for all the extensions to load.
   */
  Future start() {
    return Futures.wait(waitingFor);
  }

}