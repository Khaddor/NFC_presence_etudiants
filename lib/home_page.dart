import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'sheets_service.dart';
import 'add_student_page.dart';

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _startNfcSession,
              child: Text('Lire Tag NFC'),
            ),
          ],
        ),
      ),
    );
  }
}