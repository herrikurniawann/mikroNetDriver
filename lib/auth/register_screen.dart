import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:ridehailing/auth/login_screen.dart';
import 'package:ridehailing/widgets/background_widget.dart';
import 'package:ridehailing/models/register_api.dart';
import 'package:ridehailing/widgets/alert_helper.dart'; // Import AlertHelper

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _isObscure = true;
  File? _profileImage;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _profileImage = File(result.files.single.path!);
      });
    } else {
      AlertHelper.showAlert(
        context: context,
        title: 'Gagal memilih gambar',
        message: 'Silakan pilih ulang gambar.',
      );
    }
  }

  Future<void> _register() async {
    if (_firstNameController.text.isEmpty) {
      AlertHelper.showAlert(
        context: context,
        title: 'Nama kosong',
        message: 'Nama tidak boleh kosong.',
      );
      return;
    }

    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      AlertHelper.showAlert(
        context: context,
        title: 'Email tidak valid',
        message: 'Silakan masukkan email yang valid.',
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      AlertHelper.showAlert(
        context: context,
        title: 'Password terlalu pendek',
        message: 'Password minimal harus 6 karakter.',
      );
      return;
    }

    if (_passwordController.text != _passwordConfirmationController.text) {
      AlertHelper.showAlert(
        context: context,
        title: 'Konfirmasi Password',
        message: 'Password dan konfirmasi tidak cocok.',
      );
      return;
    }

    if (_profileImage == null) {
      AlertHelper.showAlert(
        context: context,
        title: 'Gambar belum dipilih',
        message: 'Harap pilih foto profil.',
      );
      return;
    }

    try {
      await registerDriver(
        firstName: _firstNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmationController.text,
        profileImage: _profileImage!,
      );

      // Registrasi berhasil
      await AlertHelper.showAlert(
        context: context,
        title: 'Registrasi Berhasil',
        message: 'Akun Anda telah terdaftar. Silakan login.',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginForm()),
      );
    } catch (e) {
      // Tangkap error dengan detail lebih jelas
      AlertHelper.showAlert(
        context: context,
        title: 'Registrasi Gagal',
        message: 'Terjadi kesalahan: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              prefixIcon: const Icon(Icons.email),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordConfirmationController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password Confirmation',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Upload Photo'),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.63),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: Colors.white, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sudah punya akun?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginForm(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
