abstract class Result<T> {
  factory Result.success(T data) = Success;
  factory Result.error(String e) = Error;
}

class Success<T> implements Result<T> {
  final T _data;

  Success(this._data);

  T get data => _data;
}

class Error<T> implements Result<T> {
  final String _error;

  Error(this._error);

  String get message => _error;
}