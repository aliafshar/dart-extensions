
library extensions;

typedef Future Plugin(dynamic plugable);

class Extensions {

  final dynamic plugable;
  final List<Future> futures = <Future>[];

  Extensions(this.plugable);

  Future extend(Plugin plugin) {
    Future f = plugin(plugable);
    if (f != null) futures.add(f);
    return f;
  }

  Future start() {
    return Futures.wait(futures);
  }

}