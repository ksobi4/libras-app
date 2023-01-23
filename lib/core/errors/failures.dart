abstract class Failure {
  String message;
  Failure({
    required this.message,
  });
}

//  General failures
class ServerFailure extends Failure {
  ServerFailure({
    String message = 'a',
  }) : super(message: message);
}

// @freezed
// abstract class ServerFailure with _$ServerFailure{
//   const factory ServerFailure.() = _ServerFailure;
// }

class CacheFailure extends Failure {
  CacheFailure({
    String message = '',
  }) : super(message: message);
}
