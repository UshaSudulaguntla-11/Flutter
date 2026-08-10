import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive UI Menu',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile
          ? AppBar(
              title: const Text("Responsive UI",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null, // No app bar needed on large screens

      // Mobile sliding menu (keeps vertical text links)
      drawer: isMobile
          ? const Drawer(child: AppMenuList(iconsOnly: false, isRowWise: false))
          : null,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // ADAPTIVE STRUCTURAL CHANGE:
        // Mobile uses Row to slide drawer from side. Large screen uses Column to stack row menu at top.
        child: isMobile
            ? Center(
                child: Text(
                  "Mobile Screen",
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              )
            : SafeArea(
                child: Column(
                  children: [
                    // Horizontal Menu Row Bar across the top of the large screen
                    Container(
                      height: 70, // Fixed height for a sleek top navigation bar
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.4),
                      child:
                          const AppMenuList(iconsOnly: true, isRowWise: true),
                    ),

                    // Main content area taking up the remaining space below the row menu
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Large Screen ",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

// Reusable Dynamic Menu List Component
class AppMenuList extends StatelessWidget {
  final bool iconsOnly;
  final bool
      isRowWise; // Control variable to toggle vertical or horizontal rendering

  const AppMenuList({
    super.key,
    required this.iconsOnly,
    required this.isRowWise,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Changes scroll direction based on screen needs
      scrollDirection: isRowWise ? Axis.horizontal : Axis.vertical,
      padding: isRowWise
          ? const EdgeInsets.symmetric(horizontal: 16.0)
          : EdgeInsets.zero,
      children: [
        // Custom Profile Header
        _buildHeader(),

        // Navigation Options
        _buildMenuItem(Icons.home, "Home", () {}),
        _buildMenuItem(Icons.dashboard, "Dashboard", () {}),
        _buildMenuItem(Icons.settings, "Settings", () {}),
        _buildMenuItem(Icons.logout, "Logout", () {}),
      ],
    );
  }

  // Adaptive Header Layout
  Widget _buildHeader() {
    if (iconsOnly) {
      return Padding(
        // Changes layout alignment to work inside rows vs columns
        padding: isRowWise
            ? const EdgeInsets.only(right: 24.0)
            : const EdgeInsets.symmetric(vertical: 24.0),
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person, color: Colors.white),
        ),
      );
    }

    return const DrawerHeader(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Navigation Menu",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Adaptive Menu Item Layout
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    if (iconsOnly) {
      return Padding(
        // Uniform padding spacing depending on vertical stack or horizontal strip layout
        padding: isRowWise
            ? const EdgeInsets.symmetric(horizontal: 16.0)
            : const EdgeInsets.symmetric(vertical: 12.0),
        child: IconButton(
          icon: Icon(icon, color: Colors.white70, size: 28),
          onPressed: onTap,
          tooltip: title, // Tooltip shows menu item text string on mouse hover
        ),
      );
    }

    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
