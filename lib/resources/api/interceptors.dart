import 'package:http_interceptor/http_interceptor.dart';

class GeneralInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    //Modify data
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    //Modify data
    return data;
  }
}
