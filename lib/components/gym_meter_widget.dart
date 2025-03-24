import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GymMeterWidget extends StatelessWidget {
  final String gymId;

  const GymMeterWidget({super.key, required this.gymId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('gyms').doc(gymId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final curOccupancy = data['curOccupancy'] ?? 0;
        final maxOccupancy =
            data['maxOccupancy'] ?? 50; // Set or fetch this from Firestore

        final double percentFull =
            (curOccupancy / maxOccupancy).clamp(0.0, 1.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Occupancy: $curOccupancy / $maxOccupancy',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentFull,
              backgroundColor: Colors.grey[300],
              color: percentFull >= 0.8 ? Colors.red : Colors.green,
              minHeight: 20,
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
