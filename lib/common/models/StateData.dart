class StateData<T> {
  final bool isProcessing;
  final T? data;
  StateData({this.data, this.isProcessing = false});
}