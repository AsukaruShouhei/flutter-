import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //httpリクエスト用
import 'dart:async'; //非同期処理用
import 'dart:convert'; //httpレスポンスをJSON形式に変換用


// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FuriFuri TOP',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('FRIFRI'),
//           leading: Center(
//             child: Icon(Icons.star, color: Colors.green),
//           ),
//         ),
//         body: Center(
//           child: Text('FRIF'),
//         ),
//       ),
//     );
//   }
// }


void main() { // main.dartは基本これだけを呼ぶ
  runApp(MaterialApp( // runAppにはStatelessWidget or StatefullWidgetを継承したものを渡す
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: HomePage(),  //homeで、ルーティング情報ここにかいてく。
  ));
}

// HomePage Class => HomePageState
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// HomePageState Class
class _HomePageState extends State<HomePage> {
  
  Map data;
  List useData;
  
  // 非同期処理は、デフォルトでは呼び出し元は処理の完了をまたないが、awaitキーワードをつけると完了を
  // 待つことができるらしい
  Future getData() async {
    http.Response response = await http.get("https://reqres.in/api/users?page=2");
    // とってきたデータを格納する
    data = json.decode(response.body); // json->Mapオブジェクトに格納
    setState(() {
      useData = data['data']; // Map -> Listに必要な情報だけを格納 サイトではuserDataだが宣言はuseDataになっているので注意
    });
  }
  
  
  @override
  void initState(){
    super.initState(); // 初期化
    getData(); // getData()を呼び出し
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FRIFRI'),
        leading: Icon(Icons.star, color: Colors.green,),
      ),
      body: ListView.builder(
        itemCount: useData == null ? 0 : useData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            // cardデザインを定義
            child: Row(
              children: <Widget>[
                // CircleAvatar(
                //   // ユーザープロフィール画像に使用するクラス　=> 将来的には商品画像
                //   backgroundImage: NetworkImage(useData[index]['avator']),
                // ),
                Text("${useData[index]["first_name"]} ${useData[index]['last_name']}")
              ],
            ),
          ); // Cardはセミコロンで終わっていないとエラー
        },
      ),
    ); //Scaffold() アプリの中身（appbar+title構造）を簡単につくれる
  }
}
