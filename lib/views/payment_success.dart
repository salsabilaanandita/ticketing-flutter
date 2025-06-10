// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String ticketTitle;
  final dynamic ticketPrice;
  final String ticketType;

  const PaymentSuccessScreen({
    super.key, 
    required this.ticketTitle, 
    required this.ticketPrice, 
    required this.ticketType,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  bool _showDownloadAlert = false;

  Future<void> downloadPDF() async {
  const directory = "/storage/emulated/0/Download"; // Downloads folder
  const filePath = "$directory/bukti-pembayaran.pdf";
  const url = "https://mag.wcoomd.org/uploads/2018/05/blank.pdf";

  log("File downloaded to $filePath");
  try {
    await Dio().download(url, filePath, 
    onReceiveProgress: (received, total) {
          if (total != -1) {
            log('Progress: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },);
    log("File downloaded to $filePath");
    setState(() {
      _showDownloadAlert = true;
    });
  } catch (e) {
    log("Download failed: $e");
  }
}
  
  @override
  Widget build(BuildContext context) {
    // Format the price with thousands separator
    final formatter = NumberFormat('#,###', 'id_ID');
    final String formattedPrice = formatter.format(widget.ticketPrice);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Bukti Pembayaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Add space at the top to push content down
            const SizedBox(height: 30),
            
            // Success notification banner
            if (_showDownloadAlert)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
               child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                     SizedBox(width: 8),
                     Text(
                      'Bukti pembayaran berhasil di unduh!',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
              ),
            
            // Payment receipt card
            Container(
              //double.infinity = ukuran yang tidak ada batasnya
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success icon
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Success text
                  const Text(
                    "Pembayaran Berhasil",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Transaksi kamu telah selesai.\nDetail pembelian ada di bawah ini.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Ticket details
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ticketTitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  widget.ticketType,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Rp. $formattedPrice',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Pembayaran',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp. $formattedPrice',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Buttons
                  Row(
                    children: [
                      // Kembali button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Kembali',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Unduh bukti button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            downloadPDF();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Unduh bukti',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}