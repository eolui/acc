import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//------------------------------------------------------
//        GYM'S CAPACITY METER WIDGET
//------------------------------------------------------
class GymMeterWidget extends StatelessWidget {
  final String gymId;

  const GymMeterWidget({super.key, required this.gymId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      // Wait for real-time updates from gyms collection
      stream:
          FirebaseFirestore.instance.collection('gyms').doc(gymId).snapshots(),
      builder: (context, snapshot) {
        // While data loads, show a loading spin
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final curOccupancy = data['curOccupancy'] ?? 0;
        final maxOccupancy = data['maxOccupancy'] ??
            50; // If null/empty, maxOcc will be set to 50

        // Occupancy Meter calculation
        final double percentFull =
            (curOccupancy / maxOccupancy).clamp(0.0, 1.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays curOcc / maxOcc text
            Text(
              'Occupancy: $curOccupancy / $maxOccupancy',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Horizontal bar to represent capacity level
            LinearProgressIndicator(
              value: percentFull,
              backgroundColor: Colors.grey[300],
              // RED if 80% full - Green for bellow 80%
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
