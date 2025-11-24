import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: CircleAvatar(radius: 32, child: Icon(Icons.person)),
            title: Text('Aditi Sharma'),
            subtitle: Text('+91 98765 43210'),
            trailing: Icon(Icons.edit),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Saved addresses'),
            subtitle: Text('Home, Work'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Saved cards'),
            subtitle: Text('**** 4210, **** 9012'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text('Favorites'),
            subtitle: Text('12 restaurants • 6 grocery lists'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

