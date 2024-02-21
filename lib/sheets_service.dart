import 'package:gsheets/gsheets.dart';


//Keys
const _credentials=r'''
{
  "type": "service_account",
  "project_id": "flutterapp-414916",
  "private_key_id": "984b14b501b4111be807fe166711df2263fd621f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6Z/3K6nbApXHV\nzDZOW0T1ns2ZV2SWx70YmHzHi/nzMugYLzHuXfMvTM0M3x+d51Vjm083aLHINnLc\nkUp1A8o3qpIVZbjApuOjB4u81rf45EDBMLAl0oUZHzl2Df+xbB26NfgNsgR5GJ02\ni26Vv8SiG3JgJieJL2jeKZVo1736+9G6WJL+rIZZtucrVNok8xOzp71L59JBr4Zr\nGrBcEpvGkZatw7IVCHBcgk3Gw3/bLfmaXBO5f0LLvPtAGAh7vG7+of3oO3cnHaZ0\ngJ0HgDjZkb/ALvqPZynqlZPJ1eQiV10reXYSM6QU/CVcIQwtdrrFtuhVpQUdDyiG\nB2QVcwaZAgMBAAECggEAA+v7LsvnCrTluQ9OVzCxZI+I7isks81pAOhNu8RfUmAQ\nT63yhCbYM8xkW1sjEac+fdV/LFXDY8h4JdmCslqNjxqYxI1608bPGZd84lC21yw0\n4Tun1mvgSVUwWCJW7lcteu+haTxaaWfSAEXyYivXibzqbPPF4iuBWSc70am0VrWb\naWsraXRPX4MttK5BhEfGrDF7jELYAixZs3Ag1aAvz30Fd2MQq3wG51fbFgIOvx1F\n+lOx7fCjaD/k5920b6xrJmta6gTbhV/oXla2M028jnTRSDLKEJ9EVxY4JTWVn8tk\npVGf7eeR8JOuimBiimjdHCEcuLAarHwM/Sxt+HvB+QKBgQDfYe+PpmqYZVS5jELt\negrmCO/giCBAydXKJ6RaR8aIBkw25VQjJa1L2RrBDOAK+bGXNjhLn9K7Ne5wO2Q+\n/1Q+H2cHNVAKnPX2zajypVo+miQEw1NH8LxgQ6nu6J0w/lFvoshZSVZ53n8FXwM3\nuI9F6RQfGoKiU29css2ylwgWbQKBgQDVn+A1wrHa7RI1kbWU7z0o0HjYsmDQnyz3\nn13m2ad/Z156aW6G0YU3Yd/3UpoCkpMsSEn7Ghg2WNJxsFQNTpMsifqB2L6j+q5H\nSyvbZVjoDD1aAZRSpdivSK9SbVr0bJVtK3AtPc0yG3O6JB6uR2c4hbQsYcD/75Tw\nk28TcqXFXQKBgQDcWHi8VEW1ic7nMEocglQZ0Rr9eomGHxH51Ny0CTT2nG+1fsVd\n3h5xQPi5EQA3E1JwfBVP05lE/c/zeUJLOgVZOhSg8Z/AuE+PYhKTNzQrqFR7NkkC\nH59Rvaz0cxQLbfHaktHZ8ROSJz1YiP5dinoZVe55N+dAQ9kHsYBh98UMiQKBgA4c\nXmoOr0Lf0Akb09u/pdGRW7ospjqBmS3OKBy8mdTPli0N09Ax/NO4slua6DNtTS1q\npQBiK+FDIruBwzuRyiTyBEsZbxZT07k/3OjEHAhP7qmIWyzOaa7CZVpTgOOOXJx2\ndxV19JzvtUhBZIlsjAPuyQT5fA8r2zG8+2RUeWC9AoGBAI8qBxjeDh0qXJ6yfugO\nimfFE5K+UpcELip6/K7yRLFOQrBADtdXZRzTmAeS0kmAvHgiAeV1G23Y+nGW+jqV\nnw89llWrhUC5YCz2Izef2xccb4sBurbx9Xwo5m3RHzA9Co+Q32t0kUGki7mSg2Sy\n5Wf4CAb6mVlNOpexYH419LU8\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutterapp-414916.iam.gserviceaccount.com",
  "client_id": "110298901584893014451",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutterapp-414916.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';


//Spreadsheet id
const _spreadsheetId='1daxPGQSfpHHu0u8X7THzt3n3CpaSv1XOBzGaoHVu3II';

class SheetsService {
  late GSheets _gsheets;
  Worksheet? _worksheet;

  SheetsService() {
    _gsheets = GSheets(_credentials);
  }

  // Initialisation du service et accès à la feuille spécifique
  Future<void> init() async {
    final Spreadsheet spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = await spreadsheet.worksheetByTitle('Presence List');
    if (_worksheet == null) {
      print('Worksheet "Presence List" not found, creating a new one.');
      _worksheet = await spreadsheet.addWorksheet('Presence List');
    }
  }

}
