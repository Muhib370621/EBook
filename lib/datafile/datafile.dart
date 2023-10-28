import 'dart:ui';

import 'package:ebook_app/models/intro_screen_model.dart';
import 'package:ebook_app/utils/color_category.dart';

import '../models/book_list_model.dart';
import '../models/book_types_model.dart';
import '../models/bottom_appbar_model.dart';
import '../models/dashboard_screen_data_model.dart';
import '../models/drawer_author_screen_data_model.dart';
import '../models/drawer_categoy_class_data_model.dart';
import '../models/populer_book_model.dart';
import '../models/top_authors_model.dart';
import '../models/trending_books_model.dart';

class DataFile {
  static List<IntroData> getIntroData() {
    return [
      IntroData(
          image: 'intro1st.png',
          title: 'Read what you want!',
          discription:
              'Read your favourite novel And share your thought about book.',
          color: const Color(0XFFFFF8F4)),
      IntroData(
          image: 'intro2nd.png',
          title: 'Read your favourite!',
          discription:
              'Here we provide all kind of books that you would love it and read for free.',
          color: const Color(0XFFFEF7F7)),
      IntroData(
          image: 'intro3rd.png',
          title: 'Enjoy your free time!',
          discription:
              'We are here for your free time and feel you more fresh and enthusiastic.',
          color: const Color(0XFFFEFAF4)),
    ];
  }

  // static List<SliderData> getSliderData(){
  //   return[
  //     SliderData(name: 'Dashboard',unSelecIcon: 'homeIcon.svg',selectIcon: 'home_bold.svg',id: 1),
  //     SliderData(name: 'Categories',unSelecIcon: 'categoryIcon.svg',selectIcon: 'categoryFillIcon.svg',id: 2),
  //     SliderData(name: 'Stories',unSelecIcon: 'book_icon.svg',selectIcon: 'book_fill_icon.svg',id: 3),
  //     SliderData(name: 'Books',unSelecIcon: 'books_icon.svg',selectIcon: 'books_fill_icon.svg',id:4 ),
  //     SliderData(name: 'Home Slider',unSelecIcon: 'slider_icon.svg',selectIcon: 'slider_fill_icon.svg',id: 5),
  //     SliderData(name: 'Authors',unSelecIcon: 'user_icon.svg',selectIcon: 'user_fill_icon.svg',id:6 ),
  //     SliderData(name: 'Send Notification',unSelecIcon: 'notificationIcon.svg',selectIcon: 'notificationFillIcon.svg',id:7 ),
  //     SliderData(name: 'Settings',unSelecIcon: 'setting_icon.svg',selectIcon: 'setting_fill_icon.svg',id:8 ),
  //   ];
  // }

  static List<DeshBoardData> getDashboardData(){
    return [
      DeshBoardData(icon: 'dashboard_category_icon.svg',title: 'Categories',backgroundColor: const Color(0XFFFFEDE9),buttonColor: maximumOrange,number: '6'),
      DeshBoardData(icon: 'dashboard_stories_icon.svg',title: 'Stories',backgroundColor: const Color(0XFFD8F1E4),buttonColor: const Color(0XFF36CB79),number: '23'),
      DeshBoardData(icon: 'dashboard_homeslider_slider.svg',title: 'Home Slider',backgroundColor: const Color(0XFFFFF6D4),buttonColor: const Color(0XFFFFAE35),number: '12'),
      DeshBoardData(icon: 'dashboard_featured_books_icon.svg',title: 'Featured Books',backgroundColor: const Color(0XFFF3E7FF),buttonColor: const Color(0XFFA67CFF),number: '12'),
      DeshBoardData(icon: 'dashboard_populer_books_icon.svg',title: 'Populer Books',backgroundColor: const Color(0XFFE1F1FF),buttonColor: const Color(0XFF4CB8F4),number: '11'),
    ];
  }

  static List<CategoriesData> getCategoriesData(){
    return [
      CategoriesData(name: 'Business',image: 'categryes1st.png',id:1 ),
      CategoriesData(name: 'Crime',image: 'categryes2nd.png',id: 2),
      CategoriesData(name: 'Histry',image: 'categryes3rd.png',id:3 ),
      CategoriesData(name: 'Fairytale',image: 'categryes4th.png',id:4 ),
      CategoriesData(name: 'Poetry',image: 'categryes5th.png',id:5 ),
    ];
  }

  static List<AuthorDataModel> getAuthorDataModelData(){
    return [
      AuthorDataModel(image: 'drawer_author1st.png',name: 'Robert Fox',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',designation: 'Writer',status: true,id: 1),
      AuthorDataModel(image: 'drawer_author2nd.png',name: 'Zain Imam',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',designation: 'Publisher',status: true,id:2 ),
      AuthorDataModel(image: 'drawer_author3rd.png',name: 'Bella Libert',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',designation: 'Writer',status: true,id:3 ),
      AuthorDataModel(image: 'drawer_author4th.png',name: 'Zain Imam',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',designation: 'Writer',status: true,id:4 ),
      AuthorDataModel(image: 'drawer_author5th.png',name: 'Lily Bolt',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',designation: 'Writer',status: true,id:5 ),
    ];
  }

  static List<ModelBottom> getBottomAppBar() {
    return [
      ModelBottom(
          icon: 'homeIcon.svg', select_icon: 'home_bold.svg', name: 'Home'),
      ModelBottom(
          icon: 'categoryIcon.svg',
          select_icon: 'categoryFillIcon.svg',
          name: 'Category'),
      ModelBottom(
          icon: 'saveIcon.svg', select_icon: 'saveBoldIcon.svg', name: 'Saved'),
      ModelBottom(
          icon: 'notificationIcon.svg',
          select_icon: 'notificationFillIcon.svg',
          name: 'Notification'),
      ModelBottom(
          icon: 'moreHorRoundedicon.svg',
          select_icon: 'moreHorRoundedBold.svg',
          name: 'More'),
    ];
  }

  static List<BookTypes> getBookTypes() {
    return [
      BookTypes(name: 'All', id: 1),
      BookTypes(name: 'History', id: 2),
      BookTypes(name: 'Design', id: 3),
      BookTypes(name: 'Programming', id: 4),
      BookTypes(name: 'Fairytale', id: 5),
    ];
  }

  static List<BookList> getBookListData() {
    return [
      BookList(
          title: 'The Other Slavery',
          backGround: const Color(0XFFFFE7E4),
          writerName: 'Andres Resendez',
          bookImage: 'book1st.png'),
      BookList(
          title: 'The Other Slavery',
          backGround: const Color(0XFFDBF2F7),
          writerName: 'Andres Resendez',
          bookImage: 'book2nd.png'),
      BookList(
          title: 'The Other Slavery',
          backGround: const Color(0XFFE0E2FF),
          writerName: 'Andres Resendez',
          bookImage: 'book3rd.png'),
    ];
  }

  static List<TrenDingBook> getTrendingBookData() {
    return [
      TrenDingBook(
          image: 'trendingBook1st.png',
          authorName: 'J.I.Packer',
          bookName: 'Knowing God'),
      TrenDingBook(
          image: 'trendingBook2nd.png',
          authorName: 'Jennifer I. Hayes',
          bookName: 'The Wayfarer'),
      TrenDingBook(
          image: 'trendingBook3rd.png',
          authorName: 'J.K. Rowlins',
          bookName: 'Harry Potter'),
      TrenDingBook(
          image: 'trendingBook4th.png',
          authorName: 'Justin Cronin',
          bookName: 'The Passage '),
      TrenDingBook(
          image: 'trendingBook5th.png',
          authorName: 'Carter Bays',
          bookName: 'The Mutual Friend'),
      TrenDingBook(
          image: 'trendingBook6th.png',
          authorName: 'Justin Cronin',
          bookName: 'Tattooist of Ausc'),
    ];
  }

  static List<TopAuthors1> getTopAuthorsData() {
    return [
      TopAuthors1(
          numberOfBook: '40',
          authorName: 'J.K.Rowlings',
          image: 'authors1st.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
      TopAuthors1(
          numberOfBook: '20',
          authorName: 'Jennifer Hayes',
          image: 'authors2nd.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
      TopAuthors1(
          numberOfBook: '23',
          authorName: 'R. C. Majumdar',
          image: 'authors3rd.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
      TopAuthors1(
          numberOfBook: '40',
          authorName: 'J.K.Rowlings',
          image: 'authors1st.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
      TopAuthors1(
          numberOfBook: '20',
          authorName: 'Jennifer Hayes',
          image: 'authors2nd.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
      TopAuthors1(
          numberOfBook: '23',
          authorName: 'R. C. Majumdar',
          image: 'authors3rd.png',
          authorCountry: 'British Author',
          othorBook: [
            AuthorPopularBook(
                image: 'othorPopBook1st.png',
                bookName: 'Harry Potter',
                publishYear: '2007'),
            AuthorPopularBook(
                image: 'othorPopBook2nd.png',
                bookName: 'Silkworm 1',
                publishYear: '2020'),
            AuthorPopularBook(
                image: 'othorPopBook3rd.png',
                bookName: 'The Cucko..',
                publishYear: '2013'),
          ]),
    ];
  }

  static List<PopulerBook> getPopulerBookData() {
    return [
      PopulerBook(
          image: 'populerBook1st.png',
          authorName: 'J.K. Rowlins',
          bookName: 'Harry Potter'),
      PopulerBook(
          image: 'populerBook2nd.png',
          authorName: 'Arun Tiwari',
          bookName: 'Abdul Kalam'),
      PopulerBook(
          image: 'populerBook3rd.png',
          authorName: 'Dr. Paul Carus',
          bookName: 'Gospel of Bud'),
    ];
  }
}
