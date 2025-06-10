// FirestoreService.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference ticket =
      FirebaseFirestore.instance.collection("ticket");
  final CollectionReference payment =
      FirebaseFirestore.instance.collection("payment");

  // Ambil semua tiket
  Stream<QuerySnapshot> getTicket() {
    return ticket.snapshots();
  }

  // Tambah data pembayaran
  Future<DocumentReference> addPayment({
    required String title,
    required String type,
    required int price,
  }) {
    return payment.add({
      'title': title,
      'type': type,
      'price': price,
      'created_at': FieldValue.serverTimestamp(), // opsional untuk timestamp
    });
  }

  // Ambil semua data pembayaran
  Stream<QuerySnapshot> getPayments() {
    return payment.snapshots();
  }
}
