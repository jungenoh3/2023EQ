import 'package:firebase_database/firebase_database.dart';


class FirebaseRealtimeDBApi {
  final _firebaseDB = FirebaseDatabase.instance;

  void readRealTimeDB(){
    DatabaseReference ref = FirebaseDatabase.instance.ref("/server/EQMS");
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    }
    // onError: // TODO
    );
  }
}