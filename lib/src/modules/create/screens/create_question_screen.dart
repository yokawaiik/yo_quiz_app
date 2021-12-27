import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

import '../constants/constants.dart' as constants;

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
    if (_answers.length == constants.MAX_ANSWERS_COUNT) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No more 10 answers")));
    } else {
      setState(() {
      
        _answers.add(Answer(id: UniqueKey().toString()));
      });
    }
  }

  void _toggleAnswer(int index) {
    setState(() {
      _answers[index].isRight = !_answers[index].isRight;
    });
  }

  void _removeAnswer(String id) {
    setState(() {
      _answers.removeWhere((answer) => answer.id == id);
    });
  }

  void _createQuestion() {
    if (!_form.currentState!.validate()) return;

    _form.currentState!.save();

    // todo: create answer in provider

    Navigator.of(context).pop();
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _answers.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (_, i) => Container(
                    key: Key(_answers[i].id),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      initialValue: _answers[i].text,
                      onChanged: (v) {
                        _answers[i].text = v;
                      },
                      validator: (v) {
                        if (v == null ||  v.isEmpty ) return "Answer must be fill.";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Write this your answer $i",
                        suffixIcon: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                color: _answers[i].isRight
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                icon: _answers[i].isRight
                                    ? Icon(Icons.check)
                                    : Icon(Icons.close),
                                onPressed: () {
                                  _toggleAnswer(i);
                                },
                              ),
                              IconButton(
                                color: Theme.of(context).colorScheme.primary,
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _removeAnswer(_answers[i].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _addAnswer,
                    child: Text(
                      "Add Answer",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addAnswer,
      //   child: Icon(Icons.question_answer),
      // ),
    );
  }
}
