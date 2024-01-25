class HttpException implements Exception{
  //implements forces this class to implement all the methods of Exception
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    //return super.toString(); //would yield 'Instance of HttpException
  }
}