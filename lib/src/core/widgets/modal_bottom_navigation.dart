import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/home/provider/home_provider.dart';

class ModalBottomNavigation extends StatefulWidget {
  ModalBottomNavigation({Key? key}) : super(key: key);

  @override
  State<ModalBottomNavigation> createState() => _ModalBottomNavigationState();
}

class _ModalBottomNavigationState extends State<ModalBottomNavigation> {
  TextEditingController _textFieldController = TextEditingController();

  bool _isAreaShareCodeShow = false;

  void _toggleAreaShareCode() {
    setState(() {
      _isAreaShareCodeShow = !_isAreaShareCodeShow;
    });
  }

  final GlobalKey _expansionTile = new GlobalKey();

  Future<void> _getQuiz() async {
    try {
      final code = _textFieldController.text.toString();
      
      final idQuiz = await Provider.of<HomeProvider>(context, listen: false)
      .getQuiz(code);


      // todo: go to quiz

      // go to quiz {idQuiz}
      Navigator.of(context).pop();
      _textFieldController.clear();
      
    } catch (e) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // padding: EdgeInsets.all(10),
      children: [
        ListTile(
          leading: Icon(Icons.post_add),
          title: Text("Create test"),
          onTap: () {
            Navigator.of(context).pushNamed(CreateQuizScreen.routeName);
          },
        ),
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ExpansionTile(
            // enabled: true,
            key: _expansionTile,
            initiallyExpanded: _isExpanded,

            leading: Icon(Icons.add_link),
            title: Text("Get test by id"),
            // onTap: () {
            //   _toggleAreaShareCode();
            // },
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _textFieldController,
                      decoration:
                          InputDecoration(labelText: "Insert your code here"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => _getQuiz(),
                          child: Text("Add"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            // onExpansionChanged: (value) =>
          ),
        ),
      ],
    );
  }
}
