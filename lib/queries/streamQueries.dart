import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class StreamQuery {
  Stream<QuerySnapshot> getSnap({required root}) {
    return FirebaseFirestore.instance.collection(root).snapshots();
  }

  Stream<QuerySnapshot> getSnapByOneData({required root, required keyValues}) {
    return FirebaseFirestore.instance.collection(root).where(keyValues['key1'], isEqualTo: keyValues['value1']).snapshots();
  }

  Stream<QuerySnapshot> getSnapByPreventOneData({required root, required keyValues}) {
    return FirebaseFirestore.instance.collection(root).where(keyValues['key1'], isNotEqualTo: keyValues['value1']).snapshots();
  }

  Stream<QuerySnapshot> getSnapByTwoData({required root, required keyValues}) {
    return FirebaseFirestore.instance
        .collection(root)
        .where(keyValues['key1'], isEqualTo: keyValues['value1'])
        .where(keyValues['key2'], isEqualTo: keyValues['value2'])
        .snapshots();
  }

  Stream<QuerySnapshot> getSnapByThreeData({required root, required keyValues}) {
    return FirebaseFirestore.instance
        .collection(root)
        .where(keyValues['key1'], isEqualTo: keyValues['value1'])
        .where(keyValues['key2'], isEqualTo: keyValues['value2'])
        .where(keyValues['key3'], isEqualTo: keyValues['value3'])
        .snapshots();
  }

  Stream<List<QuerySnapshot>> getMultipleSnaps({required List<String> roots}) {
    final streams = roots.map((root) => FirebaseFirestore.instance.collection(root).snapshots());
    return CombineLatestStream.list(streams).asBroadcastStream();
  }

  Stream<List<QuerySnapshot>> getMultipleSnapsByData({required List roots}) {
    final streams = roots.map(
      (root) {
        switch (root.length) {
          case 3:
            return FirebaseFirestore.instance.collection(root['root']).where(root['key'], isEqualTo: root['value']).snapshots();
          case 5:
            return FirebaseFirestore.instance
                .collection(root['root'])
                .where(root['key1'], isEqualTo: root['value1'])
                .where(root['key2'], isEqualTo: root['value2'])
                .snapshots();
          case 7:
            return FirebaseFirestore.instance
                .collection(root['root'])
                .where(root['key1'], isEqualTo: root['value1'])
                .where(root['key2'], isEqualTo: root['value2'])
                .where(root['key3'], isEqualTo: root['value3'])
                .snapshots();
          case 9:
            return FirebaseFirestore.instance
                .collection(root['root'])
                .where(root['key1'], isEqualTo: root['value1'])
                .where(root['key2'], isEqualTo: root['value2'])
                .where(root['key3'], isEqualTo: root['value3'])
                .where(root['key4'], isEqualTo: root['value4'])
                .snapshots();
          default:
            return FirebaseFirestore.instance.collection(root['root']).snapshots();
        }
      },
    );
    return CombineLatestStream.list(streams).asBroadcastStream();
  }
}
