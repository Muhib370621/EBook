import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:ebook_app/ads/AdsFile.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/main.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:ebook_app/view/more_tab/practiceSheet.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../controller/controller.dart';
import '../../../models/book_list_model.dart';
import '../../../utils/color_category.dart';
import '../../../utils/constant.dart';
import '../../../utils/constantWidget.dart';

// ignore: must_be_immutable
class ReadBookScreen extends StatefulWidget {
  StoryModel storyModel;

  ReadBookScreen({super.key, required this.storyModel});

  // const ReadBookScreen({Key? key}) : super(key: key);

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<ReadBookScreen> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  TextEditingController searchController = TextEditingController();

  // PdfControllerPinch? pdfPinchController;

  addViewStory() {
    Future.delayed(Duration.zero, () async {
      FireBaseData.addStoryViews(widget.storyModel, context);
    });
  }

  // addViewAuthor() {
  //   DocumentSnapshot doc = FireBaseData.getAuthorById(id: widget.storyModel.authId ?? "");
  //   TopAuthors topAuthors = TopAuthors.fromFirestore(doc);
  //   Future.delayed(Duration.zero, () async {
  //     FireBaseData.addAuthorViews(topAuthors, context);
  //   });
  // }

  ReadBookScreenController readBookScreenController =
      Get.put(ReadBookScreenController());

  void backClick() {
    if (isSearch.value) {
      isSearch.value = false;
    } else {
      Constant.backToFinish();
    }
  }

  List<FileSystemEntity> files = [];

  Future<void> getFiles() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    // var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + Constant.saveDirectory;

    Directory savedDir = Directory(savePath);

    print("saveDir---${savedDir.path}");

    bool isExits = await savedDir.exists();

    if (isExits) {
      print("savedDir----${savedDir.exists().toString()}---");

      var f = savedDir.listSync();

      /// iterate the list to get individual entry.
      files = f.reversed.toList();
      setState(() {});
      print("files----${files.length}---");
    }

    getFileName();
  }

  RxBool isDownloaded = false.obs;
  RxBool isLoading = false.obs;

  Future<void> requestDownload(String url, String name, String image) async {
    final dir =
        await getApplicationDocumentsDirectory(); //From path_provider package
    var localPath = dir.path + Constant.saveDirectory;
    final savedDir = Directory(localPath);

    await savedDir.create(recursive: true).then((value) async {
      // ignore: unused_local_variable
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: name,
        savedDir: localPath,
        showNotification: true,
        openFileFromNotification: false,
      ).then((value) {
        print("value----$value");
      });

      // 56a22093-3d21-43a4-a8b4-54bda81c7763

      // debugPrint(taskId);
    });
  }

  ReceivePort port = ReceivePort();

  getFileName() {
    for (int i = 0; i < files.length; i++) {
      print("i-------$i");

      String basename = files.elementAt(i).path.split("/").last;

      print("basename----$basename");

      if (widget.storyModel.name == basename) {
        isDownloaded.value = true;
        break;
      }
    }
  }

  Future<Uint8List> _downloadPDF(String pdfUrl) async {
    // setState(() {
    isLoading.value = true;
    // });
    final storage = FirebaseStorage.instance;
    final Reference ref = storage.refFromURL(pdfUrl);
    final Uint8List? data = await ref.getData();
    log("data is " + data.toString());
    // setState(() {
    isLoading.value = false;
    // });
    return data!;
  }

  RecentController recentController = Get.put(RecentController());

  // PdfViewerController pdfViewerController = PdfViewerController();
  // PdfTextSearchResult searchResult = PdfTextSearchResult();

  // PdfBookmark? pdfBookmark;
  // PdfViewerController pdfViewerController = PdfViewerController();

  AdsFile adsFile = AdsFile();

  @override
  void initState() {
    super.initState();

    // pdfBookmark = PdfDocument(inputBytes: _pdfBytes).bookmarks.add("tails");
    Future.delayed(
      Duration.zero,
      () {
        adsFile.createRewardedAd();
      },
    );

    getBytes();

    // pdfPinchController = PdfControllerPinch(
    //   document: PdfDocument.openData(InternetFile.get(widget.storyModel.pdf ?? "")),
    // );

    // _pdfViewerController = ;
    // _searchResult = ;

    if (!kIsWeb) {
      getFiles();

      IsolateNameServer.registerPortWithName(
          port.sendPort, 'downloader_send_port');
      port.listen((dynamic data) {
        setState(() {});
      });

      FlutterDownloader.registerCallback(downloadCallback);
    }

    PrefData.setRecentReadBook(widget.storyModel.pdf ?? "");
    PrefData.setRecentReadBookName(widget.storyModel.name ?? "");

    recentController.setRecentList(widget.storyModel.id.toString());

    addViewStory();

    // addViewAuthor();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  // @pragma('vm:entry-point')
  // static void downloadCallback(String id, DownloadTaskStatus status,
  //     int progress) {
  //   final SendPort? send =
  //   IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send!.send([id, status, progress]);
  // }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Uint8List? _pdfBytes;

  OverlayEntry? _overlayEntry;
  final PdfViewerController _pdfViewerController=PdfViewerController();

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: Row(
          children: [
            TextButton(
              child: Text('Copy',
                  style: TextStyle(fontSize: 17, color: Colors.black)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: details.selectedText!));
                _pdfViewerController!.clearSelection();
              },
              // backgroundColor: Colors.white
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
            10.w.horizontalSpace,
            TextButton(
              child: Text('Go to Practice',
                  style: TextStyle(fontSize: 17, color: Colors.black)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: details.selectedText!));
                Get.to(
                    () => PracticeSheet(practiceString: details.selectedText!));
                _pdfViewerController!.clearSelection();
              },
              // backgroundColor: Colors.white
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  void getBytes() async {
    // if(!kIsWeb)
    // {await Firebase.initializeApp();}
    FirebaseStorage storage =
        FirebaseStorage.instanceFor(bucket: 'e-book-a4896.appspot.com');
    // bucket: 'flutterfirebase-6c279.appspot.com');
    Reference pdfRef = storage.refFromURL(widget.storyModel.pdf ?? "");
    // refFromURL('https://firebasestorage.googleapis.com/v0/b/flutterfirebase-6c279.appspot.com/o/GIS.pdf?alt=media&token=51654170-c140-4ffa-ae1a-9fb431d0dee2');//ref('GIS.pdf');
    await pdfRef.getDownloadURL().then((value) => print(""));
    await pdfRef.getData(104857600).then((value) {
      //size mentioned here is max size to download from firebase.
      _pdfBytes = value;

      print("pdfBytes---${_pdfBytes!.length}");
      setState(() {});
    });
  }

  RxBool isSearch = false.obs;

  find() {
    // print("text-----${searchController.text}");
    // searchResult = pdfPinchController.searchText(
    //     searchController.text,
    //     searchOption: TextSearchOption.caseSensitive);
    //
    //
    // print("text-----${searchResult.currentInstanceIndex}");
    //
    // if (kIsWeb) {
    //   setState(() {});
    // } else {
    //   searchResult.addListener(() {
    //     if (searchResult.hasResult) {
    //       setState(() {});
    //     }
    //   });
    // }
  }

  RxBool isPdfLoad = false.obs;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);

    // PdfDocument document =
    // PdfDocument(inputBytes: File(widget.storyModel.pdf ?? "").readAsBytesSync());
    //
    //
    // PdfBookmark bookmark = document.bookmarks.insert(1, 'New Bookmark');
    //
    //
    // bookmark.destination = PdfDestination(document.pages[0], Offset(40, 40));
    //
    //
    // File('output.pdf').writeAsBytes(await document.save());
    //
    // document.dispose();

    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
            child: getDefaultWidget(Column(
          children: [
            // getCustumAppbar(
            //     leftIcon: Get.isDarkMode
            //         ? "left_arrow_white.svg"
            //         : "back_arrow.svg",
            //     rightIcon: Get.isDarkMode
            //         ? "white_download.svg"
            //         : "download_icon.svg",
            //     title: widget.storyModel.name ?? "",
            //     leftFunction: () {
            //       backClick();
            //     },
            //     rightPermission: (!isDownloaded.value && !kIsWeb),
            //     rightFunction: () async {
            //       print("called0------Download");
            //
            //       requestDownload(widget.storyModel.pdf ?? "",
            //           widget.storyModel.name ?? "");
            //
            //       // downloadFile();
            //       // downloadFile(0,widget.storyModel.pdf ?? "",1);
            //     },
            //     givecolor: context.theme.focusColor,
            //     titlecolor: context.theme.primaryColor),

            Container(
              color: context.theme.focusColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        backClick();
                      },
                      child: getSvgImage(Get.isDarkMode
                          ? "left_arrow_white.svg"
                          : "back_arrow.svg")),

                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: getCustomFont(
                              widget.storyModel.name ?? "",
                              24.sp,
                              Get.isDarkMode ? regularWhite : regularBlack,
                              2,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                      onTap: () {
                        Future.delayed(
                          Duration.zero,
                          () {
                            adsFile.createRewardedAd();
                          },
                        );

                        Get.dialog(
                            barrierDismissible: false,
                            AlertDialog(
                              backgroundColor:
                                  context.theme.dialogBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    getProgressWidget(context),
                                    getCustomFont("Ads Loading...", 18.sp,
                                        context.theme.primaryColor, 1)
                                  ],
                                ),
                              ),
                            ));

                        Timer(Duration(seconds: 3), () {
                          Constant.backToFinish();

                          // requestDownload(widget.storyModel.pdf ?? "",
                          //     widget.storyModel.name ?? "",widget.storyModel.image ?? "");
                          Future.delayed(
                            Duration.zero,
                            () {
                              adsFile.showRewardedAd(() {
                                requestDownload(
                                    widget.storyModel.pdf ?? "",
                                    widget.storyModel.name ?? "",
                                    widget.storyModel.image ?? "");
                              }, () {});
                            },
                          );
                        });
                      },
                      child: getSvgImage("download.svg",
                          height: 24.h,
                          width: 24.h,
                          color: Get.isDarkMode ? regularWhite : regularBlack))
                  // },child: Icon(Icons.file_download_outlined,color: context.theme.primaryColor,size: 28.h,))

                  // PopupMenuButton(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //         BorderRadius.circular(12.h)),
                  //     child: getSvgImage("mor_vert_rounded.svg",
                  //         height: 24.h, width: 24.h),
                  //     itemBuilder:
                  //         (BuildContext context) =>
                  //     <PopupMenuEntry>[
                  //       // PopupMenuItem(
                  //       //   value: 1,
                  //       //   child: GestureDetector(
                  //       //       onTap: () {
                  //       //
                  //       //         Constant.backToFinish();
                  //       //
                  //       //         isSearch.value = true;
                  //       //
                  //       //         // Constant.sendToNext(context, Routes.editCategoriesScreenRoute);
                  //       //       },
                  //       //       child: getCustomFont("Find...", 16.sp,
                  //       //           context.theme.primaryColor, 1,
                  //       //           fontWeight: FontWeight.w500)
                  //       //   ),
                  //       // ),
                  //       PopupMenuItem(
                  //         value: 2,
                  //         child: GestureDetector(
                  //             onTap: () {
                  //
                  //               Constant.backToFinish();
                  //
                  //               if(networkManager.isNetwork.value){
                  //                 adsFile.showRewardedAd((){
                  //                   requestDownload(widget.storyModel.pdf ?? "",
                  //                       widget.storyModel.name ?? "");
                  //                 }, (){});
                  //               }else{
                  //                 showCustomToast(message: "Please connect to Internet");
                  //               }
                  //
                  //
                  //
                  //
                  //               // getDeleteDialogueFormate("Are you sure you want to delete category!",context.theme.primaryColor, (){}, (){backClick();});
                  //             },
                  //             child: getCustomFont("Download", 16.sp,
                  //                 context.theme.primaryColor, 1,
                  //                 fontWeight: FontWeight.w500)
                  //         ),
                  //       ),
                  //
                  //
                  //       // PopupMenuItem(
                  //       //   value: 3,
                  //       //   child: GestureDetector(
                  //       //       onTap: () {
                  //       //
                  //       //         print("open---book");
                  //       //
                  //       //         Constant.backToFinish();
                  //       //
                  //       //
                  //       //
                  //       //         _pdfViewerKey.currentState?.openBookmarkView();
                  //       //
                  //       //         //
                  //       //         // adsFile.showRewardedAd((){
                  //       //         //   requestDownload(widget.storyModel.pdf ?? "",
                  //       //         //       widget.storyModel.name ?? "");
                  //       //         // }, (){});
                  //       //
                  //       //
                  //       //       },
                  //       //       child: getCustomFont("BookMark", 16.sp,
                  //       //           context.theme.primaryColor, 1,
                  //       //           fontWeight: FontWeight.w500)
                  //       //   ),
                  //       // ),
                  //
                  //
                  //     ])
                ],
              ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
            ),

            // getVerSpace((isSearch.value)?20.h:0.h),

            // IconButton(
            //   icon: Icon(
            //     Icons. bookmark,
            //     color: Colors.black26,
            //   ),
            //   // onPressed: _addBookmarksToPDF,
            //   onPressed: () {
            //
            //     print("callled-------bookmark");
            //
            //     // pdfBookmark = PdfDocument(inputBytes: _pdfBytes).bookmarks.add("Table Of Contents");
            //
            //     if(pdfBookmark!.title.isNotEmpty){
            //
            //       print("Pdf-------${pdfBookmark!.title}");
            //       pdfViewerController.jumpToBookmark(pdfBookmark!);
            //       // pdfViewerController.jumpToPage(5);
            //     }
            //     // else{
            //
            //       // showCustomToast(context: context, message: "BookMark Not Available");
            //       // pdfViewerController.jumpToBookmark(pdfBookmark!);
            //     // }
            //
            //     //
            //   },
            // ),

            Obx(
              () => (isSearch.value)
                  ? Container(
                      height: 40.h,
                      margin: EdgeInsets.only(left: 100.h, right: 20.h),
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.h),
                              color:
                                  Get.isDarkMode ? regularBlack : regularWhite),
                          child: TextFormField(
                            maxLines: 1,
                            controller: searchController,
                            onChanged: (value) {
                              find();
                            },
                            onFieldSubmitted: (value) {
                              find();
                            },
                            decoration: InputDecoration(
                                suffixIcon: Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Visibility(
                                      //   // visible: true,
                                      //   visible: searchResult.hasResult,
                                      //   child: IconButton(
                                      //     icon: Icon(
                                      //       Icons.keyboard_arrow_up,
                                      //       // color: Colors.white,
                                      //     ),
                                      //     onPressed: () {
                                      //       searchResult.previousInstance();
                                      //     },
                                      //   ),
                                      // ),
                                      // Visibility(
                                      //   // visible: true,
                                      //   visible: searchResult.hasResult,
                                      //   child: IconButton(
                                      //     icon: Icon(
                                      //       Icons.keyboard_arrow_down,
                                      //       // color: Colors.white,
                                      //     ),
                                      //     onPressed: () {
                                      //       searchResult.nextInstance();
                                      //     },
                                      //   ),
                                      // ),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //
                                      //     isSearch.value = false;
                                      //
                                      //     searchController.text = "";
                                      //
                                      //     searchResult.clear();
                                      //   },
                                      //   child: Icon(
                                      //     Icons.clear, size: 18.h,).marginOnly(right: 10.h),
                                      // ),
                                    ],
                                  ),
                                ),
                                hintText: "Find...",
                                hintStyle: TextStyle(
                                    color: grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.h,
                                    fontFamily: Constant.fontsFamily),
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding:
                                    EdgeInsets.only(left: 16.h, top: 0.h),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.h),
                                    borderSide: BorderSide(color: grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.h),
                                    borderSide:
                                        BorderSide(color: maximumOrange))),
                          ),
                        ),

                        // getTextField(
                        // Colors.transparent, "Find...",
                        // suffixIconPermission: true,
                        // controller: searchController,
                        //
                        // onChanged: (value) {
                        //   find();
                        // },
                        //
                        // suffixWidget: Expanded(
                        //   flex: 1,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //
                        //       Visibility(
                        //         visible: true,
                        //         // visible: searchResult.hasResult,
                        //         child: IconButton(
                        //           icon: Icon(
                        //             Icons.keyboard_arrow_up,
                        //             // color: Colors.white,
                        //           ),
                        //           onPressed: () {
                        //             searchResult.previousInstance();
                        //           },
                        //         ),
                        //       ),
                        //       Visibility(
                        //         visible: true,
                        //         // visible: searchResult.hasResult,
                        //         child: IconButton(
                        //           icon: Icon(
                        //             Icons.keyboard_arrow_down,
                        //             // color: Colors.white,
                        //           ),
                        //           onPressed: () {
                        //             searchResult.nextInstance();
                        //           },
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: (){
                        //
                        //         },
                        //         child: Icon(
                        //           Icons.clear, size: 18.h,).marginOnly(right: 10.h),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // )
                      ),
                    )
                  : SizedBox(),
            ),

            getVerSpace((isSearch.value) ? 20.h : 0.h),

            // AppBar(
            //
            //   title: getCustomFont(
            //       widget.storyModel.name ?? "", 24.sp, regularBlack,
            //       1,
            //       fontWeight: FontWeight.w700,
            //       textAlign: TextAlign.center),
            //
            //
            //   actions: [
            //     IconButton(
            //       icon: Icon(
            //         Icons.search,
            //         color: Colors.white,
            //       ),
            //       onPressed: () {
            //         searchResult = pdfViewerController.searchText(
            //             'the',
            //             searchOption: TextSearchOption.caseSensitive);
            //         if (kIsWeb) {
            //           setState(() {});
            //         } else {
            //           searchResult.addListener(() {
            //             if (searchResult.hasResult) {
            //               setState(() {});
            //             }
            //           });
            //         }
            //       },
            //     ),
            //
            //   ],
            // ),

            // SearchToolbar(controller: controller, onTap: onTap)

            getVerSpace(20.h),
            Expanded(
              child: Container(
                // height: 500.h,
                // color: context.theme.focusColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                        height: 0.8.sh,
                        child: Obx(() {
                          if (networkManager.isNetwork.value) {
                            log("pdf value" + widget.storyModel.pdf.toString());
                            // return (_pdfBytes != null)?
                            return FutureBuilder(
                              future: _downloadPDF(widget.storyModel.pdf!),
                              builder: (context, snapshot) {
                                // if (snapshot.connectionState == ConnectionState.waiting ){
                                //   return SizedBox(height: 0..sh,width: 0.1.sw,child: CircularProgressIndicator(),);
                                // }
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  log("snapshot" + snapshot.data.toString());
                                  return isLoading.value
                                      ? SizedBox(
                                          height: 0.1.sh,
                                          width: 0.1.sw,
                                          child: CircularProgressIndicator(),
                                        )
                                      : SfPdfViewer.memory(
                                          controller: _pdfViewerController,
                                          snapshot.data as Uint8List,
                                          onTextSelectionChanged:
                                              (PdfTextSelectionChangedDetails
                                                  details) {
                                            if (details.selectedText == null &&
                                                _overlayEntry != null) {
                                              _overlayEntry!.remove();
                                              _overlayEntry = null;
                                            } else if (details.selectedText !=
                                                    null &&
                                                _overlayEntry == null) {
                                              _showContextMenu(
                                                  context, details);
                                            }
                                          },
                                          // You can customize the viewer further with additional options here
                                        );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return SizedBox(
                                    height: 0.1.sh,
                                    width: 0.1.sw,
                                  );
                                }
                              },
                            );
                            //   PdfViewPinch(
                            //   controller: pdfPinchController!,
                            //   onPageChanged: (page) {
                            //   },
                            //   builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                            //     options: DefaultBuilderOptions(
                            //       loaderSwitchDuration: Duration(seconds: 1),
                            //       transitionBuilder: SomeWidget.transitionBuilder,
                            //     ),
                            //     documentLoaderBuilder: (context) =>
                            //         getLottieAnimationWidget(),
                            //     pageLoaderBuilder: (context) =>
                            //         getLottieAnimationWidget(),
                            //     errorBuilder: (context, error) => Center(child: Text(error.toString())),
                            //     builder: SomeWidget.builder,
                            //   ),
                            // );
                            // SfPdfViewer.memory(
                            //   _pdfBytes!,
                            //   // "https://firebasestorage.googleapis.com/v0/b/flutterfirebase-6c279.appspot.com/o/GIS.pdf?alt=media&token=51654170-c140-4ffa-ae1a-9fb431d0dee2",
                            //   // "https://firebasestorage.googleapis.com/v0/b/e-book-a4896.appspot.com/o/uploads%2Ftest.pdf?alt=media&token=79e9bdc1-0f0a-4419-8966-226f06a9ec43" ?? "",
                            //   // widget.storyModel.pdf ?? "",
                            //   canShowScrollHead: false,
                            //   enableDoubleTapZooming: true,
                            //   key: _pdfViewerKey,
                            //   onTextSelectionChanged: (details) {
                            //     print("de-----${details.selectedText}");
                            //   },
                            //   controller: pdfViewerController,
                            //   enableTextSelection: true,
                            //
                            //   currentSearchTextHighlightColor: maximumOrange
                            //       .withOpacity(0.8),
                            //   otherSearchTextHighlightColor: maximumOrange.withOpacity(0.5),
                            //
                            //   onDocumentLoadFailed: (details) {
                            //     print("details-------${details
                            //         .description}");
                            //   },
                            //
                            //   onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
                            //
                            //     isPdfLoad.value = true;
                            //
                            //     pdfBookmark = details.document.bookmarks[2];
                            //
                            //     print("pdfBookmark------${pdfBookmark!.title.toString()}");
                            //   },
                            // )
                            //     :
                            //
                            //
                            //
                            //
                            // Container(color: Colors.green,);
                          } else {
                            return getProgressWidget(context);
                          }
                        })),
                  ],
                ),
              ),
            )
          ],
        ))),
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

class SaveFile {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    //Get external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/$fileName');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    // OpenFile.open('$path/$fileName');
  }
}

// class SomeWidget {
//   static Widget builder(
//       BuildContext context,
//       PdfViewPinchBuilders builders,
//       PdfLoadingState state,
//       WidgetBuilder loadedBuilder,
//       PdfDocument? document,
//       Exception? loadingError,
//       ) {
//     final Widget content = () {
//       switch (state) {
//         case PdfLoadingState.loading:
//           return KeyedSubtree(
//             key: const Key('pdfx.root.loading'),
//             child: builders.documentLoaderBuilder?.call(context) ??
//                 Container(color: Colors.green),
//           );
//         case PdfLoadingState.error:
//           return KeyedSubtree(
//             key: const Key('pdfx.root.error'),
//             child: builders.errorBuilder?.call(context, loadingError!) ??
//                 Center(child: Text(loadingError.toString())),
//           );
//         case PdfLoadingState.success:
//           return KeyedSubtree(
//             key: Key('pdfx.root.success.${document!.id}'),
//             child: loadedBuilder(context),
//           );
//       }
//     }();
//
//     final defaultBuilder =
//     builders as PdfViewPinchBuilders<DefaultBuilderOptions>;
//     final options = defaultBuilder.options;
//
//     return AnimatedSwitcher(
//       duration: options.loaderSwitchDuration,
//       transitionBuilder: options.transitionBuilder,
//       child: content,
//     );
//   }
//
//   static Widget transitionBuilder(Widget child, Animation<double> animation) =>
//       FadeTransition(opacity: animation, child: child);
//
//   static PhotoViewGalleryPageOptions pageBuilder(
//       BuildContext context,
//       Future<PdfPageImage> pageImage,
//       int index,
//       PdfDocument document,
//       ) =>
//       PhotoViewGalleryPageOptions(
//         imageProvider: PdfPageImageProvider(
//           pageImage,
//           index,
//           document.id,
//         ),
//
//
//         minScale: PhotoViewComputedScale.contained * 1,
//         maxScale: PhotoViewComputedScale.contained * 3.0,
//         initialScale: PhotoViewComputedScale.contained * 1.0,
//         heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
//
//       );
// }
