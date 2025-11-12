import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          _buildScrollableContent(),
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
            Colors.black26,
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the header section that contains the outlined text
          _buildOutlinedHeaderText(),

          // This is the main blurred content card
          _buildProfileCard(),

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
      height: 550, // Was 350
      child: Stack(
        clipBehavior: Clip.none, // Allow letters to go outside the box slightly
        children: [
          // --- FIX 2: Re-positioned all letters to be spaced out ---
          _buildOutlinedLetter('O', 0, 20),
          _buildOutlinedLetter('Z', 0, 240),  // Was (20, 190)
          _buildOutlinedLetter('R', 165, 25), // Was (160, -10)
          _buildOutlinedLetter('A', 165, 240), // Was (160, 160)
          _buildOutlinedLetter('Y', 330, 27), // Was (280, 100)
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
            fontWeight: FontWeight.w700,
            // This is the trick to get outlined text
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
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
                _buildConnectButton(),
                const SizedBox(height: 32),
                _buildPortfolioSection(),
                const SizedBox(height: 32),
                _buildInterestsSection(),
                const SizedBox(height: 32),
                _buildExperienceSection(),
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
            fontSize: 30,
            fontWeight: FontWeight.w900, // Bolder
            color: Colors.white,
          ),
        ),
        const Text(
          "Reynaleta Wibowo",
          style: TextStyle(
            fontSize: 24, // Slightly smaller
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12), // Added a bit more space
        Text(
          "5026231081 — @oryzarey",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Information Systems Undergrad, super pretty super stylish "
          "and ready to take on the world, n the best gf ever. "
          "Information Systems Undergrad, super pretty super stylish "
          "and ready to take on the world, n the best gf ever.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
      'assets/images/porto1.JPG',
      'assets/images/porto2.jpg',
      'assets/images/porto3.JPG',
      'assets/images/porto4.jpg', // Added more items
      'assets/images/porto5.jpg',
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
          height: 100, // Kept the height from the original design
          child: PageView.builder(
            controller: pageController, // Use the page controller
            itemCount: portfolioImages.length,
            itemBuilder: (context, index) {
              // We add padding here to create the space *between* items
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
                    height: 100,
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
      "Data Analyzing",
      "Data Analyzing",
      "Data Analyzing",
      "Data Analyzing",
      "Data Analyzing",
      "Data Analyzing",
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
          spacing: 8.0,
          runSpacing: 8.0,
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
      side: BorderSide(color: Colors.white.withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildExperienceSection() {
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
        _buildExperienceItem(
            "Information Systems Undergrad, super pretty super sty"),
        const SizedBox(height: 12),
        _buildExperienceItem(
            "Information Systems Undergrad, super pretty super sty"),
      ],
    );
  }

  Widget _buildExperienceItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 7.0),
          child: Icon(Icons.circle, size: 6, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}