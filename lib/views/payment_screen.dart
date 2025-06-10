// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_ticketing/views/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:app_ticketing/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ticketing/views/payment_success.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  final String type;
  final int price;

  const PaymentScreen({
    super.key,
    required this.title,
    required this.type,
    required this.price,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final formatter = NumberFormat('#,###', 'id_ID');
  final formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final formattedPrice = formatter.format(widget.price);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pembayaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0XFFE5E7EB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ticket details card (updated)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/i-total.png',
                          width: 48, height: 48),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Tagihan',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Rp $formattedPrice',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nama Pesanan',
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFF4B5563)),
                      ),
                      Text(
                        '${widget.title} - ${widget.type}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF4B5563)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tanggal',
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFF4B5563)),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF4B5563)),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF6B7280)),
            ),

            // Payment methods
            const SizedBox(height: 16),
            methodPayment('assets/images/cash.png', 'Tunai (Cash)', 'tunai'),
            const SizedBox(height: 12),
            methodPayment('assets/images/cc.png', 'Kartu Kredit', 'cc'),
            const SizedBox(height: 12),
            methodPayment('assets/images/qris.png', 'QRIS / QR Pay', 'qris'),
            const SizedBox(height: 30),

            const Text(
              'Punya pertanyaan?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF9CA3AF)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.blue, size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Hubungi Admin untuk bantuan \n pembayaran.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget methodPayment(String image, String title, String type) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          showPaymentDialog(context, type);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(image,
                      width: 27, height: 24, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Icon(Icons.chevron_right_rounded, size: 28, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }

  void showPaymentDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type == 'tunai'
                          ? 'Pembayaran Tunai'
                          : (type == 'cc'
                              ? 'Pembayaran Kartu Kredit'
                              : 'Pembayaran QRIS'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0XFFF3F4F6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                      type == 'tunai'
                          ? 'assets/images/s-tunai.png'
                          : (type == 'cc'
                              ? 'assets/images/transfer.png'
                              : 'assets/images/qr-code.png'),
                      height: 135,
                      width: 135,
                      fit: BoxFit.contain),
                ),
                SizedBox(height: 16),
                type == 'cc'
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '8810 7766 1234 9876',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '8810 7766 1234 9876'));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Text copied to clipboard!')),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.copy_rounded,
                                          size: 20, color: Colors.blue),
                                      Text('Salin',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(height: 14),
                Text(
                  type == 'tunai'
                      ? 'Pembayaran Tunai'
                      : type == 'cc'
                          ? 'Transfer Pembayaran'
                          : 'Scan QR untuk Membayar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    type == 'tunai'
                        ? 'Jika pembayaran telah diterima, klik button konfirmasi pembayaran untuk menyelesaikan transaksi.'
                        : (type == 'cc'
                            ? 'Pastikan nominal dan tujuan pembayaran sudah benar sebelum melanjutkan.'
                            : 'Gunakan aplikasi e-wallet atau mobile banking untuk scan QR di atas dan selesaikan pembayaran.'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
               const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // Tambahkan data pembayaran ke Firestore
                    await _firestoreService.addPayment(
                      title: widget.title,
                      type: widget.type,
                      price: widget.price,
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentSuccessScreen(
                          ticketTitle: widget.title,
                          ticketPrice: widget.price,
                          ticketType: widget.type,
                        ),
                      ),
                    );
                  },
                  child: Text('Konfirmasi Pembayaran'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
