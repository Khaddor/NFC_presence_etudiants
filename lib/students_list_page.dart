import 'package:flutter/material.dart';
import 'model/student.dart'; 

class StudentsListPage extends StatefulWidget {
  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  final List<Student> students = [
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "08:00", departureSignature: "12:00"),
    Student(studentNumber: "RE000000", arrivalSignature: "08:15", departureSignature: ""),
    Student(studentNumber: "RE000000", arrivalSignature: "", departureSignature: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Étudiants'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(student.studentNumber.substring(0, 2), style: TextStyle(color: Colors.white)),
              ),
              title: Text('Numéro d\'étudiant: ${student.studentNumber}', style: TextStyle(color: Colors.deepPurple)),
              subtitle: Text('Arrivée: ${student.arrivalSignature}, Départ: ${student.departureSignature}', style: TextStyle(color: Colors.grey[600])),
              trailing: _buildTrailingIcon(student.arrivalSignature, student.departureSignature),
            ),
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
