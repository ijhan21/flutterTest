import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listview_example/animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal>? animalList;

  const CupertinoSecondPage({Key? key, required this.animalList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CupertinoSecondPage();
  }
}

class _CupertinoSecondPage extends State<CupertinoSecondPage> {
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text(
        '양서류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    1: SizedBox(
      child: Text(
        '포유류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    2: SizedBox(
      child: Text(
        '파충류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              CupertinoSegmentedControl(
                children: segmentWidgets,
                // groupValue: _kindChoice, 이거 빼먹으니 기본값 표시가 안됐다
                groupValue: _kindChoice,
                onValueChanged: (int value) {
                  setState(() {
                    _kindChoice = value;
                  });
                },
                padding: EdgeInsets.only(bottom: 20, top: 20),
              ),
              Row(children: <Widget>[
                Text('날개가 존재합니까?'),
                CupertinoSwitch(
                    value: _flyExist,
                    onChanged: (value) {
                      setState(() {
                        _flyExist = value;
                      });
                    })
              ], mainAxisAlignment: MainAxisAlignment.center),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/cow.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/cow.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/pig.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/pig.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/bee.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/bee.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/cat.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/cat.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/fox.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/fox.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/monkey.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/monkey.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/wolf.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/wolf.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/dog.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/dog.png';
                      },
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Text('동물 추가하기'),
                  color: Colors.amber,
                  onPressed: () {
                    widget.animalList?.add(
                      Animal(
                          animalName: _textController?.value.text,
                          kind: getKind(_kindChoice),
                          imagePath: _imagePath,
                          flyExist: _flyExist),
                    );
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Cupertino'),
                            content: Text('Cupertino 스타일의 위젯입니다.'),
                            actions: [
                              CupertinoButton(
                                  child: Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  }),
              CupertinoButton(child: Text('ActionSheet'), color: Colors.green,onPressed: (){
                showCupertinoModalPopup(context: context, builder: (context){
                  return CupertinoActionSheet(
                    title: Text('Action'),
                    message: Text('좋아하는 색은?'),
                    actions: [
                      CupertinoButton(child: Text('빨강'),color: Colors.red, onPressed: (){}),
                      CupertinoButton(child: Text('파랑'),color: Colors.blue, onPressed: (){}),
                    ],
                    cancelButton: CupertinoButton(child: Text('취소'),onPressed: (){
                      Navigator.of(context).pop();
                    },),
                  );
                });
              })
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "포유류";
      case 2:
        return "파충류";
    }
  }
}
