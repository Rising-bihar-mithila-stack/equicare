import 'package:equicare/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: _pageController,
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: <Widget>[
            buildPageContent(
              title: 'Welcome to EquiCare!',
              subtitle:
                  'Manage your horses with ease, anywhere, anytime.',
              subtitleUnder: 'EquiCare simplifies horse care by organising everything in one app—health, training, competitions, and goals. No more juggling diaries or whiteboards. It’s horse management made simple and stress-free.\n\n\n',
              image: appImages.onBoarding3,
            ),
            buildPageContent(
              title: 'Streamlined Horse Management',
              subtitle:
                  'All your horse’s needs, organised in one place.',
              subtitleUnder: 'Create detailed profiles for each horse, track their health and training, and link everything to a personalised calendar. With repeat scheduling and reminders, you’ll never miss an important event or task. Stay organised and stress-free, whether you manage one horse or an entire stable!\n\n',
              image: appImages.onBoarding1,
            ),
            buildPageContent(
                title: 'Ready to Simplify Your Horse Care?',
                subtitle:
                'Save time, reduce stress, and improve your horse’s well-being.',
                image: appImages.onBoarding2,
                subtitleUnder:
                'EquiCare helps you stay on top of every aspect of horse management. Join a community of riders and owners who trust EquiCare manage all their horses’ needs. What are you waiting for?\n\n\n'),

          ],
        ),
      ),
    );
  }

  Widget buildPageContent(
      {required String title,
      required String subtitle,
      String? subtitleUnder,
      required String image}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: MediaQuery.of(context).size.height * 0.58,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 13, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      3,
                      (int index) => buildDot(index: index),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: appTextStyles.p207001EBlue,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 15),
                      Text(
                        subtitle,
                        textAlign: TextAlign.start,
                        style: appTextStyles.p14400313131,
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitleUnder ?? '',
                        textAlign: TextAlign.start,
                        style: appTextStyles.p14400313131,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(bottom: 25),
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 0
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_currentPage < 2) {
                                _currentPage--;
                                _pageController.jumpToPage(_currentPage);
                              } else {
                                _currentPage = 1;
                                _pageController.jumpToPage(_currentPage);
                              }
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: appColors.primaryBlueColor,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_currentPage < 2) {
                          _currentPage++;
                          _pageController.jumpToPage(_currentPage);
                        } else {
                          // _currentPage=0;
                          // _pageController.jumpToPage(_currentPage);
                          // Navigate
                          Get.offAllNamed(appRouteNames.loginScreen);
                        }
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: appColors.primaryBlueColor),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: appColors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 3,
        width: _currentPage == index ? 20 : 10,
        decoration: BoxDecoration(
          color:
              _currentPage == index ? appColors.primaryBlueColor : Colors.grey,
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
