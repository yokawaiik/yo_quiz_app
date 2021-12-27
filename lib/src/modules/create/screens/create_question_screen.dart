import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

class CreateQuestionScreen extends StatefulWidget {
  static const String routeName = "/create-question";

  CreateQuestionScreen({Key? key}) : super(key: key);

  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  late final GlobalKey<FormState> _form;
  late bool _questionHasTimer;
  late List<Answer> _answers;

  @override
  void initState() {
    _form = GlobalKey<FormState>();
    _questionHasTimer = false;
    _answers = [];

    super.initState();
  }

  void _addAnswer() {
    // Todo:
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        actions: [
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever)),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Question text"),
                ),
                SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Does this question has timer?"),
                  value: _questionHasTimer,
                  onChanged: (v) {
                    setState(() {
                      _questionHasTimer = v!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _questionHasTimer
                      ? Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Seconds in timer"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAnswer,
        child: Icon(Icons.question_answer),
      ),
    );
  }

  
}
