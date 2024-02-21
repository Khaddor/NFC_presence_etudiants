import 'package:flutter/material.dart';
import 'sheets_service.dart';

class AddStudentPage extends StatefulWidget {
  final String nfcCode;

  const AddStudentPage({Key? key, required this.nfcCode}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName, _lastName, _studentId;
  final SheetsService _sheetsService = SheetsService();

  @override
  void initState() {
    super.initState();
    _sheetsService.init();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Utilisez votre service SheetsService pour ajouter l'étudiant
      await _sheetsService.addStudent(_firstName, _lastName, _studentId, widget.nfcCode);
      Navigator.of(context).pop(); // Retour à l'écran précédent après l'ajout
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un étudiant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Prénom'),
                onSaved: (value) => _firstName = value!,
                validator: (value) => value!.isEmpty ? 'Ce champ ne peut pas être vide' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                onSaved: (value) => _lastName = value!,
                validator: (value) => value!.isEmpty ? 'Ce champ ne peut pas être vide' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numéro Étudiant'),
                onSaved: (value) => _studentId = value!,
                validator: (value) => value!.isEmpty ? 'Ce champ ne peut pas être vide' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Ajouter'),
              ),
              SizedBox(height: 20),
              Text('Code NFC: ${widget.nfcCode}'),
            ],
          ),
        ),
      ),
    );
  }
}