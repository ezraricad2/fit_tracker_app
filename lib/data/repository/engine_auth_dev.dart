library engine;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker_app/app/utilities/account_helper.dart';
import 'package:fit_tracker_app/app/widget/toast.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:fit_tracker_app/data/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'account.dart';
part 'activity.dart';
part 'profile.dart';

const int kLimitPerPage = 10;
enum RequestType { get, delete, post, put }
enum TokenType {
  none,
  login,
  qiscus,
  global,
  user,
}
enum ContentType { none, json, urlEncoded, mutipart }

class APIRequest {
  static _Account account = _Account();
  static _Activity activity = _Activity();
  static _Profile profile = _Profile();

}

abstract class VmsEngine {
  String get tag;

  static int maxRetry = 10;
  static int timeOutDuration = 250000; //dipakai untuk send timeout, receive timeout dan send timeout download
  static int timeOutDownloadDuration; //dipakai untuk receive timeout download

  static String url = "";
  static String bannerImage = "/cms";
  static String profileImage = "/profile";
  static String transferReceiptImage = "/transfer";
  static String _applicationJson = "application/json";
  static String _applicationUrlEncoded = "application/x-www-form-urlencoded";
  static String _applicationMultipart = "multipart/form-data";

  static Future<Options> _getDioOptions(BuildContext context, {TokenType tokenType, String contentType}) async {
    Map<String, String> header;
    tokenType ??= TokenType.none;
    contentType ??= _applicationJson;
    switch (tokenType) {
      case TokenType.login:
        header = await _createHeaderWithTokenLogin(context, contentType: contentType);
        break;
      case TokenType.none:
        header = _createHeader(context, contentType: contentType);
        break;
      case TokenType.qiscus:
        header = await _createHeaderWithQiscusTokenLogin(context, contentType: contentType);
        break;
      case TokenType.global:
        header = await _createHeaderWithGlobalToken(context, contentType: contentType);
        break;
      case TokenType.user:
        header = await _createHeaderWithuserToken(context, contentType: contentType);
        break;
    }

    return Options(
      sendTimeout: timeOutDuration,
      receiveTimeout: timeOutDuration,
      headers: header,
      validateStatus: (statusCode) => statusCode <= 500,
//      contentType: Headers.jsonContentType,
    );
  }

  static Future<Options> _getDioDownloadOptions(BuildContext context, {TokenType tokenType, String contentType}) async {
    Map<String, String> header;
    tokenType ??= TokenType.none;
    contentType ??= _applicationJson;
    switch (tokenType) {
      case TokenType.login:
        header = await _createHeaderWithTokenLogin(context, contentType: contentType);
        break;
      case TokenType.none:
        header = _createHeader(context, contentType: contentType);
        break;
      case TokenType.qiscus:
        header = await _createHeaderWithQiscusTokenLogin(context, contentType: contentType);
        break;
      case TokenType.global:
        header = await _createHeaderWithGlobalToken(context, contentType: contentType);
        break;
      case TokenType.user:
        header = await _createHeaderWithuserToken(context, contentType: contentType);
        break;
    }

    return Options(
      sendTimeout: timeOutDuration,
      receiveTimeout: timeOutDownloadDuration,
      headers: header,
      validateStatus: (statusCode) => statusCode == 200,
//      contentType: Headers.jsonContentType,
    );
  }

  static Map<String, String> _createHeader(BuildContext context, {String contentType}) {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithTokenLogin(BuildContext context, {String contentType}) async {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithGlobalToken(BuildContext context, {String contentType}) async {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithQiscusTokenLogin(BuildContext context,
      {String contentType}) async {
   Map<String, String> header = {};

   if (contentType.isNotEmpty) {
     header.putIfAbsent("Content-Type", () => contentType);
   }

   return header;
  }

  static Future<Map<String, String>> _createHeaderWithuserToken(BuildContext context, {String contentType}) async {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    return header;
  }

  bool _handleSuccess(BuildContext context, var result) {
    if (result is Map && result["success"] != null) {
      return result["success"];
    }

    return false;
  }

  _handlePayloadData(var result) {
    if (result["payload"] != null) {
      if (result["payload"]["data"] != null) {
        return result["payload"]["data"];
      }
    } else {
      if (result["error"] != null) {
        if (result["error"]["message"] != null) {
          return null;
        } else if (result["error"]["code"] != null) {
          return null;
        }
      }
    }

    return null;
  }

  _handleData(BuildContext context, var result) {
    if (result["data"] != null) {
      return result["data"];
    } else {
      if (result["errors"] != null) {
        if (result["errors"] is List && result["errors"].length > 0) {
          return null;
        }
      }
    }

    return null;
  }

  Future<Response<dynamic>> _handleError(
    context,
    counter,
    refreshCounter,
    DioError error,
    url,
    CancelToken token,
    TokenType tokenType,
    RequestType requestType, {
    var param,
  }) async {
    print("message => ${error.message}");
    print("error => ${error.error}");
    print("type => ${error.type}");
    print("request => ${error.request}");
    print("response => ${error.response}");
    print("url => $url");


    if (error.type == DioErrorType.CONNECT_TIMEOUT || error.type == DioErrorType.RECEIVE_TIMEOUT) {
      if (counter < maxRetry) {
        counter++;
        Toast.showToast(context, "Request Timed Out ($counter)", duration: Duration(seconds: 5));

        if (requestType == RequestType.post) {
          return await _post(
            context: context,
            url: url,
            param: param,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.put) {
          return await _put(
            context: context,
            url: url,
            param: param,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.get) {
          return await _get(
            context: context,
            url: url,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.delete) {
          return await _delete(
            context: context,
            url: url,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        }
      } else {
        Toast.showToast(context, "Request timed out after attempt to connect 10 times!",
            duration: Duration(seconds: 5));

        return null;
      }
    } else {
      if (CancelToken.isCancel(error)) {
        Toast.showToast(context, "Request Canceled: ${error.message}", duration: Duration(seconds: 5));
        return null;
      } else {
        if (error.response?.statusCode != null && error.response.statusCode == 401) {
          if (error.response != null) {
            if (error.response.data is Map && (error.response.data as Map)["errors"] != null) {
              if ((error.response.data as Map)["errors"] is List) {
                List rawErrors = (error.response.data as Map)["errors"] as List;
                if (rawErrors.length > 0 &&
                    (rawErrors.first == "Invalid token!" || rawErrors.first == "Your session has been expired!")) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text('Informasi'),
                        content: new Text(
                          rawErrors.first,
                        ),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text('Tutup'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ).then((_) async {
                    /*  await AccountHelper.signOut();
                   Routing.pushAndRemoveUntil(
                       context, LoginPage(), (_) => false);*/
                  });

                  return null;
                }
              }
            }
          }
        }

        String errorMessage = error.message;

        if (error.response != null) {
          if (error.response.data is Map && (error.response.data as Map)["errors"] != null) {
            if ((error.response.data as Map)["errors"] is List) {
              List rawErrors = (error.response.data as Map)["errors"] as List;
              errorMessage = rawErrors.join("\n");
            }
          }
        }

        Toast.showToast(context, "Error: $errorMessage", duration: Duration(seconds: 5));
        return null;
      }
    }

    return null;
  }

  static Future<Response<dynamic>> _handleDownloadError(
    context,
    counter,
    refreshCounter,
    DioError error,
    url,
    savePath,
    token,
    TokenType tokenType,
  ) async {
//    logger.d("message => ${error.message}");
//    logger.d("error => ${error.error}");
//    logger.d("type => ${error.type}");
//    logger.d("request => ${error.request}");
//    logger.d("response => ${error.response}");
//    logger.d("url => $url");
//    if (error.type == DioErrorType.CONNECT_TIMEOUT ||
//        error.type == DioErrorType.RECEIVE_TIMEOUT) {
//      logger.d("compare count => $counter < $maxRetry");
//      if (counter < maxRetry) {
//        counter++;
//        Toast.showToast(context, "Request Timed Out ($counter)");
//
//        bool x = await download(
//          savePath: savePath,
//          context: context,
//          url: url,
//          lastCounter: counter,
//          refreshCounter: refreshCounter,
//          token: token,
//          tokenType: tokenType,
//        );
//
//        return Response(data: x);
//      } else {
//        Toast.showToast(
//            context, "Request timed out after attempt to connect 10 times!");
//        return Response(data: false);
//      }
//    } else {
//      if (CancelToken.isCancel(error)) {
//        Toast.showToast(context, "Request Canceled: ${error.message}");
//        return Response(data: false);
//      } else {
//        Toast.showToast(context, "Error: ${error.message}");
//        return Response(data: false);
//      }
//    }
  }

  Future _post({
    BuildContext context,
    String url,
    var param,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    ContentType contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= new CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? _applicationJson
        : contentType == ContentType.urlEncoded
            ? _applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? _applicationMultipart
                : "";

    var options = await _getDioOptions(context, tokenType: tokenType, contentType: contentTypeString);

    var result = await dio.post<dynamic>(
      url,
      data: param,
      options: options,
      cancelToken: token,
      onSendProgress: (int sent, int total) {
        print("$sent $total");
      },
    ).catchError((error) {
      print("options ${options.headers}");
      print("param $param");
      print("error lagi $error");
      return _handleError(context, counter, refreshCounter, error, url, token, tokenType, RequestType.post,
          param: param);
    });

    return result;
  }

  Future _put({
    BuildContext context,
    String url,
    var param,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    ContentType contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= new CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? _applicationJson
        : contentType == ContentType.urlEncoded
            ? _applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? _applicationMultipart
                : "";

    var options = await _getDioOptions(context, tokenType: tokenType, contentType: contentTypeString);

    // print('paramput $param');

    var result = await dio
        .put<dynamic>(
      url,
      data: param,
      options: options,
      cancelToken: token,
//      onSendProgress: (int sent, int total) {
//        print("$sent $total");
//      },
    )
        .catchError((error) {
//      logger.d("error lagi $error");
      return _handleError(context, counter, refreshCounter, error, url, token, tokenType, RequestType.put,
          param: param);
    });

    return result;
  }

  Future _get({
    BuildContext context,
    String url,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    ContentType contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= new CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? _applicationJson
        : contentType == ContentType.urlEncoded
            ? _applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? _applicationMultipart
                : "";

    var options = await _getDioOptions(context, tokenType: tokenType, contentType: contentTypeString);
    var result = await dio.get<dynamic>(url, options: options, cancelToken: token).catchError((error) async {
      DioError e = error.runtimeType == DioError ? error : DioError(error: error);
      return _handleError(
        context,
        counter,
        refreshCounter,
        e,
        url,
        token,
        tokenType,
        RequestType.get,
      );
    });

    return result;
  }

  Future _delete({
    BuildContext context,
    String url,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    ContentType contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= new CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? _applicationJson
        : contentType == ContentType.urlEncoded
            ? _applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? _applicationMultipart
                : "";

    var options = await _getDioOptions(context, tokenType: tokenType, contentType: contentTypeString);

    var result = await dio.delete<dynamic>(url, options: options, cancelToken: token).catchError((error) async {
      return _handleError(
        context,
        counter,
        refreshCounter,
        error,
        url,
        token,
        tokenType,
        RequestType.delete,
      );
    });

    return result;
  }

  static Future<bool> download({
    BuildContext context,
    @required String url,
    @required String savePath,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    ContentType contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= new CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? _applicationJson
        : contentType == ContentType.urlEncoded
            ? _applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? _applicationMultipart
                : "";

    var options = await _getDioDownloadOptions(context, tokenType: tokenType, contentType: contentTypeString);

//    Future<Response> download(
//        String urlPath,
//        savePath, {
//        ProgressCallback onReceiveProgress,
//        Map<String, dynamic> queryParameters,
//        CancelToken cancelToken,
//        bool deleteOnError = true,
//        String lengthHeader = Headers.contentLengthHeader,
//        data,
//        Options options,
//        });

    var result =
        await dio.download(url, savePath, options: options, cancelToken: token, onReceiveProgress: (rec, total) {
//      logger.d(" 1 1 Rec: $rec , Total: $total");
    }).catchError((error) async {
//      logger.d("_handleDownloadError: $error");
      return _handleDownloadError(
        context,
        counter,
        refreshCounter,
        error,
        url,
        savePath,
        token,
        tokenType,
      );
    });

    return result.data.statusCode == 200;
  }

  Future _process({
    BuildContext context,
    String url,
    var param,
    int lastCounter,
    int refreshCounter,
    CancelToken token,
    TokenType tokenType = TokenType.none,
    RequestType requestType,
    ContentType contentType,
    String processName,
  }) async {
    assert(requestType != null);
    var result;

    if (requestType == RequestType.post) {
      result = await _post(
        context: context,
        url: url,
        param: param,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.put) {
      result = await _put(
        context: context,
        url: url,
        param: param,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.get) {
      result = await _get(
        context: context,
        url: url,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.delete) {
      result = await _delete(
        context: context,
        url: url,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    }

    print("$processName from ($url) produces\n$result");

    if (result == null) return null;

    return result.data;
  }
}
