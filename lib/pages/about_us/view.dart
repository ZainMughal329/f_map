import 'package:f_map/components/reuseable/reuseable_app_bar.dart';
import 'package:f_map/pages/about_us/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/colors/app_colors.dart';
import '../../components/reuseable/text_widget.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  Widget _buildFeatureItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          title: title,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 5.0),
        TextWidget(
          title: description,
          fontSize: 16.0,
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar(
          'About Us', AppColors.buttonColor, AppColors.buttonTextColor, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: 'Welcome to Your App Name!',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              _buildFeatureItem(
                'About Us',
                'Welcome to Fog Map, your ultimate companion for safe and hassle-free travel in foggy conditions. Our app is dedicated to providing a reliable solution for navigating through foggy weather, ensuring a secure and efficient journey for all users.',
              ),

              SizedBox(height: 20),
              _buildFeatureItem(
                "Our Mission",
                'At Fog Map, our primary mission is to enhance safety and convenience for travelers during foggy weather. We understand the challenges posed by reduced visibility, and our goal is to offer a tool that helps users navigate with confidence and peace of mind.',
              ),
              SizedBox(height: 20),
              TextWidget(
                title:
                    'With a simple and user-friendly interface, our app allows you to effortlessly browse through a diverse range of services. Explore detailed profiles of service providers, view their credentials, ratings, and customer feedback to make informed decisions that suit your requirements.',
                fontSize: 16,
                textColor: Colors.black,
              ),
              SizedBox(height: 20),
              _buildFeatureItem(
                'Real-time Location Sharing',
                'See the live location of multiple users within a 1km range on the map.',
              ),
              _buildFeatureItem(
                'Proximity Alerts',
                'Receive alerts when users are very close to each other for enhanced safety.',
              ),
              SizedBox(height: 20),

              _buildFeatureItem(
                'Speed Tracking',
                'Display the speed of each user for better monitoring and safety measures.',
              ),
              SizedBox(height: 20),

              _buildFeatureItem(
                'Distance Calculation',
                'Calculate and display distances between users within a 1km range.',
              ),
              SizedBox(height: 20),

              _buildFeatureItem(
                'ETA Calculation',
                'Estimate the time users take to cover the distance between them.',
              ),
              SizedBox(height: 20),
              _buildFeatureItem(
                'Contact Us',
                "We're here to assist you. Should you have any questions, suggestions, or require technical support, please don't hesitate to reach out to us at [Contact Email or Support Page Link]. Your inquiries are essential as we continue to evolve and enhance Fog Map to better serve your needs.",
              ),
              SizedBox(height: 20),
              _buildFeatureItem(
                'Our Vision:',
                'We aim to create a user-friendly and reliable platform that fosters better connections while ensuring safety and convenience for all our users.',
              ),
              SizedBox(height: 20),

             TextWidget(title:
                'Thank you for choosing "FOG MAP" - Where Safety Matters!',
               fontWeight: FontWeight.bold,
              ),
              // You can add more Text widgets or other widgets as needed to further describe your app
            ],
          ),
        ),
      ),
    );
  }
}
