import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text("MY PROFILE"),
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
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF84464), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=500'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF84464),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "John Doe",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "john.doe@example.com",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 40),
          _buildProfileTile(
            icon: Icons.settings_outlined,
            title: "Settings",
          ),
          _buildProfileTile(
            icon: Icons.history,
            title: "Booking History",
          ),
          _buildProfileTile(
            icon: Icons.payment_outlined,
            title: "Payment Methods",
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Color(0xFFF84464)),
                label: const Text(
                  "LOGOUT",
                  style: TextStyle(
                    color: Color(0xFFF84464),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFF84464)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileTile({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white70),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.white24),
          onTap: () {},
        ),
      ),
    );
  }
}
