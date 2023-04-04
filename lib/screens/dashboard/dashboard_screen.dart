import 'package:flutter/material.dart';
import 'package:librarymanagement/models/func.dart';
import 'package:librarymanagement/screens/blogs/blogs_screen.dart';
import 'package:librarymanagement/screens/category/category_screen.dart';
import 'package:librarymanagement/screens/dashboard/components/buttom_card.dart';
import 'package:librarymanagement/screens/dashboard/components/category_card.dart';
import 'package:librarymanagement/screens/developer.dart';
import 'package:librarymanagement/screens/login/login_screen.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';

// import 'package:cached_network_image/cached_network_image.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool shouldPop = false;

  void _yesNoSmartAlert(BuildContext context) {
    AlertDialogcustom(context);
  }

  Future<dynamic> AlertDialogcustom(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => SmartAlertDialog(
        title: "Are you sure you want to logout ?",
        text: AlertDialogText(),
        message: "You will need to login once you logout",
        onConfirmPressed: () => setState(() {
          userId = '';
          shouldPop = true;
          Navigator.of(context)
              .pop(MaterialPageRoute(builder: (context) => LoginScreen()));
        }),
        onCancelPressed: () => '',
      ),
    );
  }

  void _okSmartAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SmartAlertDialog(
        title: "This is an dismissable alert!",
        text: AlertDialogText(),
        message:
            "Hey, you can only dismiss this alert dialog. And also, don't tap again in that button. You have been alerted!",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // bool _loaded = false;
    // var img = NetworkImage("$profileUrl${UserDetails.matricNo}.jpg");
    // var placeholder = AssetImage("assets/images/avatar.jpg");

    // void initState() {
    //   super.initState();
    //   img.image.resolve(ImageConfiguration()).addListener((i, b) {
    //     if (mounted) {
    //       setState(() => _loaded = true);
    //     }
    //   });
    // }

    return WillPopScope(
      onWillPop: () async {
        await UserDetails.getUserDetails();
        return shouldPop;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 40, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        // CircleAvatar(
                        //   radius: 32,
                        //   foregroundImage: FadeInImage.assetNetwork(
                        //     placeholder: AssetImage("assets/images/avatar.jpg"),
                        //     image: ("$profileUrl${UserDetails.matricNo}.jpg"),
                        //   ),

                        // ),

                        Expanded(
                          child: SizedBox(
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                placeholder: "assets/images/avatar.jpg",
                                image:
                                    'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg' ??
                                        '',
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/avatar.jpg',
                                      fit: BoxFit.fitWidth);
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              capitalize(UserDetails.fullName),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              UserDetails.matricNo,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: const Icon(
                                  Icons.logout_sharp,
                                  color: Colors.red,
                                  size: 36.0,
                                ),
                              ),
                              onTap: () {
                                _yesNoSmartAlert(context);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        primary: false,
                        crossAxisCount: 2,
                        children: <Widget>[
                          CategoryCard(
                            title: "Category",
                            iconUrl: 'assets/icons/Book-Rack--LIUZhongjun.svg',
                            press: () {
                              Navigator.of(context).push(
                                  SlideRightRoute(page: CategoryScreen()));
                            },
                          ),
                          CategoryCard(
                            title: "My Book",
                            iconUrl: 'assets/icons/book-pictogram.svg',
                            press: () {
                              Navigator.of(context)
                                  .push(SlideRightRoute(page: BlogsScreen()));
                            },
                          ),
                          CategoryCard(
                            title:
                                "Issued Books (${UserDetails.numIssuedBooks})",
                            iconUrl: 'assets/icons/1309128948.svg',
                            press: () {
                              print("Container clicked");
                            },
                          ),
                          CategoryCard(
                            title: "Return Books",
                            iconUrl: 'assets/icons/reload-icon.svg',
                            press: () {
                              print("Container clicked");
                            },
                          ),
                        ]),
                  ),
                  // ButtomContainer(
                  //   title: "About Library",
                  //   icon: Icons.event_available_outlined,
                  //   press: () {
                  //     print("yes its clicked");
                  //   },
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtomContainer(
                    title: "About Developer",
                    icon: Icons.verified_user_sharp,
                    press: () {
                      Navigator.of(context)
                          .push(SlideRightRoute(page: const DeveloperScreen()));
                    },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
