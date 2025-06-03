import 'package:app_ticketing/services/firebase_service.dart';
import 'package:app_ticketing/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TicketingScreen extends StatefulWidget {
  const TicketingScreen({super.key});

  @override
  State<TicketingScreen> createState() => _TicketingScreenState();
}

class _TicketingScreenState extends State<TicketingScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final formatter = NumberFormat('#,###', 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ticketing App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0XFFE5E7EB),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getTicket(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tickets = snapshot.data!.docs;

          if (tickets.isEmpty) {
            return const Center(child: Text('No tickets available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticketData = tickets[index].data() as Map<String, dynamic>;
              
              // Format the price with thousands separator
              final price = ticketData['price'] is int
                  ? ticketData['price']
                  : int.tryParse(ticketData['price']?.toString() ?? '') ?? 0;
              final formattedPrice = formatter.format(price);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticketData['title'] ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticketData['type'] ?? '',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp. $formattedPrice',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 140, 255),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  title: ticketData['title'] ?? 'Tanpa Judul',
                                  type: ticketData['type'] ?? 'Umum',
                                  price: ticketData['price'] is int
                                      ? ticketData['price']
                                      : int.tryParse(
                                              ticketData['price']?.toString() ??
                                                  '') ??
                                          0,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            minimumSize: const Size(80, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/cart.png',
                                  width: 18, height: 18, fit: BoxFit.contain),
                              const SizedBox(width: 8),
                              const Text('Beli',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
