import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'generate_pdf_page.dart';
import 'sheets_service.dart';
import 'add_student_page.dart';
import 'students_list_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SheetsService _sheetsService = SheetsService();

  @override
  void initState() {
    super.initState();
    _sheetsService.init();
  }

  void _startNfcSession() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("NFC n'est pas disponible sur cet appareil"),
      ));
      return;
    }

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final String nfcData = tag.data.toString();
      final bool studentExists = await _sheetsService.checkIfStudentExists(nfcData);
      if (!studentExists) {
        // Si l'étudiant n'existe pas, naviguez vers la page d'ajout
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddStudentPage(nfcCode: nfcData),
        ));
      } else {
        // Affichez un message ou effectuez une action si l'étudiant existe déjà
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("L'étudiant existe déjà"),
        ));
      }
      NfcManager.instance.stopSession();
    }).catchError((e) {
      print("Erreur lors de la lecture NFC: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.nfc, size: 100, color: Colors.deepOrangeAccent),
              onPressed: _startNfcSession,
              tooltip: 'Lire Tag NFC',
            ),

            SizedBox(height: 20), // Espacement entre les éléments
            Text(
              'Appuyez sur l\'icône pour démarrer la session NFC',
              style: TextStyle(fontSize: 16, color: Colors.deepOrangeAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _startNfcSession,
            tooltip: 'Lire Tag NFC',
            child: Icon(Icons.nfc),
            backgroundColor: Colors.deepOrangeAccent,
            heroTag: null, // This is necessary to avoid hero tag conflicts
          ),
          SizedBox(height: 16), // Adjust the height as needed
          FloatingActionButton(
            onPressed: () {
              // Add the functionality for the second button here
              // For example, you can navigate to another page or perform a different action
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StudentsListPage()),
              );

            },
            tooltip: 'List of students',
            child: Icon(Icons.account_circle),
            backgroundColor: Colors.deepOrangeAccent,
            heroTag: null, // This is necessary to avoid hero tag conflicts
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Add the functionality for the second button here
              // For example, you can navigate to another page or perform a different action
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GeneratePdfPage()),
              );

            },
            tooltip: 'Generate PDF',
            child: Icon(Icons.share),
            backgroundColor: Colors.deepOrangeAccent,
            heroTag: null, // This is necessary to avoid hero tag conflicts
          ),

        ],
      ),



    );
  }
}