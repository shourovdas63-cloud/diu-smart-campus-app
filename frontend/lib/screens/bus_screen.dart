import 'package:flutter/material.dart';

class BusScreen extends StatefulWidget {
  const BusScreen({super.key});

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  final List<Map<String, dynamic>> busSchedules = [
    {
      'route': 'Mirpur to DIU',
      'time': '7:30 AM',
      'busNo': 'Bus-01',
      'status': 'On Time',
      'saved': false,
    },
    {
      'route': 'Uttara to DIU',
      'time': '8:00 AM',
      'busNo': 'Bus-02',
      'status': 'Delayed',
      'saved': false,
    },
    {
      'route': 'Dhanmondi to DIU',
      'time': '8:15 AM',
      'busNo': 'Bus-03',
      'status': 'On Time',
      'saved': false,
    },
    {
      'route': 'DIU to Mirpur',
      'time': '4:30 PM',
      'busNo': 'Bus-04',
      'status': 'On Time',
      'saved': false,
    },
  ];

  void toggleSaved(int index) {
    setState(() {
      busSchedules[index]['saved'] = !busSchedules[index]['saved'];
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case 'On Time':
        return Colors.green;
      case 'Delayed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Bus Schedule'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: busSchedules.length,
        itemBuilder: (context, index) {
          final bus = busSchedules[index];

          return Card(
            color: Colors.white.withOpacity(0.05),
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.directions_bus, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          bus['route'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => toggleSaved(index),
                        icon: Icon(
                          bus['saved'] ? Icons.bookmark : Icons.bookmark_border,
                          color: bus['saved'] ? Colors.amber : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        bus['time'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.confirmation_number,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        bus['busNo'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor(bus['status']).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bus['status'],
                      style: TextStyle(
                        color: statusColor(bus['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
