import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googlelogin/Registration%20page/04.1Loginpage.dart';

// const MaterialColor primaryMaterialColor = MaterialColor(0xFF9581FF, <int, Color>{
//   50: Color(0xFFEFECFF),
//   100: Color(0xFFD7D0FF),
//   200: Color(0xFFBDB0FF),
//   300: Color(0xFFA390FF),
//   400: Color(0xFF8F79FF),
//   500: Color(0xFF7B61FF),
//   600: Color(0xFF7359FF),
//   700: Color(0xFF684FFF),
//   800: Color(0xFF5E45FF),
//   900: Color(0xFF6C56DD),
// });

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  late PageController pageController;
  int pageIndex = 0;

  final List<Onbord> onbordData = [
    Onbord(
      image: "./images/Illustration-0.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_0.png",
      title: "Find the item you’ve \nbeen looking for",
      description:
          "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
    ),

    Onbord(
      image: "./images/Illustration-1.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_1.png",
      title: "Get those shopping \nbags filled",
      description:
          "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
    ), 

    Onbord(
      image: "./images/Illustration-2.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_2.png",
      title: "Fast & secure \npayment",
      description: "There are many payment options available for your ease.",
    ),

    Onbord(
      image: "./images/Illustration-3.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_3.png",
      title: "Package tracking",
      description:
          "In particular, Shoplon can pack your orders, and help you seamlessly manage your shipments.",
    ), 

    Onbord(
      image: "./images/Illustration-4.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_4.png",
      title: "Nearby stores",
      description:
          "Easily track nearby shops, browse through their items and get information about their prodcuts.",
    ),

  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(Loginpage());
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onbordData.length,
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnbordingContent(
                    title: onbordData[index].title,
                    description: onbordData[index].description,
                    image: (Theme.of(context).brightness == Brightness.dark &&
                            onbordData[index].imageDarkTheme != null)
                        ? onbordData[index].imageDarkTheme!
                        : onbordData[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),

              Row(
                children: [
                  Row(
                    children: List.generate(
                      onbordData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 18 / 4),
                        child: DotIndicator(isActive: index == pageIndex),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (pageIndex < onbordData.length - 1) {
                          pageController.nextPage(
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 300));
                        } else {
                          Get.to(Loginpage());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: Transform.scale(
                        scale: 1.5,
                        child: SvgPicture.asset(
                          "images/Arrow - Right.svg",
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF7B61FF),
                            BlendMode.srcIn,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

//Onbord Class
class Onbord {
  final String image, title, description;
  final String? imageDarkTheme;

  Onbord({
    required this.image,
    required this.title,
    this.description = "",
    this.imageDarkTheme,
  });
}

// OnbordingContent Class
class OnbordingContent extends StatelessWidget {

  const OnbordingContent({
    super.key,
    this.isTextOnTop = false,
    required this.title,
    required this.description,
    required this.image,
  });

  final bool isTextOnTop;
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        if (isTextOnTop)
          OnbordTitleDescription(
            title: title,
            description: description,
          ),
        if (isTextOnTop) const Spacer(),

        /// if you are using SVG then replace [Image.asset] with [SvgPicture.asset]

        Image.asset(
          image,
          height: 250,
        ),
        if (!isTextOnTop) const Spacer(),
        if (!isTextOnTop)
          const OnbordTitleDescription(
            title: "Find the item you’ve \nbeen looking for",
            description:
                "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
          ),

        const Spacer(),
      ],
    );
  }
}

// OnbordTitleDescription Class
class OnbordTitleDescription extends StatelessWidget {
  const OnbordTitleDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 18),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// DotIndicator class use
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false, // Determines if the dot is active
    this.inActiveColor, // Color when the dot is inactive
    this.activeColor = const Color(0xFF7B61FF), // Color when the dot is active
  });

  final bool isActive; // Boolean to check if the dot is active
  final Color? inActiveColor; // Color for inactive dot (optional)
  final Color activeColor; // Color for active dot

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Animation duration
      height: isActive ? 12 : 4, // Height changes based on active state
      width: 4, // Width remains constant
      decoration: BoxDecoration(
        color: isActive
            ? activeColor // Active color if the dot is active
            : inActiveColor ?? Colors.grey.shade300,
        // Inactive color or default
        borderRadius: BorderRadius.circular(18), // Rounded corners
      ),
    );
  }
}
