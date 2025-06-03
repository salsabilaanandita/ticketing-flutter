import 'package:app_ticketing/views/ticketing_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App illustration
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/image.png',
                      height: 330, width: 230, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 50),

              // App title and description
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    const Text(
                'Ticketing App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                'Membantu anda untuk management pembelian tiket agar lebih efisien',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Get started button
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const TicketingScreen(),
                      ),
                    );
                  },
                  child: const Text('Get Started', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                ),
                )
              ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
