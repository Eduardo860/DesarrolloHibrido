import 'dart:convert';
import 'dart:io';
import 'irest_apiclient.dart';

class APIClient<T, D> implements IRestAPIClient<T, D> {
  Future<D> _handleResponse(HttpClientResponse response) async {
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}: $body');
    }
    if (body.isEmpty) return (null as dynamic);
    return jsonDecode(body) as D;
  }

  void setHeaders(HttpClientRequest request, Map<String, String>? headers) {
    request.headers.contentType = ContentType.json;
    headers?.forEach(request.headers.add);
  }

  @override
  Future<D> get(String url, {Map<String, String>? headers}) async {
    final client = HttpClient();
    final req = await client.getUrl(Uri.parse(url));
    setHeaders(req, headers);
    final res = await req.close();
    return _handleResponse(res);
  }

  @override
  Future<D> post(String url, T data, {Map<String, String>? headers}) async {
    final client = HttpClient();
    final req = await client.postUrl(Uri.parse(url));
    setHeaders(req, headers);
    req.write(jsonEncode(data));
    final res = await req.close();
    return _handleResponse(res);
  }

  @override
  Future<D> put(String url, T data, {Map<String, String>? headers}) async {
    final client = HttpClient();
    final req = await client.putUrl(Uri.parse(url));
    setHeaders(req, headers);
    req.write(jsonEncode(data));
    final res = await req.close();
    return _handleResponse(res);
  }

  @override
  Future<D> delete(String url, {Map<String, String>? headers}) async {
    final client = HttpClient();
    final req = await client.deleteUrl(Uri.parse(url));
    setHeaders(req, headers);
    final res = await req.close();
    return _handleResponse(res);
  }
}
