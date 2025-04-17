import 'package:flutter/material.dart';
import '../services/service_locator.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final _services = ServiceLocator();
  List<dynamic> _teachers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  Future<void> _loadTeachers() async {
    try {
      final teachers = await _services.teachers.getTeachers();
      setState(() {
        _teachers = teachers;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _deleteTeacher(String id) async {
    try {
      await _services.teachers.deleteTeacher(id);
      await _loadTeachers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _teachers.length,
      itemBuilder: (context, index) {
        final teacher = _teachers[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('${teacher['firstName']} ${teacher['lastName']}'),
            subtitle: Text(teacher['email']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTeacher(teacher['id']),
            ),
          ),
        );
      },
    );
  }
}
