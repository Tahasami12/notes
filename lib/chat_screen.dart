import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int currentIndex = 0;

  final List<String> names = [
    "Taha",
    "Medo",
    "Ahmed",
    "Ali",
    "Omar",
    "Sara",
    "Mona",
    "Youssef",
    "Karim",
    "Noor",
  ];

  final List<String> avatars = [
    "https://i.pravatar.cc/150?img=1",
    "https://i.pravatar.cc/150?img=2",
    "https://i.pravatar.cc/150?img=3",
  ];

  late final List<Map<String, dynamic>> chats =
  List.generate(10, (index) {
    return {
      "name": names[index],
      "message": "Sample message ${index + 1}",
      "time": "11:${index}0 AM",
      "online": index % 2 == 0,
      "avatar": avatars[index % avatars.length],
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EEF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EEF5),
        elevation: 0,
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {

          },
        ),
        actions: const [
          Icon(Icons.camera_alt_outlined, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.edit, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Stories
          SizedBox(
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage:
                            NetworkImage(chats[index]["avatar"]),
                          ),
                          if (chats[index]["online"])
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.green,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chats[index]["name"],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Chats list
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                        NetworkImage(chats[index]["avatar"]),
                      ),
                      if (chats[index]["online"])
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.green,
                          ),
                        ),
                    ],
                  ),
                  title: Text(chats[index]["name"]),
                  subtitle: Text(chats[index]["message"]),
                  trailing: Text(
                    chats[index]["time"],
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ✅ Bottom Navigation بعد الإصلاح
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // مهم جدًا
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple, // لون واضح
        unselectedItemColor: Colors.grey,     // مختلف
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "People",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",


          ),
        ],
      ),
    );
  }
}
