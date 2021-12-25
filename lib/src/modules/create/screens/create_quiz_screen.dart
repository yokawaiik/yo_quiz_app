import 'package:flutter/material.dart';

class CreateQuizScreen extends StatefulWidget {
  static const String routeName = "/create-quiz-screen";

  CreateQuizScreen({Key? key}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  late bool _quizHasTimer;

  @override
  void initState() {
    super.initState();

    _quizHasTimer = false;
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;


    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(icon: Icon(Icons.arr), onPressed: () {  },)
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Create Question",
                    ),
                  )
                ],
              ),
              
              Form(
                child: Padding(
                  
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Image for your quiz"),
                      SizedBox(
                        height: 10,
                      ),
                      // Todo: add image
                      Container(
                        height: device.height * (2/7),
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Title"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(labelText: "Description"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Count questions"),
                      ),
                      // Switch(value: false, onChanged: (bool v) {})
                      // Checkbox(value: _quizHasTimer, onChanged: (v) {
                      //   setState(() {
                      //     _quizHasTimer = v!;
                      //   });
                      // }),
                      SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text("Does Quiz has been timer?"),
                          value: _quizHasTimer,
                          onChanged: (v) {
                            setState(() {
                              _quizHasTimer = v!;
                            });
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
