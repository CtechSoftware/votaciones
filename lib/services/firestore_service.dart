import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/partido_model.dart';

class FirestoreService {
  final CollectionReference partidosRef = FirebaseFirestore.instance.collection(
    'partidos',
  );

  Stream<List<Partido>> getPartidos() {
    return partidosRef.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                Partido.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList(),
    );
  }

  Future<void> votar(String id, bool incrementar) async {
    final doc = partidosRef.doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(doc);
      if (!snapshot.exists) return;
      int votos = snapshot['votos'];
      votos = incrementar ? votos + 1 : votos - 1;
      if (votos < 0) votos = 0;
      transaction.update(doc, {'votos': votos});
    });
  }
}
