import 'package:flutter/material.dart';

void main() {
  runApp(const FbApp());
}

class FbApp extends StatelessWidget {
  const FbApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInRoute(),
        '/Homepage': (context) => HomePageRoute()
      },
    );
  }
}

class SignInRoute extends StatelessWidget {
  const SignInRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controllerEmail = TextEditingController();
    final _controllerPassword = TextEditingController();

    Widget Input = Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: const Text(
              'FACEBOOK',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          TextField(
            controller: _controllerEmail,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              obscureText: true,
              controller: _controllerPassword,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {
                  if (_controllerPassword.text == _controllerEmail.text) {
                    Navigator.pushNamed(context, '/Homepage');
                    return;
                  }
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero))),
          )
        ],
      ),
    );

    Widget bottom = Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: const Text(
            'Đăng ký Facebook',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: const Text(
            'Cần trợ giúp?',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Expanded(child: Input), bottom],
      ),
    );
  }
}

class HomePageRoute extends StatefulWidget {
  @override
  State<HomePageRoute> createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  @override
  Widget build(BuildContext context) {
    Widget drawer = Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Security'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sign out'),
            onTap: () {},
          )
        ],
      ),
    );

    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: const Text(
                'facebook',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              bottom: const TabBar(
                tabs: [
                  Icon(Icons.home),
                  Icon(Icons.people_alt),
                  Icon(Icons.notifications),
                  Icon(Icons.menu)
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Text('Icon home'),
                Text('Icon friend'),
                Text('Icon notification'),
                drawer
              ],
            )));
  }
}
