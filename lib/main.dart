import 'dart:developer';
import 'dart:math';

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
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInRoute(),
        '/Mainpage': (context) => MainRoute(),
        '/Profile': (context) => Profile(),
        '/Security': (context) => Security()
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
                    Navigator.pushNamed(context, '/Mainpage');
                    return;
                  }
                },
                child: const Text(
                  '????ng nh???p',
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
            '????ng k?? Facebook',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: const Text(
            'C???n tr??? gi??p?',
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

class MainRoute extends StatefulWidget {
  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  Widget _buildListTitle(String text, IconData icon, String routeName) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon),
            ),
            Text(text),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget drawer = Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/user.jpg'))),
                  ),
                  const Text(
                    'Hu???nh T???n ?????t',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          _buildListTitle(
              'Profile', Icons.supervised_user_circle_outlined, '/Profile'),
          _buildListTitle('Security', Icons.security_sharp, '/Security'),
          _buildListTitle('Sign out', Icons.exit_to_app, '/')
        ],
      ),
    );
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              FriendPage(),
              NotificationPage(),
            ],
          ),
          drawer: drawer,
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listUser = <WordPair>[];
  final _saved = <WordPair>[];
  final _countLove = 0;
  var random = new Random();

  Widget _buildPostHomeScreen(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUser(pair, random.nextInt(24).toString() + ' gi??? tr?????c'),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
      ],
    );

    Widget content = Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: const Text(
        'Home: Ch???a danh s??ch b??i vi???t (kh??ng y??u c???u b??nh lu???n), 1 b??i vi???t g???m '
        '(icon ng?????i d??ng, T??n ng?????i d??ng, th???i gian, h??nh ?????i di???n, n???i dung t??m '
        't???t, n??t xem ti???p, (emotion: like, love, ???)',
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
                    Text('Th??ch')
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
                    const Text('B??nh lu???n')
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
                    const Text('Chia s???')
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
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            _buildtitle('B???ng tin'),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemBuilder: /*1*/ (context, i) {
                    if (i.isOdd) return const Divider(); /*2*/
                    final index = i ~/ 2; /*3*/
                    if (index >= _listUser.length) {
                      _listUser.addAll(generateWordPairs().take(10)); /*4*/
                    }
                    return _buildPostHomeScreen(_listUser[index]);
                  }),
            )
          ],
        ));
  }
}

class FriendPage extends StatefulWidget {
  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final _listFriend = <WordPair>[];
  final _saved = <WordPair>[];
  var random = new Random();

  Widget _buildListFriend(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: _buildUser(pair, random.nextInt(100).toString() + ' b???n chung'),
      trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            });
          },
          style: ElevatedButton.styleFrom(
              primary: alreadySaved ? Colors.blue : Colors.grey),
          child: Text(
            alreadySaved ? 'K???t b???n' : 'H???y k???t b???n',
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildtitle('Danh s??ch b???n b??'),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemBuilder: /*1*/ (context, i) {
                if (i.isOdd) return const Divider(); /*2*/
                final index = i ~/ 2; /*3*/
                if (index >= _listFriend.length) {
                  _listFriend.addAll(generateWordPairs().take(10)); /*4*/
                }
                return _buildListFriend(_listFriend[index]);
              }),
        )
      ],
    ));
  }
}

class NotificationPage extends StatelessWidget {
  final _listNotified = <WordPair>[];
  var random = new Random();

  Widget _buildListNotified(WordPair pair) {
    return ListTile(
      title: Container(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('images/user.jpg'))),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          pair.asPascalCase,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Text(' ???? th??ch b??i vi???t c???a b???n')
                      ],
                    ),
                  ),
                  Text(
                    random.nextInt(24).toString() + ' ph??t tr?????c',
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      trailing: IconButton(
          onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildtitle('Th??ng b??o'),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemBuilder: /*1*/ (context, i) {
                if (i.isOdd) return const Divider(); /*2*/
                final index = i ~/ 2; /*3*/
                if (index >= _listNotified.length) {
                  _listNotified.addAll(generateWordPairs().take(10)); /*4*/
                }
                return _buildListNotified(_listNotified[index]);
              }),
        )
      ],
    ));
  }
}

class Profile extends StatelessWidget {
  Widget _buildRowProfile(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 16, 0, 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              icon,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        automaticallyImplyLeading: false,
        title: Center(
          child: Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('images/user.jpg'), fit: BoxFit.cover)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRowProfile(Icons.person, 'H??? v?? t??n: Hu???nh T???n ?????t'),
            _buildRowProfile(Icons.today, 'Ng??y sinh: 08/02/1997'),
            _buildRowProfile(Icons.wc, 'Gi???i t??nh: Nam'),
            _buildRowProfile(
                Icons.room, '?????a ch???: 23/6 ???????ng s??? 2, Tr?????ng Th???, Th??? ?????c'),
            _buildRowProfile(Icons.mail, 'Email: 0306191207@caothang.edu'),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.edit,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      ),
    );
  }
}

class Security extends StatelessWidget {
  Widget _titlePolicy(String text) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
        softWrap: true,
      ),
    );
  }

  Widget _contentPolicy(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 0, 20, 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ch??nh s??ch'),
        ),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const Text(
            'Ch??ng t??i thu th???p nh???ng lo???i th??ng tin n??o? ',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _titlePolicy(
                'Nh???ng ho???t ?????ng v?? th??ng tin do b???n v?? ng?????i kh??c th???c hi???n/cung c???p.'),
            _contentPolicy(
                'Th??ng tin v?? n???i dung b???n cung c???p. Ch??ng t??i thu th???p n???i dung'
                'th??ng tin li??n l???c v?? c??c th??ng tin kh??c m?? b???n cung c???p khi s??? d???ng.'
                'S???n ph???m c???a ch??ng t??i, bao g???m c??? khi b???n ????ng k?? m???t t??i kho???n,'
                't???o ho???c chia s??? n???i dung v?? nh???n tin hay li??n l???c v???i ng?????i kh??c.'
                'C??c th??ng tin n??y c?? th??? bao g???m th??ng tin trong ho???c v??? n???i dung b???n'
                'cung c???p (v?? d??? si??u d??? li???u), ch???ng h???n nh?? ?????a ??i???m ch???p ???nh ho???c ng??y'
                't???o t???p. Th??ng tin n??y c??ng c?? th??? bao g???m n???i dung b???n nh??n th???y th??ng'
                'qua c??c t??nh n??ng ch??ng t??i cung c???p, ch???ng h???n nh?? t??nh n??ng m??y ???nh,'
                '????? ch??ng t??i c?? th??? th???c hi???n nh???ng vi???c nh?? ????? xu???t m???t n??? v?? b??? l???c m??'
                'b???n c?? th??? th??ch ho???c cung c???p cho b???n m???o s??? d???ng c??c ?????nh d???ng c???a m??y ???nh.'
                'C??c h??? th???ng c???a ch??ng t??i t??? ?????ng x??? l?? n???i dung c??ng nh?? th??ng tin li??n'
                'l???c m?? b???n v?? ng?????i kh??c cung c???p ????? ph??n t??ch ng??? c???nh v?? ?? ngh??a cho c??c'
                'm???c ????ch ???????c m?? t??? b??n d?????i. H??y t??m hi???u th??m v??? c??ch ki???m so??t nh???ng '
                ' ai c?? th??? xem n???i dung m?? b???n chia s???.'),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _titlePolicy('Th??ng tin thi???t b???'),
            _contentPolicy(
                'Nh?? m?? t??? b??n d?????i, ch??ng t??i thu th???p th??ng tin t??? v?? v??? m??y t??nh, ??i???n tho???i,'
                'TV ???????c k???t n???i c??ng nh?? c??c thi???t b??? k???t n???i web kh??c m?? b???n s??? d???ng ????? t??ch'
                ' h???p v???i S???n ph???m c???a ch??ng t??i. Ch??ng t??i c??ng k???t h???p th??ng tin n??y tr??n c??c'
                'thi???t b??? kh??c nhau m?? b???n s??? d???ng. V?? d???: ch??ng t??i s??? d???ng th??ng tin thu th???p '
                '???????c v??? c??ch b???n s??? d???ng S???n ph???m c???a ch??ng t??i tr??n ??i???n tho???i ????? c?? nh??n h??a '
                't???t h??n n???i dung (bao g???m qu???ng c??o) ho???c t??nh n??ng b???n th???y khi s??? d???ng S???n ph???m '
                'c???a ch??ng t??i tr??n m???t thi???t b??? kh??c, ch???ng h???n nh?? m??y t??nh x??ch tay/m??y t??nh b???ng,'
                ' ho???c ????? ??o l?????ng xem b???n c?? th???c hi???n h??nh ?????ng ?????i v???i qu???ng c??o m?? ch??ng t??i hi???n '
                'th??? cho b???n tr??n ??i???n tho???i hay m???t thi???t b??? kh??c hay kh??ng.')
          ])
        ]));
  }
}

Widget _buildUser(WordPair pair, String text) {
  return Container(
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/user.jpg'))),
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
              Text(
                text,
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildtitle(String text) {
  return Container(
    height: 40,
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
  );
}
