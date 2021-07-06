enum HttpMethod { GET, POST, DELETE }

/// 基础请求

abstract class BaseRequest {
  var pathParams;
  var userHttps = true;
  String authority() {
    return "api.devip.org";
  }

  HttpMethod httpMethod();
  bool needLogin();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      pathStr = path().endsWith('/')
          ? '${path()}$pathParams'
          : '${path()}/$pathParams';
    }
    // http和https切换
    uri = userHttps
        ? Uri.https(authority(), pathStr, params)
        : Uri.http(authority(), pathStr, params);
    print('uri:${uri.toString()}');
    return uri.toString();
  }

  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();

  /// 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
