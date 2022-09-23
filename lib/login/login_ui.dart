import 'package:flutter/material.dart';
import 'package:my_news_app/api.dart';
import 'package:my_news_app/main.dart';
import 'package:my_news_app/menu/news_page.dart';
import 'package:my_news_app/model/res_login.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  Future<ResLogin?> loginUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(Uri.parse(loginApiUrl),
          body: {'username': username.text, 'password': password.text});
      ResLogin data = resLoginFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(data.message ?? ""),
            ),
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
              (route) => false);
        });
      } else if (data.value == 0) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(data.message ?? ""),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: keyForm,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  child: Icon(
                    Icons.login_sharp,
                    size: 55,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Jom Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: ((value) {
                    return value!.isEmpty ? "Username must be fill" : null;
                  }),
                  controller: username,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    return value!.isEmpty ? "Password must be fill" : null;
                  }),
                  controller: password,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MaterialButton(
                        textColor: Colors.white,
                        onPressed: () async {
                          if (keyForm.currentState!.validate()) {
                            await loginUser();
                          }
                        },
                        height: 50,
                        minWidth: double.infinity,
                        color: Colors.blueGrey,
                        child: const Text("LOGIN"),
                      ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Dont have any account? register here",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
