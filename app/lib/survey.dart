import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';
import './result.dart';

// ref: http://www.pediatricminds.com/wp-content/uploads/2011/06/Developmental-and-Behavioral-Questionnaire-for-Autism-Spectrum-Disorders.pdf
// ref: https://aseba.org/wp-content/uploads/CBCL_6-18_201-sample-copy-watermark-1.pdf
// ref: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4939629/

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    var steps = [
        InstructionStep(
            title: 'ASD checklist',
            text: 'Adapted from Child Behavior Checklist, a well established measure of behavioral problems in children, which has demonstrated moderate to high sensitivity and specificity in ASD diagnosis according to a study in Singapore',
            buttonText: 'Start',
        ),
        QuestionStep(
            title: 'Sports',
            text: 'Compared to others of the same age, about how much time does child spend in sports? For example: swimming, baseball, skating, skate boarding, bike riding, fishing, etc.',
            answerFormat: const SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Less Than Average', value: "2"),
                TextChoice(text: 'Average', value: "1"),
                TextChoice(text: 'More Than Average', value: "0"),
              ]
            )
        ),
        QuestionStep(
            title: 'Hobbies',
            text: 'Compared to others of the same age, about how much time does child spend in other hobbies? For example: video games, dolls, reading, piano, crafts, cars, etc.',
            answerFormat: const SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Less Than Average', value: "2"),
                TextChoice(text: 'Average', value: "1"),
                TextChoice(text: 'More Than Average', value: "0"),
              ]
            )
        ),
      QuestionStep(
          title: 'Social activities',
          text: 'About how many times a week does your child do things with any friends outside of regular school hours?',
          answerFormat: const SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Less Than 1', value: "2"),
                TextChoice(text: '1 or 2', value: "1"),
                TextChoice(text: '3 or more', value: "0"),
              ]
          )
      ),

        QuestionStep(
            title: 'Emotional',
            text: 'Prone to meltdowns, tantrums, violence, aggression, or rage. For example, cries, argues or screams a lot',
            answerFormat: const SingleChoiceAnswerFormat(
                textChoices: [
                  TextChoice(text: 'Yes', value: "2"),
                  TextChoice(text: 'No', value: "0"),
                ]
            )
        ),
        QuestionStep(
            title: 'Sleep deprivation',
            text: 'Inadequate or insufficient sleep sustained over a period of time.(9-12 hours of sleeping time is recommended for 6-12 years, and 8-10 hours for 13-18 years)',
            answerFormat: const SingleChoiceAnswerFormat(
                textChoices: [
                  TextChoice(text: 'Yes', value: "1"),
                  TextChoice(text: 'No', value: "0"),
                ]
            )
        ),




        CompletionStep(
          stepIdentifier: StepIdentifier(id: 'complete'),
          text: 'Thanks for taking the survey, result will be available soon.',
          title: 'Completed',
          buttonText: 'Submit',
        ),
    ];
    var task = OrderedTask(
      id: TaskIdentifier(id: 'task'),
      steps: steps
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASD checklist'),
      ),
      body: SurveyKit(
        onResult: (SurveyResult result) {
          var sum = 0;
          for (final taskResult in result.results) {
            for (final questionResult in taskResult.results) {
              if (questionResult.result is TextChoice) {
                final choice = (questionResult.result as TextChoice).value;
                final score = int.parse(choice);
                sum += score;
              }
            }
          }
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChecklistResult(score: sum),
          ));
        },
        task: task,
      )
    );
  }
}
