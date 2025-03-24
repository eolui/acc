import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/gym_meter_widget.dart'; // ✅ Import the widget

/// Gym List Page in the app.
class GymListPage extends StatefulWidget {
  const GymListPage({super.key});

  @override
  State<GymListPage> createState() => _GymListPageState();
}

class _GymListPageState extends State<GymListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D7815),
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Az Canyon College',
          style: TextStyle(
            fontFamily: 'Inter Tight',
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gyms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No gyms found.'));
          }

          final gyms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: gyms.length,
            itemBuilder: (context, index) {
              final gym = gyms[index];
              final gymId = gym.id;

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    gym['name'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: GymMeterWidget(gymId: gymId), // ✅ Meter here
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/specificGymList',
                      arguments: gymId, // Pass the gym's document ID
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
