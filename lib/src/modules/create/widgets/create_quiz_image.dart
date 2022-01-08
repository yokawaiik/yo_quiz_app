import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/ui_quiz_create_provider.dart';

class CreateQuizImage extends StatefulWidget {
  final double? height;

  const CreateQuizImage({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  _CreateQuizImageState createState() => _CreateQuizImageState();
}

class _CreateQuizImageState extends State<CreateQuizImage> {
  File? _quizImage;
  String? _quizImageUrl;

  @override
  void initState() {
    super.initState();

    
  }

  Future<void> _loadInitialImage() async {
    final uIQuizCreateProvider = Provider.of<UIQuizCreateProvider>(context, listen: false);
    // print("_loadInitialImage");
    await uIQuizCreateProvider.createQuizProvider.loadQuizImage();
    _quizImageUrl = uIQuizCreateProvider.createQuizProvider.quizImage;
  }

  
  Future<void> _uploadQuizImage() async {
    final picker = ImagePicker();

    final imagePicked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imagePicked == null) return;

    final uIQuizCreateProvider = Provider
    .of<UIQuizCreateProvider>(context, listen: false);

    uIQuizCreateProvider.createQuizProvider.quizImage = imagePicked.path;
    await uIQuizCreateProvider.createQuizProvider.uploadQuizImage();

    setState(() {
      _quizImage = File(imagePicked.path);
    });
  }

  Widget _imageBuilder() {
    late ImageProvider<Object> image;
    if (_quizImage != null) {
      image = FileImage(_quizImage!);
    } else {
      image = NetworkImage(_quizImageUrl!);
    }

    return Image(
      image: image,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => _dummyBuilder(),
    );
  }

  Widget _dummyBuilder() {


    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Icon(
          Icons.image,
          size: 100,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _uploadQuizImage();
      },
      // child: Text("image todo"),
      child: SizedBox(
        height: widget.height,
        child: FutureBuilder(
          future: _loadInitialImage(),
          builder: (_, snapshot) => ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: (_quizImage != null || _quizImageUrl != null)
                ? _imageBuilder()
                : _dummyBuilder(),
          ),
        ),
      ),
    );
  }
}
