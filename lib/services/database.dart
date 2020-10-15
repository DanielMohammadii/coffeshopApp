import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/models.dart/models.dart';

class DataBaseService {
  CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection("Brews");

  final String uid;

  DataBaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return coffeeCollection.doc(uid).set({
      'Sugars': sugars,
      'Name': name,
      'Strength': strength,
    });
  }

  //Convert FireStore SnapShot to BrewModels
  List<Brews> _convertFirestoreToBrewModes(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brews(
        name: doc.data()['Name'] ?? '',
        strength: doc.data()['Strength'] ?? 0,
        sugars: doc.data()['Sugars'] ?? '0',
      );
    }).toList();
  }

  //Stream of FireStore
  Stream<List<Brews>> get brews {
    return coffeeCollection.snapshots().map(_convertFirestoreToBrewModes);
  }
}
