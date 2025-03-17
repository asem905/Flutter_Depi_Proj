import 'package:flutter/material.dart';
import 'package:flutter_application_depi/constants/color.dart';
import 'package:flutter_application_depi/data/model/onboardingmodel.dart';
import 'package:flutter_application_depi/view/screen/onBoarding_screen/gender_screen.dart';
import 'package:flutter_application_depi/view/widget/custom_onboarding_widgets/cutom_positioned_arrow.dart';

class PageViewBoarding extends StatefulWidget {
  static String id = "PageViewBoarding";

  @override
  _PageViewBoardingState createState() => _PageViewBoardingState();
}

class _PageViewBoardingState extends State<PageViewBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onBoardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, GenderScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColorScaffoldPageView,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onBoardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    onBoardingData[index].image,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          onBoardingData[index].text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          CustomPositionedArrow(onPressed: _nextPage)
        ],
      ),
    );
  }
}
