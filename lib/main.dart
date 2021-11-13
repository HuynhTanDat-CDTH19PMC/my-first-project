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
                    'Huỳnh Tấn Đạt',
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
        _buildUser(pair, random.nextInt(24).toString() + ' giờ trước'),
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
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            _buildtitle('Bảng tin'),
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
      title: _buildUser(pair, random.nextInt(100).toString() + ' bạn chung'),
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
            alreadySaved ? 'Kết bạn' : 'Hủy kết bạn',
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildtitle('Danh sách bạn bè'),
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
                        const Text(' đã thích bài viết của bạn')
                      ],
                    ),
                  ),
                  Text(
                    random.nextInt(24).toString() + ' phút trước',
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
        _buildtitle('Thông báo'),
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
            _buildRowProfile(Icons.person, 'Họ và tên: Huỳnh Tấn Đạt'),
            _buildRowProfile(Icons.today, 'Ngày sinh: 08/02/1997'),
            _buildRowProfile(Icons.wc, 'Giới tính: Nam'),
            _buildRowProfile(
                Icons.room, 'Địa chỉ: 23/6 đường số 2, Trường Thọ, Thủ Đức'),
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
          title: const Text('Chính sách'),
        ),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const Text(
            'Chúng tôi thu thập những loại thông tin nào? ',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _titlePolicy(
                'Những hoạt động và thông tin do bạn và người khác thực hiện/cung cấp.'),
            _contentPolicy(
                'Thông tin và nội dung bạn cung cấp. Chúng tôi thu thập nội dung'
                'thông tin liên lạc và các thông tin khác mà bạn cung cấp khi sử dụng.'
                'Sản phẩm của chúng tôi, bao gồm cả khi bạn đăng ký một tài khoản,'
                'tạo hoặc chia sẻ nội dung và nhắn tin hay liên lạc với người khác.'
                'Các thông tin này có thể bao gồm thông tin trong hoặc về nội dung bạn'
                'cung cấp (ví dụ siêu dữ liệu), chẳng hạn như địa điểm chụp ảnh hoặc ngày'
                'tạo tệp. Thông tin này cũng có thể bao gồm nội dung bạn nhìn thấy thông'
                'qua các tính năng chúng tôi cung cấp, chẳng hạn như tính năng máy ảnh,'
                'để chúng tôi có thể thực hiện những việc như đề xuất mặt nạ và bộ lọc mà'
                'bạn có thể thích hoặc cung cấp cho bạn mẹo sử dụng các định dạng của máy ảnh.'
                'Các hệ thống của chúng tôi tự động xử lý nội dung cũng như thông tin liên'
                'lạc mà bạn và người khác cung cấp để phân tích ngữ cảnh và ý nghĩa cho các'
                'mục đích được mô tả bên dưới. Hãy tìm hiểu thêm về cách kiểm soát những '
                ' ai có thể xem nội dung mà bạn chia sẻ.'),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _titlePolicy('Thông tin thiết bị'),
            _contentPolicy(
                'Như mô tả bên dưới, chúng tôi thu thập thông tin từ và về máy tính, điện thoại,'
                'TV được kết nối cũng như các thiết bị kết nối web khác mà bạn sử dụng để tích'
                ' hợp với Sản phẩm của chúng tôi. Chúng tôi cũng kết hợp thông tin này trên các'
                'thiết bị khác nhau mà bạn sử dụng. Ví dụ: chúng tôi sử dụng thông tin thu thập '
                'được về cách bạn sử dụng Sản phẩm của chúng tôi trên điện thoại để cá nhân hóa '
                'tốt hơn nội dung (bao gồm quảng cáo) hoặc tính năng bạn thấy khi sử dụng Sản phẩm '
                'của chúng tôi trên một thiết bị khác, chẳng hạn như máy tính xách tay/máy tính bảng,'
                ' hoặc để đo lường xem bạn có thực hiện hành động đối với quảng cáo mà chúng tôi hiển '
                'thị cho bạn trên điện thoại hay một thiết bị khác hay không.')
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
