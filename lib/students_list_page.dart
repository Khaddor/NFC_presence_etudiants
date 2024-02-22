import 'package:flutter/material.dart';
import 'package:nfc_presence_etudiants/sheets_service.dart';
import 'model/student.dart';

class StudentsListPage extends StatefulWidget {
  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  final SheetsService _sheetsService = SheetsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Étudiants'),
        backgroundColor: Colors.deepOrangeAccent, // Updated color here
      ),
      body: FutureBuilder<List<Student>>(
        future: _sheetsService.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun étudiant trouvé'));
          }
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Text('${student.firstName[0]}${student.lastName[0]}', style: TextStyle(color: Colors.white)),
                  ),
                  title: Text('${student.firstName} ${student.lastName}', style: TextStyle(color: Colors.deepOrangeAccent)),
                  subtitle: Text('Numéro d\'étudiant: ${student.studentNumber}', style: TextStyle(color: Colors.grey[600])),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTrailingIcon(String arrivalSignature, String departureSignature) {
    if (arrivalSignature.isEmpty && departureSignature.isEmpty) {
      return Icon(Icons.close, color: Colors.red);
    } else if (arrivalSignature.isNotEmpty && departureSignature.isEmpty) {
      return Icon(Icons.hourglass_empty, color: Colors.amber);
    }
    return Icon(Icons.check_circle, color: Colors.green);
  }
}
