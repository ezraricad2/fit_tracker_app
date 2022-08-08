part of engine;

class _Account extends VmsEngine {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> loginUser({String email, String password}) async {

    final UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user;

  }

  Future<UserCredential> createUserAuthentication({String email, String password}) async {

    final UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    return user;

  }

  createUserFirestore(String email, String nama, String gender, String height, String dob) async {

    final CollectionReference listDailyActivity = FirebaseFirestore.instance.collection(
        'user');

    await listDailyActivity.add({"Email": email, "Height": int.parse(height), "Gender" : "${gender}", "Name" : "${nama}", "Dob" : "${dob}"});

  }


  @override
  // TODO: implement tag
  String get tag => throw UnimplementedError();
}
