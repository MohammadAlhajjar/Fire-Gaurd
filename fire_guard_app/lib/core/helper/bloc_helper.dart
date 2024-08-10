import '../error/fauilers.dart';

class FailureHelper{
  static String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case OfflineFailure _:
      return 'Please check your internet connection....';
    case ServerFailure _:
      return 'Please check your credentials....';
    default:
      return 'Server problem, Please try again later....';
  }
}
}