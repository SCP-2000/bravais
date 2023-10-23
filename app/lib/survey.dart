import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

class Survey extends StatelessWidget {
  const Survey({super.key});

  @override
  Widget build(BuildContext context) {
    var steps = [
        InstructionStep(
            title: 'Your journey starts here',
            text: 'Have fun with a quick survey',
            buttonText: 'Start survey',
        ),
        QuestionStep(
            title: 'Your gender',
            text: 'gender',
            answerFormat: SingleChoiceAnswerFormat(
              textChoices: [
                TextChoice(text: 'Male', value: 'Male'),
                TextChoice(text: 'Female', value: 'Female'),
                TextChoice(text: 'Prefer not to answer', value: 'Not'),
              ]
            )
        )
    ];
    var task = OrderedTask(
      id: TaskIdentifier(id: '321'),
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
