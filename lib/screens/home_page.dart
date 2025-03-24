import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/gym_meter_widget.dart'; // ✅ Import your meter widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D7815),
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Az Canyon College - Home',
          style: TextStyle(
            fontFamily: 'Inter Tight',
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      // Smaller version of the widget used in gym_list_page.dart
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gyms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No gyms found.'));
          }

          // Limit to first 3 gyms
          final gyms = snapshot.data!.docs.take(3).toList();

          return ListView.builder(
            itemCount: gyms.length,
            itemBuilder: (context, index) {
              final gym = gyms[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(gym['name']),
                  subtitle: GymMeterWidget(gymId: gym.id),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/specificGymList',
                      arguments: gym.id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
