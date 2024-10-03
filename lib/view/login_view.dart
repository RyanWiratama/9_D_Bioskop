import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/register_view.dart';
import 'package:tubes_pbp_9/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data; // Data dari RegisterView
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _errorMessage;
  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 66, 161, 238),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              inputForm(
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  }
                  if (!value.contains('@')) {
                      return 'Email Must Contain @';
                  }
                  return null;
                },
                controller: emailController,
                hintTxt: "Email",
                helperTxt: "Enter your email",
                iconData: Icons.person_outline,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(),
                      helperText: "Enter your password",
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                ),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        if (dataForm!['username'] == _usernameController.text &&
                            dataForm['password'] == _passwordController.text) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeView()));
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Password Salah'),
                              content: TextButton(
                                  onPressed: () => pushRegister(context),
                                  child: const Text('Daftar Disini !!')),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                      if (_formKey.currentState?.validate() ?? false) {
                        // Validasi apakah data register tersedia
                        if (widget.data == null) {
                          // Jika data dari register kosong
                          setState(() {
                            _errorMessage =
                                "You must register before logging in!";
                          });
                        } else {
                          // Cek apakah username dan password cocok
                          String username = widget.data?['username'];
                          String password = widget.data?['password'];

                          if (_usernameController.text == username &&
                              _passwordController.text == password) {
                            // Jika login berhasil
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomeView();
                                },
                              ),
                            );
                          } else {
                            // Jika username atau password salah
                            setState(() {
                              _errorMessage = "Invalid username or password!";
                            });
                          }
                        if (widget.data == null) {
                          setState(() {
                            _errorMessage = "Email not registered!";
                          });
                        } else {
                          String email = widget.data?['email'];
                          String password = widget.data?['password'];

                          if (emailController.text == email) {
                            if (passwordController.text == password) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeView();
                                  },
                                ),
                              );
                            } else {
                              setState(() {
                                _errorMessage = "Password is incorrect!";
                              });
                            }
                          } else {
                            setState(() {
                              _errorMessage = "Email not registered!";
                            });
                          }
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterView();
                              },
                            ),
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
    );
  }
}

