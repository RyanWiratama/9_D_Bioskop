import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/register_view.dart';
import 'package:tubes_pbp_9/view/home_view.dart';

class LoginView extends StatefulWidget {
  final Map? data;
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
    return Scaffold(
<<<<<<< Updated upstream
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
      backgroundColor: const Color(0xFF7B2C27),
=======
      backgroundColor: const Color(0xFF384357),
>>>>>>> Stashed changes
      body: Stack(
        children: [
          // Upper red part of the background
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            color: const Color(0xFF384357), // Warna marun untuk header
            child: const Center(
              child: Icon(
                Icons.movie, // Ikon rol film
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          // Beige container for the form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.73,
              decoration: const BoxDecoration(
                color: Colors.white, // Beige color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
      backgroundColor: const Color(0xFF384357),
      body: Stack(
        children: [
          // Upper red part of the background
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            color: const Color(0xFF384357), // Warna marun untuk header
            child: const Center(
              child: Icon(
                Icons.movie, // Ikon rol film
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          // Beige container for the form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.73,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), // Beige color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
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
                    const SizedBox(height: 10),
                    const Text(
                      "New movie is waiting for you!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "New movie is waiting for you!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Email field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "email@gmail.com",
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
                        }
                        if (!value.contains('@')) {
                          return 'Email must contain @.';
                        }
                        return null; // Valid
                      },
                    ),
                    const SizedBox(height: 20),
                    // Password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null; // Valid
                      },
                    ),
                    const SizedBox(height: 30),
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF384357), // Maroon color
<<<<<<< Updated upstream
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (widget.data == null) {
                              setState(() {
                                _errorMessage = "Email not registered!";
                              });
                            } else {
                              String email = widget.data?['email'];
                              String password = widget.data?['password'];
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
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null; // Valid
                      },
                    ),
                    const SizedBox(height: 30),
                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF7B2C27), // Maroon color
=======
>>>>>>> Stashed changes
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (widget.data == null) {
                              setState(() {
                                _errorMessage = "Email not registered!";
                              });
                            } else {
                              String email = widget.data?['email'];
                              String password = widget.data?['password'];

                              if (emailController.text == email &&
                                  passwordController.text == password) {
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
                                  _errorMessage =
                                      "Invalid username or password!";
                                });
                              }
                            }
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
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Tampilkan pesan kesalahan
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have any account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
