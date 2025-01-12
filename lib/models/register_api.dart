import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> registerDriver({
  required String firstName,
  required String email,
  required String password,
  required String passwordConfirmation,
  File? profileImage,
}) async {
  final url = Uri.parse('http://188.166.179.146:8000/api/auth/register/driver');
  final request = http.MultipartRequest('POST', url);

  request.fields['first_name'] = firstName;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['password_confirmation'] = passwordConfirmation;

  if (profileImage != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      profileImage.path,
    ));
  }

  final response = await request.send();

  if (response.statusCode == 200) {
    print('Register successful');
  } else {
    print('Register failed: ${response.statusCode}');
    final responseBody = await response.stream.bytesToString();
    throw Exception('Register failed: $responseBody');
  }
}
