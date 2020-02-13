class ServiceResponse<T> {
  bool ok;
  String msg;
  T result;

  ServiceResponse.ok({this.result, this.msg}){
    ok = true;
  }

  ServiceResponse.error({this.result, this.msg}){
    ok = false;
  }

}