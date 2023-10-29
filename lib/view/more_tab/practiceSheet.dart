import 'dart:developer';

import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/utils/constantWidget.dart';
import 'package:ebook_app/view/more_tab/vocabTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PracticeSheet extends StatefulWidget {
  PracticeSheet({super.key, required this.practiceString});

  final String practiceString;
  List<String> missingElements = [];

  @override
  State<PracticeSheet> createState() => _PracticeSheetState();
}

class _PracticeSheetState extends State<PracticeSheet> {
  // List<T> findMissingElements<T>(List<T> list1, List<T> list2) {
  //   List<T> missingElements = [];
  //
  //   for (T element in list2) {
  //     if (!list1.contains(element)) {
  //       missingElements.add(element);
  //     }
  //   }
  //   for (T element in list1) {
  //     if (!list2.contains(element)) {
  //       missingElements.add(element);
  //     }
  //   }
  //   log("missing elements" + missingElements.toString());
  //
  //   return missingElements;
  // }
  //
  // String highlightDifference(String actual, String pronounced) {
  //   List<String> actualWords = actual.split(" ");
  //   List<String> pronouncedWords = pronounced.split(" ");
  //
  //   String highlightedText = "";
  //
  //   // for (int i = 0; i < pronouncedWords.length; i++) {
  //   //   String word = pronouncedWords[i];
  //   // if (i ) {
  //   widget.missingElements = findMissingElements(actualWords, pronouncedWords);
  //   // }
  //   // else {
  //   //   highlightedText += ' $word';
  //   // }
  //   // }
  //   // log("highlighted Text"+highlightedText.trim());
  //
  //   return highlightedText.trim();
  // }

  final TextEditingController practiceText = TextEditingController();

  // final TextEditingController recognizedText = TextEditingController();
  FlutterTts flutterTts = FlutterTts();

  void speak(String textToBeSpeeched) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0); // Adjust pitch if needed
    await flutterTts.speak(textToBeSpeeched);
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      default:
        requestForPermission();
        break;
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    practiceText.text = widget.practiceString;
    // highlightDifference("I am good","I am gut");
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  List<String> mistakesList = [];

  /// Each time to start a speech recognition session
  void _startListening() async {
    // recognizedText.clear();
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    // recognizedText.clear();
    await _speechToText.stop();
    setState(() {});
    // highlightDifference(practiceText.text, recognizedText.text);
  }

  String capitalizeFirstWord(String text) {
    if (text.isNotEmpty) {
      List<String> words = text.split(" ");
      if (words.isNotEmpty) {
        words[0] = words[0][0].toUpperCase() + words[0].substring(1);
        return words.join(" ");
      }
    }
    return text;
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = "";
    // result.recognizedWords.
    setState(() {
      // recognizedText.clear();
      // recognizedText.text = "";
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _lastWords = capitalizeFirstWord(_lastWords);

      // recognizedText.text = _lastWords;
    });
    log("last words" + _lastWords);
  }

  List<InlineSpan> highlightDifferences(String text1, String text2) {
    text1 = text1.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    text2 = text2.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    List<String> words1 = text1.split(" ");
    List<String> words2 = text2.split(" ");

    List<InlineSpan> formattedText = [];
    mistakesList.clear();

    for (String word1 in words1) {
      if (words2.contains(word1)) {
        formattedText
            .add(TextSpan(text: word1, style: TextStyle(color: Colors.black)));
      } else {
        formattedText
            .add(TextSpan(text: word1, style: TextStyle(color: Colors.red)));
        mistakesList.add(word1);
      }
      formattedText.add(TextSpan(text: " "));
    }

    return formattedText;
  }

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> highLightText =
        highlightDifferences(practiceText.text, _lastWords);

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              getCustumAppbar(
                  rightPermission: false,
                  leftIcon: Get.isDarkMode
                      ? "left_arrow_white.svg"
                      : "back_arrow.svg",
                  title: "Practice Sheet",
                  leftFunction: () {
                    // backClick()
                    Get.back();
                    HomeMainScreenController mainScreenController = Get.find();
                    mainScreenController.onChange(2.obs);
                  },
                  givecolor: context.theme.focusColor,
                  titlecolor: context.theme.primaryColor),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      getVerSpace(20.h),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Practice Text",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            15.h.verticalSpace,
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: context.theme.primaryColor,
                                  // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8.0)), // Border radius
                              ),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: practiceText,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: 'Type your text here...',
                                      contentPadding: EdgeInsets.all(10.0),
                                      // Padding inside the TextField
                                      border: InputBorder
                                          .none, // Remove the default TextField border
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          speak(practiceText.text);
                                        },
                                        child: Icon(
                                          Icons.volume_down,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      getVerSpace(20.h),
                      Visibility(
                        visible: _lastWords != "",
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recognized Text",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              15.h.verticalSpace,
                              Container(
                                width: 1.sw,
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.theme.primaryColor,
                                    // Border color
                                    width: 1.0, // Border width
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.0)), // Border radius
                                ),
                                child: Text(_lastWords),
                              ),
                            ],
                          ),
                        ),
                      ),
                      getVerSpace(20.h),
                      Visibility(
                        visible: practiceText.text != "" && _lastWords != "",
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mistakes",
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            VocabTab(mistakes: mistakesList));
                                      },
                                      child: Container(
                                        height: 0.04.sh,
                                        width: 0.4.sw,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade500,
                                          border: Border.all(
                                              color: Colors.black, width: 2.w),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              15.sp,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Add to Vocab",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                15.h.verticalSpace,
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.theme.primaryColor,
                                      // Border color
                                      width: 1.0, // Border width
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8.0)), // Border radius
                                  ),
                                  child: Column(
                                    children: [
                                      SelectableText.rich(
                                        TextSpan(children: highLightText),
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     InkWell(
                                      //       onTap: () {
                                      //         speak(practiceText.text);
                                      //       },
                                      //       child: Icon(
                                      //         Icons.volume_down,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          backgroundColor: Colors.blueGrey,
          child: Ink(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _speechToText.isNotListening
                  ? Colors.blueGrey
                  : Colors.blue, // Change the color for listening state
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
