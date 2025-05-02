import 'package:flutter/material.dart';
import 'package:grabai/core/services/person_service.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: PersonService().getPersons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No users found.');
        }

        final users = snapshot.data!;
        return ListView.builder(
          itemCount: users.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('http://10.30.11.44:1111/${user['img']}'),
              ),
              title: Text(user['name']),
              subtitle: Text('Age: ${user['age']} | Gender: ${user['gender']}'),
            );
          },
        );
      },
    );
  }
}
