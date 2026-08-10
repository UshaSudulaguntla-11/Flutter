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
      // 1. Mobile Menu: Shows a hamburger menu icon in the AppBar
      appBar: AppBar(
        title:
            const Text("Responsive UI", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // 2. Mobile Menu: Attaches the sliding side drawer
      drawer: isMobile ? const AppMenuList() : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            // 3. Large Screen Menu: Placed permanently on the left side
            if (!isMobile)
              Container(
                width: 250,
                color: Colors.black.withOpacity(0.4), // Blurred overlay look
                child: const AppMenuList(),
              ),
            // Main content area
            Expanded(
              child: Center(
                child: Text(
                  isMobile ? "Mobile Screen" : "Large Screen",
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Menu List Component
class AppMenuList extends StatelessWidget {
  const AppMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          Colors.black.withOpacity(0.6), // Semitransparent background
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
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
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildMenuItem(Icons.home, "Home", () {}),
          _buildMenuItem(Icons.dashboard, "Dashboard", () {}),
          _buildMenuItem(Icons.settings, "Settings", () {}),
          _buildMenuItem(Icons.logout, "Logout", () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
