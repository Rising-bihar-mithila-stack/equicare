class GetHealthQuestionsModel {
  int? status;
  HealthQuestions? healthQuestions;

  GetHealthQuestionsModel({this.status, this.healthQuestions});

  factory GetHealthQuestionsModel.fromJson(Map<String, dynamic> json) {
    return GetHealthQuestionsModel(
      status: json['status'] as int?,
      healthQuestions: json['health_questions'] == null
          ? null
          : HealthQuestions.fromJson(
              json['health_questions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'health_questions': healthQuestions?.toJson(),
      };

  GetHealthQuestionsModel copyWith({
    int? status,
    HealthQuestions? healthQuestions,
  }) {
    return GetHealthQuestionsModel(
      status: status ?? this.status,
      healthQuestions: healthQuestions ?? this.healthQuestions,
    );
  }
}

class HealthQuestions {
  int? categoryId;
  String? questionB;
  List<QuestionBa>? questionBA;
  String? questionBB;
  String? questionBC;
  String? questionBD;
  HealthQuestions({
    this.categoryId,
    this.questionB,
    this.questionBA,
    this.questionBB,
    this.questionBC,
    this.questionBD,
  });
  factory HealthQuestions.fromJson(Map<String, dynamic> json) {
    return HealthQuestions(
      categoryId: json['category_id'] as int?,
      questionB: json['question_b'] as String?,
      questionBA: (json['question_b_a'] as List<dynamic>?)
          ?.map((e) => QuestionBa.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionBB: json['question_b_b'] as String?,
      questionBC: json['question_b_c'] as String?,
      questionBD: json['question_b_d'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'question_b': questionB,
        'question_b_a': questionBA?.map((e) => e.toJson()).toList(),
        'question_b_b': questionBB,
        'question_b_c': questionBC,
        'question_b_d': questionBD,
      };

  HealthQuestions copyWith({
    int? categoryId,
    String? questionB,
    List<QuestionBa>? questionBA,
    String? questionBB,
    String? questionBC,
    String? questionBD,
  }) {
    return HealthQuestions(
      categoryId: categoryId ?? this.categoryId,
      questionB: questionB ?? this.questionB,
      questionBA: questionBA ?? this.questionBA,
      questionBB: questionBB ?? this.questionBB,
      questionBC: questionBC ?? this.questionBC,
      questionBD: questionBD ?? this.questionBD,
    );
  }
}

//

class QuestionBa {
  int? bAQuestionId;
  String? question;

  QuestionBa({this.bAQuestionId, this.question});

  factory QuestionBa.fromJson(Map<String, dynamic> json) => QuestionBa(
        bAQuestionId: json['question_id'] as int?,
        question: json['question'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'question_id': bAQuestionId,
        'question': question,
      };

  QuestionBa copyWith({
    int? bAQuestionId,
    String? question,
  }) {
    return QuestionBa(
      bAQuestionId: bAQuestionId ?? this.bAQuestionId,
      question: question ?? this.question,
    );
  }
}
