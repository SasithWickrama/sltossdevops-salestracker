class GenaralResponce {
  final bool error;
  var data;
  final String message;

  GenaralResponce({this.error = true, this.data = null, this.message = ''});

  bool getError() => this.error;

  String getMsg() => this.message;

  getData() => this.data;
}
