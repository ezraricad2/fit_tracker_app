part of engine;

class _Account extends VmsEngine {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> loginUser({String email, String password}) async {

    final UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user;

  }

  Future<ResponseModel> createUser({String email, String password}) async {
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((result) {

      return ResponseModel(
          messages: result.user.uid,
          success: true
      );

    }).catchError((err) {

      return ResponseModel(
          messages: err.message.toString(),
          success: false
      );

    });
  }

  @override
  // TODO: implement tag
  String get tag => throw UnimplementedError();
}
