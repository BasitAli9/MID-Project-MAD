import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const DigitalCardApp());
}

class DigitalCardApp extends StatelessWidget {
  const DigitalCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Visiting Card',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const VisitingCardScreen(),
    );
  }
}

// -------------------------
//  USER CLASS (OOP Concept)
// -------------------------
class User {
  final String name;
  final String jobTitle;
  final String phone;
  final String email;
  final String website;
  final String imagePath;

  User({
    required this.name,
    required this.jobTitle,
    required this.phone,
    required this.email,
    required this.website,
    required this.imagePath,
  });
}

// -------------------------
//   MAIN CARD SCREEN
// -------------------------
class VisitingCardScreen extends StatefulWidget {
  const VisitingCardScreen({super.key});

  @override
  State<VisitingCardScreen> createState() => _VisitingCardScreenState();
}

class _VisitingCardScreenState extends State<VisitingCardScreen> {
  bool showFront = true;

  final User user = User(
    name: "Basit Ali",
    jobTitle: "CS Student",
    phone: "+92 311 1559530",
    email: "54596@students.riphah.edu.pk",
    website: "https://www.basitdev.com",
    imagePath: "assets/profile.jpg",
  );

  // ✅ Function to open website or email
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not launch $url")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Digital Visiting Card"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              showFront = !showFront;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: 330,
            width: 380,
            decoration: BoxDecoration(
              color: showFront ? Colors.indigo : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                return AnimatedBuilder(
                  animation: rotate,
                  child: child,
                  builder: (context, child) {
                    final isUnder = (ValueKey(showFront) != child!.key);
                    final value =
                    isUnder ? min(rotate.value, pi / 2) : rotate.value;
                    return Transform(
                      transform: Matrix4.rotationY(value),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                );
              },
              child: showFront
                  ? _buildFrontCard(user)
                  : _buildBackCard(user),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------
  // FRONT OF CARD
  // -------------------------
  Widget _buildFrontCard(User user) {
    return Container(
      key: const ValueKey(true),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(user.imagePath),
          ),
          const SizedBox(height: 12),
          Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            user.jobTitle,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tap to Flip →",
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // BACK OF CARD
  // -------------------------
  Widget _buildBackCard(User user) {
    return Container(
      key: const ValueKey(false),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoRow(Icons.phone, user.phone, "tel:${user.phone}"),
          const SizedBox(height: 10),
          _infoRow(Icons.email, user.email, "mailto:${user.email}"),
          const SizedBox(height: 10),
          _infoRow(Icons.web, user.website, user.website),
          const SizedBox(height: 20),

          // QR CODE FEATURE
          QrImageView(
            data: user.website,
            version: QrVersions.auto,
            size: 80.0,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact saved successfully!")),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text("Save Contact"),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tap to Flip Back ←",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // REUSABLE ROW FOR ICON + TEXT + CLICK
  // -------------------------
  Widget _infoRow(IconData icon, String text, String link) {
    return InkWell(
      onTap: () => _launchUrl(link),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
