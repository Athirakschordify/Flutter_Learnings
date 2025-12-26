import 'package:flutter/material.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  final List<Map<String, String>> tickets = const [
    {
      'movie': 'Interstellar',
      'date': '24 Dec, 2025',
      'time': '06:30 PM',
      'seats': 'C1, C2',
      'theater': 'PVR: Lulu Mall',
      'image': 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=500'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Match Movie List background
      appBar: AppBar(
        title: const Text("MY TICKETS"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          letterSpacing: 2,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: tickets.isEmpty
          ? const Center(
              child: Text("No tickets found",
                  style: TextStyle(color: Colors.white)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ClipPath(
                    clipper: TicketClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Top part with image and movie info
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 140,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(ticket['image'] ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ticket['movie'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        ticket['theater'] ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          const Icon(Icons.confirmation_num,
                                              size: 16, color: Color(0xFFF84464)),
                                          const SizedBox(width: 4),
                                          const Text(
                                            "BOOKING ID: #829KS7",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFF84464)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Dashed Line Divider
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: List.generate(
                                30,
                                (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : Colors.grey[300],
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Bottom part with details and QR Placeholder
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ticketDetail("DATE", ticket['date'] ?? ''),
                                    const SizedBox(height: 12),
                                    _ticketDetail("SEATS", ticket['seats'] ?? ''),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ticketDetail("TIME", ticket['time'] ?? ''),
                                    const SizedBox(height: 12),
                                    _ticketDetail("PRICE", "₹350.00"),
                                  ],
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.qr_code_2,
                                        size: 40, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _ticketDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 15;
    double cutOutRadius = 15;
    double cutOutPosition = 164; // Adjusted to match the divider position

    path.lineTo(0, cutOutPosition - cutOutRadius);
    path.arcToPoint(
      Offset(0, cutOutPosition + cutOutRadius),
      radius: Radius.circular(cutOutRadius),
      clockwise: true,
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, cutOutPosition + cutOutRadius);
    path.arcToPoint(
      Offset(size.width, cutOutPosition - cutOutRadius),
      radius: Radius.circular(cutOutRadius),
      clockwise: true,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
