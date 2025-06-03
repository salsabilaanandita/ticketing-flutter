// FirestoreService.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference ticket = FirebaseFirestore.instance.collection("ticket");
  final CollectionReference order = FirebaseFirestore.instance.collection("order");

  // Ambil semua tiket
Stream<QuerySnapshot> getTicket() {
  return ticket.snapshots();
}

  // Tambah order
  Future<DocumentReference> addOrder(Map<String, dynamic> orderData) {
    return order.add(orderData);
  }

  // Get detail order
  Future<DocumentSnapshot> getOrderById(String id) {
    return order.doc(id).get();
  }
}
