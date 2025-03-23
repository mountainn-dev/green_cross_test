sealed class UiState {}

class Success extends UiState {
  final dynamic data;
  Success({required this.data});
}

class Error extends UiState {
  final String message;
  Error({required this.message});
}