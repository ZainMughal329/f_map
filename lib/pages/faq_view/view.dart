import 'package:f_map/pages/faq_view/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/colors/app_colors.dart';
import '../../components/reuseable/reuseable_app_bar.dart';
import '../../components/reuseable/text_widget.dart';

class FAQScreen extends GetView<FAQController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reuseAbleAppBar("FAQ's", AppColors.buttonColor, AppColors.buttonTextColor, true),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FAQItem(
            question:
                'During the account creation process, how does the app prompt users to select their vehicle type?',
            answer:
                " When users create an account, they are prompted to select their vehicle type from options such as bus, car, or bike. This information helps in customizing the user experience and displaying relevant details related to their chosen vehicle type.",
          ),
          FAQItem(
            question:
                'Are there plans to expand the list of vehicle types available for selection in the future?',
            answer:
                'Future updates might include additional vehicle types based on user demand or evolving transportation trends, providing users with more options during account creation.',
          ),
          FAQItem(
            question:
                'How does the app handle the display of multiple vehicle types on the map simultaneously?',
            answer:
                'The app employs different symbols according to selected vehicle to represent various vehicle types on the map. Users can identify and track different types of vehicles based on these markers.',
          ),

          FAQItem(
            question: 'What does this app do?',
            answer:
                "This app uses Flutter and Google Maps to track the real-time locations of multiple users. It displays their locations on a map, alerts users when they're very close, shows their speed, calculates distances between them if they are within a 1km range, and estimates the time required to cover that distance.",
          ),
          FAQItem(
            question: 'How does the app show user locations on the map?',
            answer:
                "The app utilizes Google Maps API to fetch and display the real-time locations of multiple users on the map. Each user's location is updated continuously and represented by a marker on the map.",
          ),
          FAQItem(
            question: 'How does the app show user locations on the map?',
            answer:
                "The app uses the users' locations to calculate the distance between them. When users come very close to each other within a predefined distance threshold (e.g., less than 100 meters), an alert is triggered to notify them of their proximity.",
          ),

          FAQItem(
            question: 'How does the app display the speed of each user?',
            answer:
                "The app tracks the movement of each user by periodically updating their locations. It then calculates their speed based on the distance covered within specific time intervals and displays this information using speedometer.",
          ),
          FAQItem(
            question:
                'Can the app calculate the distance between users within a 1km range?',
            answer:
                'Yes, the app checks the distance between users. If they are within 1km of each other, it calculates the precise distance between them and presents this information to the user.',
          ),
          FAQItem(
            question:
                ' How does the app estimate the time it takes to cover the distance?',
            answer:
                'Using the distance calculated between users within the 1km range and their current speeds, the app estimates the time required to cover that distance based on their ongoing movements.',
          ),
          FAQItem(
            question:
                'Can users customize the range for proximity alerts or other settings?',
            answer:
                ' At this stage, the app might have predefined settings for proximity alerts and distance calculations. However, future updates may include settings that allow users to adjust these parameters based on their preferences.',
          ),
          FAQItem(
            question:
                ' Can users communicate or interact with others based on their vehicle types?',
            answer:
                'At this stage, the app does not provide any functionality that can help users to communicate or interact with others but may be in future there may be something alike.',
          ),
          // Add more FAQ items as needed
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextWidget(
          title: question,
          textColor: Colors.black,
          fontWeight: FontWeight.bold),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextWidget(
            title: answer,
            textColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
