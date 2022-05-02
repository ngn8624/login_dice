import 'package:flutter/material.dart';
import 'dice.dart';

void main() {
  // 한번 초기화 하면 못바뀜
  final int myFinal = 30; // 런타임
  const int myConst = 70; // 컴파일
  // final 변수는 바뀌었고 그것을 적용하려면 rebuild 되어야한다.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController dController = TextEditingController();
  TextEditingController pController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      // overflow 방지
      // 키보드 올라와도 스크롤 가능
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // 빈화면 누르면 키보드 사라짐
          },
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(padding: EdgeInsets.all(10)),
              Center(
                  child: Image(
                      image: AssetImage('image/chef.gif'),
                      width: 170.0,
                      height: 190.0)),
              Form(
                child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.teal,
                            fontSize: 15.0,
                          ),
                        )),
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          TextField(
                            //autofocus: true,
                            controller: dController,
                            decoration: InputDecoration(
                              labelText: 'Enter "Dice"',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: pController,
                            decoration: InputDecoration(
                              labelText: 'Enter Password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 문자 가리기
                          ),
                          SizedBox(height: 10.0),
                          ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: ElevatedButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    primary: Color.fromARGB(255, 210, 169, 82),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                onPressed: () {
                                  if (dController.text == 'dice' &&
                                      pController.text == '1234') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Dice()));
                                  } else if (dController.text != 'dice' &&
                                      pController.text == '1234') {
                                    debugPrint('아이디가 틀렸어요');
                                    showSnackBar3(context);
                                  } else if (dController.text == 'dice' &&
                                      pController.text != '1234') {
                                    debugPrint('비밀번호가 틀렸어요');
                                    showSnackBar2(context);
                                  } else {
                                    debugPrint('정확하게 입력하세요');
                                    showSnackBar1(context);
                                  }
                                },
                              ))
                        ],
                      ),
                    )),
              )
            ]),
          ),
        );
      }),
    );
  }
}

void showSnackBar1(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '로그인 정보를 다시 확인하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackBar2(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '비밀정보가 일치하지 않습니다',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackBar3(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      'dice의 철자를 확인하세요',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}


// focus
// focusNode: 포커스를 받는 특정 위젯을 식별
// FocusScope : 어떤 위젯들까지 포커스를 받는지 범위를 나타냄