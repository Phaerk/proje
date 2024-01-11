import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter/services.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => UserState();
}

class UserState extends State<User> {
  final searchController = TextEditingController();
  String username = '';
  static String usernamestat = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF84C1FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(130.0),
                child: Image(
                  image: AssetImage('assets/splashicon.jpg'),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  style: const TextStyle(
                      color: Colors.black), // Kullanıcı adı yazısı rengi
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue), // Kenarlık rengi
                    ),
                    filled: true,
                    fillColor: Colors.white, // TextField'ın arka plan rengi
                    labelStyle: TextStyle(
                        color: Colors.grey), // Kullanıcı adı yazısı rengi
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                      usernamestat = value; // Kullanıcı adını güncelle
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xff121212),
                  borderRadius: BorderRadius.circular(20)),
              width: 100,
              height: 40,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    print('sa');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Home(username: username);
                      }),
                    );
                  });
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
