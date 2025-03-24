import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecificGymListPage extends StatelessWidget {
  const SpecificGymListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String gymId = ModalRoute.of(context)!.settings.arguments as String;

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
        // Retrieve the clicked gym's info
        stream: FirebaseFirestore.instance
            .collection('gyms')
            .doc(gymId)
            .collection('equipments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No equipment found.'));
          }

          final equipmentList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return ListTile(
                title: Text(equipment['name']),
              );
            },
          );
        },
      ),
    );
  }
}
