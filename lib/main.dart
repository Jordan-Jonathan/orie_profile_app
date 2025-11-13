import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        // Use Google Fonts for a cleaner look, matching the design
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Layer 1: The background image
          _buildBackgroundImage(),

          // Layer 2: The scrollable content
          _buildScrollableContent(context),
        ],
      ),
    );
  }

  // --- Main Content Widgets ---

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          // --- FIX: Corrected path to match your pubspec.yaml ---
          image: AssetImage('assets/images/oryza_background.png'),
          fit: BoxFit.cover,
          // Add a slight dark overlay to make text more readable
          colorFilter: ColorFilter.mode(
            Color.fromARGB(41, 0, 0, 0),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the header section that contains the outlined text
          _buildOutlinedHeaderText(),

          // This is the main blurred content card
          _buildProfileCard(context),

          // Add some padding at the bottom
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

   Widget _buildOutlinedHeaderText() {
    // This text is inside the scroll view, so it moves up
    // with the blurred card, as requested.
    return SizedBox(
      // --- FIX 1: Increased height so 'A' is not hidden by the card ---
      height: 570, // Was 350
      child: Stack(
        clipBehavior: Clip.none, // Allow letters to go outside the box slightly
        children: [
          // --- FIX 2: Re-positioned all letters to be spaced out ---
          _buildOutlinedLetter('O', 0, 15),
          _buildOutlinedLetter('Z', 83, 275),  // Was (20, 190)
          _buildOutlinedLetter('R', 165, 20), // Was (160, -10)
          _buildOutlinedLetter('A', 245, 273), // Was (160, 160)
          _buildOutlinedLetter('Y', 330, 22), // Was (280, 100)
        ],
      ),
    );
  }
  Widget _buildOutlinedLetter(String letter, double top, double left) {
    // Helper to create the large, white, outlined text
    return Positioned(
      top: top,
      left: left,
      child: Opacity(
        opacity: 0.7, // Make it slightly transparent as in the design
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 200,
            fontWeight: FontWeight.w600,
            // This is the trick to get outlined text
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        // BackdropFilter is what creates the "blur" effect
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              // The semi-transparent black background for the card
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24),
                _buildConnectButton(context),
                const SizedBox(height: 32),
                _buildPortfolioSection(),
                const SizedBox(height: 32),
                _buildInterestsSection(),
                const SizedBox(height: 32),
                _buildExperienceSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- FIX 1: Changed the name to be two lines, with "Oryza" bigger/bolder ---
        const Text(
          "Oryza",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold, // Bolder
            color: Colors.white,
          ),
        ),
        const Text(
          "Reynaleta Wibowo",
          style: TextStyle(
            fontSize: 26, // Slightly smaller
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        // phone and handle row
                          // Row(
                          //   children: [const SizedBox(height: 100) ,
                          //     Text('5026231081', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                          //     Text('—', style: TextStyle(color: Colors.white54, fontSize: 16)),
                          //     Text('@oryzarey', style: TextStyle(color: Color.fromARGB(225, 186, 174, 174), fontSize: 16)),
                          //   ],
                          // ),

        const SizedBox(height: 12),
        Row(
          children: const [
            Text(
              '5026231081',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 8),
            Text(
              '—',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            SizedBox(width: 8),
            Text(
              '@oryzarey',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(color: Colors.white24),
        const SizedBox(height: 12),

        const Text(
          "Hi! My name is Oryza, and I’m currently a third-year Information Systems student. I’m passionate about solving problems, working collaboratively, and finding ways to make processes more efficient through technology.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "I’m always open to connecting with professionals, mentors, and all fellas who share similar interests. If you’d like to exchange ideas, collaborate, or just connect, feel free to reach out, I’d love to chat and learn from you!",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
        child: ElevatedButton(
        onPressed: () async {
          final Uri url = Uri.parse('https://www.linkedin.com/in/oryzarey/');
          // Prefer launchUrl with an explicit mode. Returns true on success.
          final bool launched = await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );

          if (!launched) {
            // Show a user-friendly message instead of throwing an exception.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open link: $url')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Connect with me",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioSection() {
    // Define a list of portfolio images for the carousel
    final portfolioImages = [
      'assets/images/picture1.jpg',
      'assets/images/picture2.jpg',
      'assets/images/picture3.jpg',
      'assets/images/picture4.jpg', // Added more items
      'assets/images/picture5.jpg',
    ];

    // Create a PageController to configure the PageView
    final PageController pageController = PageController(
      // Each page takes up 50% of the view's width.
      // This will show about 2 items at a time, similar to the original.
      // Adjust this value to show more or less.
      viewportFraction: 0.5,
      initialPage: 0, // Start from the beginning
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Portfolio",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110, // Kept the height from the original design
          child: PageView.builder(
            controller: pageController, // Use the page controller
            itemCount: portfolioImages.length,
            itemBuilder: (context, index) {
              // We add padding here to create the space between items
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0), // 6px on each side = 12px gap
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    // --- NOTE ON PORTFOLIO IMAGES ---
                    // These images are still loading from the internet.
                    // If they don't appear, check your internet connection.
                    // To use local images here, you would:
                    // 1. Add them to your 'assets/images/' folder
                    // 2. Add each one to 'pubspec.yaml' (e.g., 'assets/images/portfolio1.jpg')
                    // 3. Change 'Image.network' to 'Image.asset'
                    //    (e.g., Image.asset('assets/images/portfolio1.jpg', ...))
                    portfolioImages[index],
                    height: 110,
                    fit: BoxFit.cover,
                    // Width is now controlled by the PageView's viewportFraction
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    final interests = [
      "Data Analytics",
      "Business Processing",
      "Consulting",
      "UI/UX Design",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Interests",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: interests.map((interest) => _buildInterestChip(interest)).toList(),
        ),
      ],
    );
  }

  Widget _buildInterestChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white.withOpacity(0.1),
      labelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.white24)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    final experiences = [
      {
        'title': 'Project Analyst — 180 Degrees Consulting ITS',
        'body': 'Conducting research and analysis to solve client problems in business and IT. Collaborating in a team to deliver data-driven insights and strategic recommendations.'
      },
      {
        'title': 'Teaching Assistant — Database Administration',
        'body': 'Supporting weekly classes for 45 students by teaching and assessing practical PostgreSQL exercises using DBeaver. Assisting in developing effective learning methods with fellow TAs.'
      },
      {
        'title': 'Event Staff — 8th ISICO 2025',
        'body': 'Directed and coordinated mainstage programs as Program and Floor Director. Moderated sessions and contributed to producing the official event program book.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Experience",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // Build a list of ExpansionTiles to mimic the FAQ-style accordion
        ...experiences.map((exp) {
          return Column(
            children: [
              ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 0),
                childrenPadding: const EdgeInsets.only(left: 24, right: 0, bottom: 12),
                collapsedIconColor: Colors.white70,
                iconColor: Colors.white,
                backgroundColor: Colors.transparent,
                title: Text(
                  exp['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      exp['body']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white24, height: 1, thickness: 1),
            ],
          );
        }),
      ],
    );
  }

  // Experience tiles are rendered inline as ExpansionTiles above.
}