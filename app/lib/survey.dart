import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

// ref: http://www.pediatricminds.com/wp-content/uploads/2011/06/Developmental-and-Behavioral-Questionnaire-for-Autism-Spectrum-Disorders.pdf
// ref: https://aseba.org/wp-content/uploads/CBCL_6-18_201-sample-copy-watermark-1.pdf
// ref: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4939629/

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    var steps = [
        InstructionStep(
            title: 'Child Behavior Checklist',
            text: 'Adapted for use in bravais',
            buttonText: 'Start survey',
        ),
        QuestionStep(
            title: 'Sports',
            text: 'Compared to others of the same age, about how much time does child spend in sports? For example: swimming, baseball, skating, skate boarding, bike riding, fishing, etc.',
            answerFormat: SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Less Than Average', value: "less"),
                TextChoice(text: 'Average', value: "average"),
                TextChoice(text: 'More Than Average', value: "more"),
                TextChoice(text: 'Don\'t know', value: "na"),
              ]
            )
        ),
        QuestionStep(
            title: 'Hobbies',
            text: 'Compared to others of the same age, about how much time does child spend in other hobbies? For example: video games, dolls, reading, piano, crafts, cars, etc.',
            answerFormat: SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Less Than Average', value: "less"),
                TextChoice(text: 'Average', value: "average"),
                TextChoice(text: 'More Than Average', value: "more"),
                TextChoice(text: 'Don\'t know', value: "na"),
              ]
            )
        ),
        QuestionStep(
            title: 'Hyperactive',
            text: 'Can’t sit still, restless, or hypeactive',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Cry',
            text: 'Cries a lot',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Scream',
            text: 'Screams a lot',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Bite',
            text: 'Bites fingernails',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Vomit',
            text: 'Vomiting, throwing up',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Attack',
            text: 'Physically attacks people',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Pick',
            text: 'Picks nose, skin, or other parts of body',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        QuestionStep(
            title: 'Repeat',
            text: 'Repeats certain acts over and over',
            answerFormat: BooleanAnswerFormat(
              positiveAnswer: 'Yes',
              negativeAnswer: 'No',
              result: BooleanResult.POSITIVE,
            ),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: 'complete'),
          text: 'Thanks for taking the survey, result will be available soon.',
          title: 'Completed',
          buttonText: 'Submit survey',
        ),
    ];
    var task = OrderedTask(
      id: TaskIdentifier(id: 'task'),
      steps: steps
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: SurveyKit(
        onResult: (SurveyResult result) {
          Navigator.pop(context);
        },
        task: task,
      )
    );
  }
}
