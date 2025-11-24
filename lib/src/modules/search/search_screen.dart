import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final suggestions = const [
    'Paneer butter masala',
    'Broccoli',
    'Organic dairy pack',
    'Wallet friendly combos',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Search dishes, stores, products',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) => ListTile(
          leading: const Icon(Icons.search),
          title: Text(suggestions[index]),
          subtitle: const Text('Top result • 2 km'),
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: suggestions.length,
      ),
    );
  }
}

