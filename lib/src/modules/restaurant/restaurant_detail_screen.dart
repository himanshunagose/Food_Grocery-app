import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data = Get.arguments as Map<String, dynamic>?;
    final menu = data?['menu'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(data?['name'] ?? 'Restaurant'),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Menu'),
            Tab(text: 'Info'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: menu.length,
            itemBuilder: (_, index) {
              final category = menu[index] as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category['category'] as String, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ...List.generate(
                    (category['items'] as List<dynamic>).length,
                    (itemIndex) {
                      final item = (category['items'] as List<dynamic>)[itemIndex] as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(item['name'] as String),
                          subtitle: Text(item['description'] as String),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('₹${item['basePrice']}'),
                              const SizedBox(height: 8),
                              FilledButton.tonal(
                                onPressed: () {},
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
          ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text('${data?['distanceKm']} km away'),
                subtitle: const Text('Express delivery available'),
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: Text('${data?['etaMinutes']} mins'),
                subtitle: const Text('Average preparation time'),
              ),
              ListTile(
                leading: const Icon(Icons.star_half),
                title: Text('${data?['rating']} • ${data?['ratingCount']} ratings'),
                subtitle: const Text('Top rated in your area'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

