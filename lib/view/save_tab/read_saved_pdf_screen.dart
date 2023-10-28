// ignore: unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:pdfx/pdfx.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';
import '../home_tab/trending_books/read_book_screen.dart';

// ignore: must_be_immutable
class ReadSavedBookScreen extends StatefulWidget {

  String filePath;

  ReadSavedBookScreen({super.key, required this.filePath});
  // const ReadSavedBookScreen({Key? key}) : super(key: key);

  @override
  State<ReadSavedBookScreen> createState() => _ReadSavedBookScreenState();
}

class _ReadSavedBookScreenState extends State<ReadSavedBookScreen> {


  // PdfControllerPinch? pdfPinchController;


  void backClick() {
    Constant.backToFinish();
  }


  @override
  void initState() {
    super.initState();

    // pdfPinchController = PdfControllerPinch(
    //   document: PdfDocument.openFile(widget.filePath),
    // );

  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);


    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: Column(
              children: [
                getCustumAppbar(
                    leftIcon: Get.isDarkMode?"left_arrow_white.svg":"back_arrow.svg",
                    title: widget.filePath.split("/").last,
                    rightPermission: false,
                    leftFunction: () {
                      backClick();
                    },
                    givecolor: context.theme.focusColor,
                    titlecolor: context.theme.primaryColor),
                getVerSpace(20.h),
                Expanded(
                  child: Container(
                    height: 500.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // physics: BouncingScrollPhysics(),
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //
                        //   child: PdfViewPinch(
                        //     controller: pdfPinchController!,
                        //     onPageChanged: (page) {
                        //
                        //     },
                        //     builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                        //       options: const DefaultBuilderOptions(
                        //         loaderSwitchDuration: Duration(seconds: 1),
                        //         transitionBuilder: SomeWidget.transitionBuilder,
                        //       ),
                        //       documentLoaderBuilder: (context) =>
                        //           getLottieAnimationWidget(),
                        //       pageLoaderBuilder: (context) =>
                        //           getLottieAnimationWidget(),
                        //       errorBuilder: (context, error) => Center(child: Text(error.toString())),
                        //       builder: SomeWidget.builder,
                        //     ),
                        //   )
                        //
                        //   // SfPdfViewer.file(
                        //   //   File(widget.filePath),
                        //   //   enableDoubleTapZooming: true,
                        //   // ),
                        // ),

                        // Container(
                        //   color: context.theme.focusColor,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       getCustomFont("Chapter 1", 16.sp, context.theme.primaryColor, 1,
                        //           fontWeight: FontWeight.w700),
                        //   Html(
                        //     data: htmlData,
                        //     tagsList: Html.tags,
                        //
                        //     style: {
                        //
                        //       'h1': Style(fontWeight: FontWeight.w400,fontSize: FontSize(16.sp),fontFamily: Constant.fontsFamily,color: context.theme.primaryColor),
                        //     },
                        //   ),
                        //
                        //     ],
                        //   ).paddingSymmetric(vertical: 20.h, horizontal: 20.h),
                        // ),
                        Text(widget.filePath.toString()),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
//    String htmlData = r"""
//       <h1>It’s the summer of 2015, and Alice Quick needs to get to work. She’s twenty-eight years old, grieving her mother, barely scraping by as a nanny, and freshly kicked out of her apartment.</h1>
//       <h1>If she can just get her act together and sign up for the MCAT, she can start chasing her dream of becoming a doctor . . . but in the Age of Distraction, the distractions are so distracting.</h1>
//       <h1>Roxy said one of those was perfect.</h1>
//       <h1>"Which one?" he asked. "Roxy?"</h1>
//       <h1>Roxy looked up from her phone. "Yes, Kervis?"</h1>
//       <h1>"Which one was perfect?"</h1>
// <h1>"From within the story of one summer in one woman’s life, an epic tale is unearthed, spanning continents and featuring a tapestry of characters tied to one another by threads both seen and unseen."</h1>
// <h1>""Anyhoo," he said, "I should get down there. Sounds like the big guy's in a mood. This might go late. Are you okay sticking around?"</h1>
//   <h1>"Which one was perfect?"</h1>
//       <h1>"From within the story of one summer in one woman’s life, an epic tale is unearthed, spanning continents and featuring a tapestry of characters tied to one another by threads both seen and unseen."</h1>
//       <h1>'"Anyhoo," he said, "I should get down there. Sounds like the big guy's in a mood. This might go late. Are you okay sticking around?"'</h1>
//       <h1>"Then she felt an urge. Maybe the big blueberry eyes of the Chihuahuas stirred some..."</h1>
//
//       """;
}