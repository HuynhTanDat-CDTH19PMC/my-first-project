import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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

    Widget _input = Container(
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

    Widget _bottom = Column(
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
        children: [Expanded(child: _input), _bottom],
      ),
    );
  }
}

class HomePageRoute extends StatefulWidget {
  @override
  State<HomePageRoute> createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  final _listUser = <WordPair>[];
  final _saved = <WordPair>[];
  final _countLove = 0;

  Widget _buildHomeScreen() {
    return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/
          final index = i ~/ 2; /*3*/
          if (index >= _listUser.length) {
            _listUser.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildPost(_listUser[index]);
        });
  }

  Widget _buildPost(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/user.jpg'))),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        pair.asPascalCase,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      '1 giờ trước',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
      ],
    );

    Widget content = Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: const Text(
        'Home: Chứa danh sách bài viết (không yêu cầu bình luận), 1 bài viết gồm '
        '(icon người dùng, Tên người dùng, thời gian, hình đại diện, nồi dung tóm '
        'tắt, nút xem tiếp, (emotion: like, love, …)',
        softWrap: true,
      ),
    );

    Widget countLove = Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 14,
          ),
        ),
        Text(alreadySaved ? (_countLove + 1).toString() : _countLove.toString())
      ],
    );

    Widget comment = Container(
      child: Column(
        children: [
          Divider(
            color: Colors.grey[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (alreadySaved) {
                            _saved.remove(pair);
                          } else {
                            _saved.add(pair);
                          }
                        });
                      },
                      icon: Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : null,
                      ),
                    ),
                    Text('Thích')
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_outlined),
                    ),
                    const Text('Bình luận')
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                    ),
                    const Text('Chia sẻ')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [title, content, countLove],
            ),
          ),
          comment
        ],
      ),
    );
  }

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
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                'facebook',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
                _buildHomeScreen(),
                const Text('Icon friend'),
                const Text('Icon notification'),
                drawer
              ],
            )));
  }
}
