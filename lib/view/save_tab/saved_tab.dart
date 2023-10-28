import 'dart:io';
import 'package:ebook_app/view/save_tab/read_saved_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../controller/controller.dart';
import '../../utils/constant.dart';
import '../../utils/constantWidget.dart';

class SaveTab extends StatefulWidget {
  const SaveTab({Key? key}) : super(key: key);

  @override
  State<SaveTab> createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  SavedTabController savedTabController = Get.put(SavedTabController());

  void backClick() {
    Constant.backToFinish();
  }

  List<FileSystemEntity> files = [];

  // getFiles() async {
  //   Directory? extDir = await getExternalStorageDirectory();
  //   String pdfPath = "$extDir / pdf / ";
  //
  //
  //   final dir = await getApplicationDocumentsDirectory();
  //
  //   _files = dir.listSync(recursive: true, followLinks: false,);
  //
  //   print("filesLen-----------${_files.length}");
  //   print("dir-----------${dir}");
  //
  //
  //   // result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf'],allowMultiple: false,);
  //
  //
  // }

  @override
  void initState() {
    super.initState();

    getFiles();
  }

  Future<void> getFiles() async {
    // var directory = await getExternalStorageDirectory();
    // String tempPath = directory!.path;

    // final savedDir = Directory("${tempPath}/colorBook");
    // bool hasExisted = await savedDir.exists();
    // if (!hasExisted) {
    //   savedDir.create();
    // }

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
  }

  RxBool isSearch = false.obs;
  TextEditingController edtController = TextEditingController();
  RxList<FileSystemEntity> filterList = <FileSystemEntity>[].obs;
  RxString filterText = "".obs;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {

        HomeMainScreenController mainScreenController = Get.find();

        mainScreenController.onChange(2.obs);
        return false;
        // backClick();
        // return false;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        // body: Container(
        //   height: 500.h,
        //   width: double.infinity,
        //   child: ListView.builder(
        //       padding: const EdgeInsets.all(16.0),
        //       itemCount: files.length,
        //       itemBuilder: (context, i) {
        //
        //         String basename = files.elementAt(i).path.split("/").last;
        //
        //
        //         //
        //         // String file = basename.split("?").first;
        //         //
        //         // print("filename--------${file}");
        //
        //         // return Container(
        //         //   height: 500.h,
        //         //     child: SfPdfViewer.file(File(_files.elementAt(i).path)));
        //             // child: SfPdfViewer.file(File(_files.elementAt(i).path)));
        //             // child: SfPdfViewer.file(file));
        //         return ListTile(
        //           title: getCustomFont(basename, 20.h, regularBlack, 10),
        //           // title: getCustomFont(_files[i].path.split('/').last, 20.h, regularBlack, 10),
        //         );
        //       }),
        // ),

        body: Column(
          children: [
            Obx(() => (isSearch.value)?Container(
              color: context.theme.focusColor,
              padding:
              EdgeInsets.only(top: 20.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: getSearchFigmaWidget(context,
                         edtController, () {}, (value) {

                      filterText.value = value;

                    }),
                  ),
                  getHorSpace(16.h),
                  InkWell(
                    onTap: () {

                      edtController.clear();

                      isSearch.value = false;
                    },
                    child: getCustomFont(
                        "Cancel", 14, context.theme.primaryColor, 1,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ).marginSymmetric(horizontal: 20.h),
            ):getCustumAppbar(
                rightPermission: true,
                leftPermission: false,
                // leftIcon:
                //     Get.isDarkMode ? "left_arrow_white.svg" : "back_arrow.svg",
                title: "My Saved Books",
                // leftFunction: () {
                //   backClick();
                // },
                rightIcon: Get.isDarkMode?"search_normal.svg":"searchIcon.svg",
                rightFunction: (){
                  isSearch.value = true;
                },
                titlecolor: context.theme.primaryColor,
                givecolor: context.theme.focusColor)),
        getVerSpace(20.h),
        buildSavedList(context)
          ],
        ),
      ),
    );
  }

  Expanded buildSavedList(BuildContext context) {
    return Expanded(
          child: (files.isNotEmpty)
              ? Obx(() {
            if(filterText.value != "" && filterText.value.isNotEmpty){
                return Builder(
                builder: (context) {


                  if (files.isNotEmpty) {
                    filterList.value = files
                        .where((e) => e.path.split("/").last
                        .toLowerCase()
                        .contains(filterText.value
                        .toLowerCase()))
                        .toList();
                    // filterList.addAll(list);
                  }

                  if(filterList.isNotEmpty){
                    return ListView.builder(
                      itemCount: filterList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        String basename =
                            filterList.elementAt(index).path.split("/").last;
                        return GestureDetector(
                          onTap: () {
                            Constant.sendToNextWithResult(
                                context,
                                ReadSavedBookScreen(
                                    filePath: filterList.elementAt(index).path),
                                    (value) {});
                          },
                          child: Container(
                            color: context.theme.focusColor,
                            margin: EdgeInsets.only(bottom: 20.h),
                            child: ListTile(
                              title: getCustomFont(
                                  basename, 20.h, context.theme.primaryColor, 10),
                              leading: getSvgImage("pdf_logo.svg",
                                  height: 40.h, width: 40.h),
                              trailing: GestureDetector(
                                  onTap: () {

                                    files.remove(filterList[index]);
                                    getFiles();

                                  },
                                  child: getSvgImage("delete_icon.svg",
                                      height: 24.h, width: 24.h)),
                            ),
                          ),
                        );
                      },

                      // children: [
                      //   // Container(
                      //   //   color: context.theme.focusColor,
                      //   //   child: Column(
                      //   //     children: [
                      //   //       getSavedBookItemFormate("trendingBook2nd.png", () {},
                      //   //           "The Wayfarer", "Jennifer I. Hayes",
                      //   //           percentindicaterPermmition: true,persentIndicate: 0.63,context.theme.primaryColor),
                      //   //       getVerSpace(20.h),
                      //   //       getSavedBookItemFormate("populerBook2nd.png", () {},
                      //   //           "A.P.J. Abdul Kalam", "Arun Tiwari",
                      //   //           percentindicaterPermmition: true,persentIndicate: 0.30,context.theme.primaryColor),
                      //   //     ],
                      //   //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                      //   // ),
                      //   // getVerSpace(20.h),
                      //   // Container(
                      //   //   color: context.theme.focusColor,
                      //   //   child: Column(
                      //   //     children: [
                      //   //       getSavedBookItemFormate("populerBook3rd.png", () {},
                      //   //           "The Gospel of Buddha", "Dr. Paul Carus" ,context.theme.primaryColor),
                      //   //       getVerSpace(20.h),
                      //   //       getSavedBookItemFormate("populerBook1st.png", () {},
                      //   //         "Harry Potter", "J.K. Rowlins",context.theme.primaryColor),
                      //   //       getVerSpace(20.h),
                      //   //       getSavedBookItemFormate("trendingBook3rd.png", () {},
                      //   //         "Harry Potter", "J.K. Rowlins",context.theme.primaryColor),
                      //   //       getVerSpace(20.h),
                      //   //       getSavedBookItemFormate("trendingBook2nd.png", () {},
                      //   //         "Knowing God", "J.I.Packer",context.theme.primaryColor),
                      //   //     ],
                      //   //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                      //   // )
                      // ],
                    );
                  }else{
                    return Center(
                        child: getCustomFont(
                            "No Result found!",
                            25.sp,
                            context.theme.primaryColor,
                            1));
                  }

                }
            );}else{
                return ListView.builder(
              itemCount: files.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String basename =
                    files.elementAt(index).path.split("/").last;
                return GestureDetector(
                  onTap: () {

                    Constant.sendToNextWithResult(
                        context,
                        ReadSavedBookScreen(
                            filePath: files.elementAt(index).path),
                            (value) {});

                  },
                  child: Container(
                    color: (Get.isDarkMode)?Colors.grey.shade900:context.theme.focusColor,
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: ListTile(
                      title: getCustomFont(
                          basename, 20.h, context.theme.primaryColor, 10),
                      leading: getSvgImage("pdf_logo.svg",
                          height: 40.h, width: 40.h),
                      trailing: GestureDetector(
                          onTap: () {

                            files[index].delete();
                            getFiles();

                          },
                          child: getSvgImage("delete_icon.svg",
                              height: 24.h, width: 24.h)),
                    ),
                  ),
                );
              },

              // children: [
              //   // Container(
              //   //   color: context.theme.focusColor,
              //   //   child: Column(
              //   //     children: [
              //   //       getSavedBookItemFormate("trendingBook2nd.png", () {},
              //   //           "The Wayfarer", "Jennifer I. Hayes",
              //   //           percentindicaterPermmition: true,persentIndicate: 0.63,context.theme.primaryColor),
              //   //       getVerSpace(20.h),
              //   //       getSavedBookItemFormate("populerBook2nd.png", () {},
              //   //           "A.P.J. Abdul Kalam", "Arun Tiwari",
              //   //           percentindicaterPermmition: true,persentIndicate: 0.30,context.theme.primaryColor),
              //   //     ],
              //   //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              //   // ),
              //   // getVerSpace(20.h),
              //   // Container(
              //   //   color: context.theme.focusColor,
              //   //   child: Column(
              //   //     children: [
              //   //       getSavedBookItemFormate("populerBook3rd.png", () {},
              //   //           "The Gospel of Buddha", "Dr. Paul Carus" ,context.theme.primaryColor),
              //   //       getVerSpace(20.h),
              //   //       getSavedBookItemFormate("populerBook1st.png", () {},
              //   //         "Harry Potter", "J.K. Rowlins",context.theme.primaryColor),
              //   //       getVerSpace(20.h),
              //   //       getSavedBookItemFormate("trendingBook3rd.png", () {},
              //   //         "Harry Potter", "J.K. Rowlins",context.theme.primaryColor),
              //   //       getVerSpace(20.h),
              //   //       getSavedBookItemFormate("trendingBook2nd.png", () {},
              //   //         "Knowing God", "J.I.Packer",context.theme.primaryColor),
              //   //     ],
              //   //   ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
              //   // )
              // ],
            );}
          })
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getSvgImage("no_book_icon.svg",
                          height: 94.h, width: 94.h),
                      getVerSpace(26.h),
                      getCustomFont("No book saved yet!", 22.sp,
                          context.theme.primaryColor, 1,
                          fontWeight: FontWeight.w700),
                      getVerSpace(40.h),
                      getCustomButton("Go To Home", (){
                        HomeMainScreenController controller = Get.find();

                        controller.index.value = 2;
                        controller.onChange(2.obs);
                      },).marginSymmetric(horizontal: 20.h)
                    ],
                  ),
                ));
  }
}


/*
  getVerSpace(217.h),
            getSvgImage("no_book_icon.svg", height: 94.h, width: 94.h),
            getVerSpace(26.h),
            getCustomFont("No book saved yet!", 22.sp, context.theme.primaryColor, 1,
                fontWeight: FontWeight.w700)
 */
