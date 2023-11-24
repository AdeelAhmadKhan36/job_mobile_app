
import 'package:flutter/material.dart';
import 'package:job_mobile_app/controllers/on_boarding_providers.dart';
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/reuse_able_text.dart';
import 'package:job_mobile_app/view/screens/on_boarding_screen/page_one.dart';
import 'package:job_mobile_app/view/screens/on_boarding_screen/page_three.dart';
import 'package:job_mobile_app/view/screens/on_boarding_screen/page_two.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({super.key});

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {

  // final pageController=PageController();
  final pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<onBoard_Notifier>(
        builder: (context,onBoard_Notifier,child){
          return Stack(
            children: [
              PageView(
                physics: onBoard_Notifier.isLastPage?
                    const NeverScrollableScrollPhysics():
                    const AlwaysScrollableScrollPhysics(),
                controller: PageController(),
                onPageChanged:(page){
                  onBoard_Notifier.isLastPage=page==2;
                } ,
                children: [
                   const Page_One(),
                   const Page_Two(),
                   const Page_Three()
                ],
              ),
               Positioned(
                 left: 0,
               right: 0,
                  bottom: 40,
                  child:onBoard_Notifier.isLastPage?const SizedBox.shrink():Center(
                    child: SmoothPageIndicator(
                      controller:pageController,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 10,
                        dotColor: Color(kDarkGrey.value).withOpacity(0.5),
                        activeDotColor: Color(kLight.value)
                      ),
                    ),
                  )
              ),
              Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          pageController.jumpToPage(2);
                        },
                        child:ReusableText(
                          text: 'Skip',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white, style: null,

                        )
                      ),
                      GestureDetector(
                        onTap: (){},
                        child:ReusableText(
                          text: 'Next',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,

                        )
                      )


                    ],
                  ),
                ),
              ))


            ],
          );
        }
      )
    );
  }
}
