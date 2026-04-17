import 'package:flutter/material.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  final List<Map<String, dynamic>> notices = [
    {
      'title': 'Seminar on Mobile App Development',
      'date': '12 Dec 2025',
      'category': 'Academic',
      'details': 'Join the seminar at Room 601 from 11:00 AM.',
      'saved': false,
    },
    {
      'title': 'Club Registration Deadline',
      'date': '15 Dec 2025',
      'category': 'Club',
      'details': 'All club registrations must be completed before Friday.',
      'saved': false,
    },
    {
      'title': 'Mid Exam Notice Published',
      'date': '18 Dec 2025',
      'category': 'Exam',
      'details': 'Check your department notice board for exam schedule.',
      'saved': false,
    },
  ];

  void toggleSaved(int index) {
    setState(() {
      notices[index]['saved'] = !notices[index]['saved'];
    });
  }

  Color categoryColor(String category) {
    switch (category) {
      case 'Academic':
        return Colors.blueAccent;
      case 'Club':
        return Colors.green;
      case 'Exam':
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
        title: const Text('Notices & Events'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];

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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor(notice['category'])
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          notice['category'],
                          style: TextStyle(
                            color: categoryColor(notice['category']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => toggleSaved(index),
                        icon: Icon(
                          notice['saved']
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color:
                              notice['saved'] ? Colors.amber : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notice['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        notice['date'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notice['details'],
                    style: const TextStyle(color: Colors.white60),
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
