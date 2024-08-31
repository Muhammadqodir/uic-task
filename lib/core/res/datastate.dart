class DataState<T> {
  T? data;
  bool isSuccess;
  String? message;
  Exception? error;
  DataState({
    required this.isSuccess,
    this.message,
    this.data,
    this.error,
  });

  DataState.success({required this.data, this.isSuccess = true});
  DataState.error({this.isSuccess = false, required this.message, this.error});
}
