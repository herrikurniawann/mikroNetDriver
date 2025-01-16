import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> registerDriver({
  required String firstName,
  required String email,
  required String password,
  required String passwordConfirmation,
  required File profileImage,
}) async {
  if (!profileImage.existsSync()) {
    throw Exception('File gambar tidak ditemukan di path: ${profileImage.path}');
  }

  final allowedExtensions = ['jpg', 'jpeg', 'png'];
  final fileExtension = profileImage.path.split('.').last.toLowerCase();

  if (!allowedExtensions.contains(fileExtension)) {
    throw Exception('Format file tidak didukung: $fileExtension. Gunakan JPG atau PNG.');
  }

  final url = Uri.parse('http://188.166.179.146:8000/api/auth/register/driver');
  final request = http.MultipartRequest('POST', url);

  request.fields['first_name'] = firstName;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['password_confirmation'] = passwordConfirmation;
  request.files.add(
    await http.MultipartFile.fromPath('profile_picture', profileImage.path),
  );

  try {
    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Register successful');
      print('Server response: $responseString');
    } else {
      print('Register failed: ${response.statusCode}');
      print('Server response: $responseString');
      throw Exception('Register failed: $responseString');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Register failed: $e');
  }
}