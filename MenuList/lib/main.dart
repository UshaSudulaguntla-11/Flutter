import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile
          ? AppBar(
              title: const Text("Responsive UI"),
              backgroundColor: Colors.transparent,
              elevation: 0)
          : null,
      drawer: isMobile
          ? const Drawer(child: AppMenuList(iconsOnly: false, isRowWise: false))
          : null,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset("assets/backgroundd.jpg", fit: BoxFit.fill)),
          Positioned.fill(
            child: isMobile
                ? const Center(
                    // FIXED: Cleaned up Column and removed the ElevatedButton completely
                    child: Text("Mobile Screen Menu",
                        style: TextStyle(fontSize: 25)),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        Container(
                            height: 70,
                            color: Colors.black.withValues(alpha: 0.4),
                            child: const AppMenuList(
                                iconsOnly: true, isRowWise: true)),
                        const Expanded(
                            child: Center(
                                child: Text("Welcome to the Home Page",
                                    style: TextStyle(fontSize: 25)))),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class AppMenuList extends StatelessWidget {
  final bool iconsOnly, isRowWise;
  const AppMenuList(
      {super.key, required this.iconsOnly, required this.isRowWise});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'title': 'Home', 'page': const MyHomePage()},
      {
        'icon': Icons.room_service,
        'title': 'Services',
        'page': const ServicesPage()
      },
      {
        'icon': Icons.feedback,
        'title': 'Feedback',
        'page': const FeedbackPage()
      },
    ];

    return ListView(
      scrollDirection: isRowWise ? Axis.horizontal : Axis.vertical,
      padding: isRowWise
          ? const EdgeInsets.symmetric(horizontal: 16.0)
          : EdgeInsets.zero,
      children: [
        if (!iconsOnly)
          const DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person)),
                SizedBox(height: 10),
                Text("Navigation Menu",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],
            ),
          )
        else
          Padding(
              padding: EdgeInsets.only(
                  right: isRowWise ? 24.0 : 0, bottom: isRowWise ? 0 : 24.0),
              child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person))),
        ...items.map((item) {
          final action = () {
            if (!isRowWise) Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => item['page'] as Widget));
          };
          return iconsOnly
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isRowWise ? 16.0 : 0,
                      vertical: isRowWise ? 0 : 12.0),
                  child: IconButton(
                      icon: Icon(item['icon'] as IconData, size: 28),
                      onPressed: action,
                      tooltip: item['title'] as String))
              : ListTile(
                  leading: Icon(item['icon'] as IconData),
                  title: Text(item['title'] as String),
                  onTap: action);
        }),
      ],
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Services")),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.design_services, size: 80, color: Colors.blue),
                SizedBox(height: 20),
                Text("Our Premium Services",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Text(
                    "We provide cross-platform development, cloud consulting, responsive UI designs, and custom software solutions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ),
        ),
      );
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _controller = TextEditingController();
  String _status = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Feedback")),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("We value your input!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(height: 25),
              TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter feedback'),
                  maxLines: 4),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() {
                  _status = _controller.text.trim().isNotEmpty
                      ? "Feedback Submitted"
                      : "Please enter some text.";
                  if (_status == "Feedback Submitted") _controller.clear();
                }),
                child: const Text("Submit"),
              ),
              const SizedBox(height: 30),
              Text(_status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _status == "Feedback Submitted"
                          ? Colors.greenAccent
                          : Colors.orangeAccent)),
            ],
          ),
        ),
      );
}
