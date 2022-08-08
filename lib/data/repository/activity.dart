part of engine;

class _Activity extends VmsEngine {

  Stream<QuerySnapshot> getActivityStream(String email){

    return FirebaseFirestore.instance
        .collection('daily_activity')
        .where("Email", isEqualTo: "${email}")
        .snapshots();
  }

  addActivity(DateTime date, String weight) async {

    final CollectionReference listDailyActivity = FirebaseFirestore.instance.collection(
        'daily_activity');

    String userEmail = await AccountHelper.getUserEmail();

    await listDailyActivity.add({"Date": date, "Weight": int.parse(weight), "Email" : "${userEmail}"});

  }

  updateActivity(String documentSnapshotId, DateTime date, String weight) async {

    final CollectionReference listDailyActivity = FirebaseFirestore.instance.collection(
        'daily_activity');

    await listDailyActivity.doc(documentSnapshotId).update({"Date": date, "Weight": int.parse(weight)});

  }

  @override
  // TODO: implement tag
  String get tag => throw UnimplementedError();
}
