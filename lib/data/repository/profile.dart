part of engine;

class _Profile extends VmsEngine {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<LoginModel> getUser() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('user').get();

    String emailParam = await AccountHelper.getUserEmail();

    LoginModel loginModel = new LoginModel();

    querySnapshot.docs.map((doc) => doc.data()).toList().forEach((element) {
      if(element['Email'] == emailParam)
      {
        loginModel = LoginModel.fromJson(element['Email'], element['Name'], element['Gender'], element['Dob'].toString(), element['Height'].toString());
      }
    });

    return loginModel;

  }

  @override
  // TODO: implement tag
  String get tag => throw UnimplementedError();
}
