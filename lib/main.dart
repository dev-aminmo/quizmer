import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quizlertest/models/answer.dart';
import 'package:quizlertest/models/question.dart';
import 'package:quizlertest/question_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_home_page.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isInitialized = sharedPreferences.getBool('isInitialized');
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(AnswerAdapter());
  Hive.registerAdapter(QuestionAdapter());

  var questionsBox = await Hive.openBox<Question>('questions');
  List<Question> questionsList = [
    Question('ما هي عاصمة الجزائر؟', <Answer>[
      Answer(answerText: 'وهران'),
      Answer(answerText: 'الجزائر العاصمة', isCorrect: true),
      Answer(answerText: 'قسنطينة'),
      Answer(answerText: 'البليدة'),
    ]),
    Question('ما هي أقوى أنواع الحجارة', <Answer>[
      Answer(answerText: 'الرخام'),
      Answer(answerText: 'الغرانيت'),
      Answer(answerText: 'الألماس', isCorrect: true),
      Answer(answerText: 'الياقوت'),
    ]),
    Question('ما هي أكثر سورة تكرر فيها أسم الرحمن؟', <Answer>[
      Answer(answerText: 'سورة مريم', isCorrect: true),
      Answer(answerText: 'سورة البقرة'),
      Answer(answerText: 'سورة الرحمن'),
      Answer(answerText: 'سورة التين'),
    ]),
    Question('ما هي عاصمة السينغال؟', <Answer>[
      Answer(answerText: 'سان جوزيه'),
      Answer(answerText: 'سكوبيا'),
      Answer(answerText: 'داكار', isCorrect: true),
      Answer(answerText: 'ابيدجان'),
    ]),
    Question('أي بلد فاز بأكبر عدد من بطولات كأس العالم لكرة القدم ', <Answer>[
      Answer(answerText: 'إسبانيا'),
      Answer(answerText: 'البرازيل', isCorrect: true),
      Answer(answerText: 'إيطاليا'),
      Answer(answerText: 'ألمانيا'),
    ]),
    Question('كم عدد الدول التي يتكون منها حلف وارسو؟', <Answer>[
      Answer(answerText: '5'),
      Answer(answerText: '9'),
      Answer(answerText: '7', isCorrect: true),
      Answer(answerText: '11'),
    ]),
    Question('ما هي الطاقة التي يولدها البرق؟', <Answer>[
      Answer(answerText: 'مغناطيسية'),
      Answer(answerText: 'كهربائية', isCorrect: true),
      Answer(answerText: 'حرارية'),
      Answer(answerText: 'كهرومغناطيسية'),
    ]),
    Question('الغاز الذي يشكل حوالي 75 %من اجمالي كتلة الشمس هو…؟', <Answer>[
      Answer(answerText: 'النتروجين'),
      Answer(answerText: 'الأوكسجين'),
      Answer(answerText: 'الهيدروجين', isCorrect: true),
      Answer(answerText: 'الكالسيوم'),
    ]),
    Question('… هو تخصص في الطب يهتم بدراسة الأمراض', <Answer>[
      Answer(answerText: 'الباثولوجيا', isCorrect: true),
      Answer(answerText: 'الجيولوجيا'),
      Answer(answerText: 'البيولوجيا'),
      Answer(answerText: 'الايثولوجيا'),
    ]),
    Question('من هي أول دولة في العالم في إنتاج القطن؟', <Answer>[
      Answer(answerText: 'البرازيل'),
      Answer(answerText: 'اسبانيا'),
      Answer(answerText: 'كولومبيا'),
      Answer(answerText: 'ال و م أ', isCorrect: true),
    ]),
    Question('متى تم أفتتاح أول مترو أنفاق في العالم؟', <Answer>[
      Answer(answerText: '1880'),
      Answer(answerText: '1863', isCorrect: true),
      Answer(answerText: '1570'),
      Answer(answerText: '1920'),
    ]),
    Question('ما هو أطول مطار في الوطن العربي؟', <Answer>[
      Answer(answerText: 'مطار الشيخ زايد'),
      Answer(answerText: 'مطار الملك خالد', isCorrect: true),
      Answer(answerText: 'مطار السلطان قابوس'),
      Answer(answerText: 'مطار الملكة علياء'),
    ]),
    Question('كم يبلغ أرتفاع هرم خوفو في الجيزة؟', <Answer>[
      Answer(answerText: '188 متر'),
      Answer(answerText: '140 متر'),
      Answer(answerText: '139 متر', isCorrect: true),
      Answer(answerText: '100 متر'),
    ]),
    Question('كم مرة وردت كلمة (تلاوة) في القرآن الكريم؟', <Answer>[
      Answer(answerText: 'خمس مرات'),
      Answer(answerText: 'سبع مرات'),
      Answer(answerText: 'ثلاث مرات'),
      Answer(answerText: 'مرة واحدة', isCorrect: true),
    ]),
    Question(
        'من هو العالم الفيزيائي الذي أكتشف القوانين الأساسية للتيار الكهربائي؟',
        <Answer>[
          Answer(answerText: 'برستلي'),
          Answer(answerText: 'مالتوس'),
          Answer(answerText: 'اوهم', isCorrect: true),
          Answer(answerText: 'غراهام بيل'),
        ]),
    Question('كم عدد عظام الهيكل العظمي في الإنسان؟', <Answer>[
      Answer(answerText: '98'),
      Answer(answerText: '400'),
      Answer(answerText: '456'),
      Answer(answerText: '198', isCorrect: true),
    ]),
    Question('ما أكبر دولة منتجة للكاكاو في أفريقيا؟', <Answer>[
      Answer(answerText: 'السودان'),
      Answer(answerText: 'التشاد'),
      Answer(answerText: 'نيجيريا'),
      Answer(answerText: 'غانا', isCorrect: true),
    ]),
    Question('كم مكث المسلمون في صقلية؟', <Answer>[
      Answer(answerText: '100  سنة'),
      Answer(answerText: '180 سنة'),
      Answer(answerText: '250 سنة', isCorrect: true),
      Answer(answerText: '450 سنة'),
    ]),
    Question('في أي دولة تم أفتتاح أول مترو أنفاق في العالم؟', <Answer>[
      Answer(answerText: 'إيطاليا'),
      Answer(answerText: 'المانيا'),
      Answer(answerText: 'اليابان'),
      Answer(answerText: 'إنجلترا', isCorrect: true),
    ]),
    Question('حيوان يضرب به المثل في الشكر فيقال أشكر من….؟', <Answer>[
      Answer(answerText: 'كلب', isCorrect: true),
      Answer(answerText: 'قط'),
      Answer(answerText: 'جمل'),
      Answer(answerText: 'أسد'),
    ]),
    Question('ما هو أطول نهر في العالم؟', <Answer>[
      Answer(answerText: 'النيل'),
      Answer(answerText: 'الأمازون', isCorrect: true),
      Answer(answerText: 'الفرات'),
      Answer(answerText: 'تاجة'),
    ]),
    Question('من أخترع أول حاسبة؟', <Answer>[
      Answer(answerText: 'ديكارت'),
      Answer(answerText: 'اينشطاين'),
      Answer(answerText: 'غاليلي'),
      Answer(answerText: 'باسكال', isCorrect: true),
    ]),
    Question('من هو صاحب كتاب (البيان والتبيان)؟', <Answer>[
      Answer(answerText: 'الجاحظ', isCorrect: true),
      Answer(answerText: 'ابن المقفع'),
      Answer(answerText: 'ابن عبد ربه'),
      Answer(answerText: 'عبدالقاهر الجرجاني'),
    ]),
    Question('ماذا يقاس بالترمومتر المئوي؟', <Answer>[
      Answer(answerText: 'الزلازل'),
      Answer(answerText: 'سرعة الرياح'),
      Answer(answerText: 'درجة الحرارة', isCorrect: true),
      Answer(answerText: 'الضغط الجوي'),
    ]),
    Question('كم عدد الوان الطيف التي يتكون منها قوز قزح', <Answer>[
      Answer(answerText: '8'),
      Answer(answerText: '9'),
      Answer(answerText: '5'),
      Answer(answerText: '7', isCorrect: true),
    ]),
    Question('اين توجد أكبر غابة في العالم؟', <Answer>[
      Answer(answerText: 'أستراليا'),
      Answer(answerText: 'الهند'),
      Answer(answerText: 'روسيا', isCorrect: true),
      Answer(answerText: 'باكستان'),
    ]),
    Question('ما أخر سورة نزلت في مكة؟', <Answer>[
      Answer(answerText: 'سورة النصر'),
      Answer(answerText: 'سورة القارعة'),
      Answer(answerText: 'سورة المرسلات', isCorrect: true),
      Answer(answerText: 'سورة الزلزلة'),
    ]),
    Question('أين توجد جزيرة هوندو؟', <Answer>[
      Answer(answerText: 'ماليزيا'),
      Answer(answerText: 'اليابان', isCorrect: true),
      Answer(answerText: 'اندونيسيا'),
      Answer(answerText: 'ايران'),
    ]),
    Question('كم تبلغ حرارة جسم الإنسان العادية؟', <Answer>[
      Answer(answerText: '32 درجة مئوية'),
      Answer(answerText: '35 درجة مئوية'),
      Answer(answerText: '41 درجة مئوية'),
      Answer(answerText: '37 درجة مئوية', isCorrect: true),
    ]),
    Question('-أصغر عظمة في جسم الإنسان هي العظم الركابي فأين توجد؟', <Answer>[
      Answer(answerText: 'الأنف'),
      Answer(answerText: 'القدم'),
      Answer(answerText: 'الأذن', isCorrect: true),
      Answer(answerText: 'اليد'),
    ]),
    Question('القائد المسلم الذي فتح مدينة تدمر الأثرية هو؟', <Answer>[
      Answer(answerText: 'خالد بن الوليد', isCorrect: true),
      Answer(answerText: 'عمرو بن العاص'),
      Answer(answerText: 'شرحبيل بن حسنة'),
      Answer(answerText: 'سعد بن أبي وقاص'),
    ]),
    Question('في أي عام فرضت زكاة الفطر؟', <Answer>[
      Answer(answerText: 'العام الأول للهجرة'),
      Answer(answerText: 'العام الثاني للهجرة', isCorrect: true),
      Answer(answerText: 'العام الثالث للهجرة'),
      Answer(answerText: 'العام الرابع للهجرة'),
    ]),
    Question('أين يوجد مضيق البسفور؟', <Answer>[
      Answer(answerText: 'تركيا', isCorrect: true),
      Answer(answerText: 'فرنسا '),
      Answer(answerText: 'إيطاليا'),
      Answer(answerText: 'ألمانيا'),
    ]),
    Question('ما هي عاصمة ساحل العاج؟', <Answer>[
      Answer(answerText: 'رانغون'),
      Answer(answerText: 'فيانثيان'),
      Answer(answerText: 'ابيدجان', isCorrect: true),
      Answer(answerText: 'اولان باتور'),
    ]),
    Question('قبرص أخذت أسمها من اللاتينية (كيبروس) وهي تعني ؟', <Answer>[
      Answer(answerText: 'الحديد'),
      Answer(answerText: 'الذهب'),
      Answer(answerText: 'الفضة'),
      Answer(answerText: 'النحاس', isCorrect: true),
    ]),
    Question('أين يقع مقر منظمة الأمم المتحدة للأغذية؟', <Answer>[
      Answer(answerText: 'باريس'),
      Answer(answerText: 'واشنطن'),
      Answer(answerText: 'جنيف'),
      Answer(answerText: 'روما', isCorrect: true),
    ]),
    Question('كم ورد لفظ (سقر) في القرآن الكريم؟', <Answer>[
      Answer(answerText: 'أربع مرات', isCorrect: true),
      Answer(answerText: 'مرتان'),
      Answer(answerText: 'عشر مرات'),
      Answer(answerText: 'مرة واحدة'),
    ]),
    Question('ما هو الشي الذي يسمى (الجليد الجاف)؟', <Answer>[
      Answer(answerText: 'الأكسجين'),
      Answer(answerText: 'ثاني أكسيد الكربون الصلب', isCorrect: true),
      Answer(answerText: 'ثاني أكسيد الكالسيوم'),
      Answer(answerText: 'ثاني أكسيد البوتاسيوم'),
    ]),
    Question(
        'يعتبر ميناء روتردام أكبر الموانئ في القارة الأوربية ففي أي دولة يوجد؟',
        <Answer>[
          Answer(answerText: 'ألمانيا'),
          Answer(answerText: 'فرنسا'),
          Answer(answerText: 'بلجيكا'),
          Answer(answerText: 'هولندا', isCorrect: true),
        ]),
    Question('كم عدد خلفاء الدولة العباسية؟', <Answer>[
      Answer(answerText: '33'),
      Answer(answerText: '31'),
      Answer(answerText: '37', isCorrect: true),
      Answer(answerText: '44'),
    ]),
    Question('ماذا يقاس بمقياس بوفورت؟', <Answer>[
      Answer(answerText: 'الزلازل'),
      Answer(answerText: 'البراكين'),
      Answer(answerText: 'سرعة الرياح', isCorrect: true),
      Answer(answerText: 'الضغط'),
    ]),
    Question('ما هو المعدن الذي يحوي على موصلة حرارية؟', <Answer>[
      Answer(answerText: 'الألماس', isCorrect: true),
      Answer(answerText: 'الذهب'),
      Answer(answerText: 'الفضة'),
      Answer(answerText: 'المرجان'),
    ]),
    Question('دولة سان لوسيا من دول قارة…؟', <Answer>[
      Answer(answerText: 'أوروبا'),
      Answer(answerText: 'أوقيانوسيا'),
      Answer(answerText: 'أمريكا الشمالية', isCorrect: true),
      Answer(answerText: 'أمريكا الجنوبية'),
    ]),
    Question('من هو الرجل الكرى؟', <Answer>[
      Answer(answerText: 'الكسول'),
      Answer(answerText: 'الجبان'),
      Answer(answerText: 'النعسان', isCorrect: true),
      Answer(answerText: 'المريض'),
    ]),
    Question('العلم الذي سماه العرب (علم الحجر) هو علم …؟', <Answer>[
      Answer(answerText: 'الكيمياء', isCorrect: true),
      Answer(answerText: 'الفيزياء'),
      Answer(answerText: 'الصيدلة'),
      Answer(answerText: 'الطب'),
    ]),
    Question('من أول من ركب الخيل؟', <Answer>[
      Answer(answerText: 'قابيل ابن ادم'),
      Answer(answerText: 'نوح عليه السلام'),
      Answer(answerText: 'سليمان عليه السلام'),
      Answer(answerText: 'إسماعيل عليه السلام', isCorrect: true),
    ]),
    Question('أين أنشئت دولة الصليحيين؟', <Answer>[
      Answer(answerText: 'مصر'),
      Answer(answerText: 'المغرب'),
      Answer(answerText: 'سوريا'),
      Answer(answerText: 'اليمن', isCorrect: true),
    ]),
    Question('البوسنة والهرسك إحدى الدول الأوربية المطلة على…؟', <Answer>[
      Answer(answerText: 'البحر الأحمر'),
      Answer(answerText: 'البحر المالطي'),
      Answer(answerText: 'البحر المتوسط', isCorrect: true),
      Answer(answerText: 'البحر الأسود'),
    ]),
    Question('أين يقع نهر ماكتري؟', <Answer>[
      Answer(answerText: 'كندا', isCorrect: true),
      Answer(answerText: 'المكسيك'),
      Answer(answerText: 'البرازيل'),
      Answer(answerText: 'أمريكا'),
    ]),
    Question('الداء الذي يتسبب في تساقط الشعر يسمى..؟', <Answer>[
      Answer(answerText: 'الذئب'),
      Answer(answerText: 'الثعلب', isCorrect: true),
      Answer(answerText: 'القط'),
      Answer(answerText: 'القرد'),
    ]),
    Question('يتحمل العطش أكثر من الجمل؟', <Answer>[
      Answer(answerText: 'التمساح'),
      Answer(answerText: 'الزرافة', isCorrect: true),
      Answer(answerText: 'الاسد'),
      Answer(answerText: 'وحيد القرن'),
    ]),
    Question('أين توجد جزر القمر؟', <Answer>[
      Answer(answerText: 'المحيط الهندي', isCorrect: true),
      Answer(answerText: 'البحر الأسود'),
      Answer(answerText: 'المحيط الهادي'),
      Answer(answerText: 'المحيط الاطلسي'),
    ]),
    Question('ما هي الدولة التي شاهدت التلفزيون لأول مرة؟', <Answer>[
      Answer(answerText: 'الهند'),
      Answer(answerText: 'مصر'),
      Answer(answerText: 'فرنسا'),
      Answer(answerText: 'ال و م ا', isCorrect: true),
    ]),
    Question('الزمار هو صوت...؟', <Answer>[
      Answer(answerText: 'النعامة', isCorrect: true),
      Answer(answerText: 'البومة'),
      Answer(answerText: 'الطاووس'),
      Answer(answerText: 'اليمامة'),
    ]),
    Question(
        'الصحابي الذي كان من أوائل الأنصار إسلاماً لكنه لم يحضر بيعة العقبة الأولى هو...؟',
        <Answer>[
          Answer(answerText: 'جابر بن عبد الله', isCorrect: true),
          Answer(answerText: 'سعد بن خيثمة'),
          Answer(answerText: 'أسيد بن الحضير'),
          Answer(answerText: 'سعد بن عبادة'),
        ]),
    Question('ابن الظبية يسمى ...؟', <Answer>[
      Answer(answerText: 'درص'),
      Answer(answerText: 'ثقف'),
      Answer(answerText: 'هجرس'),
      Answer(answerText: 'رشا', isCorrect: true),
    ]),
    Question(
        'ما العمل الذي قال عنه الرسول صلى الله عليه وسلم بأنه سنام الدين؟',
        <Answer>[
          Answer(answerText: 'الصلاة'),
          Answer(answerText: 'الصوم'),
          Answer(answerText: 'الجهاد', isCorrect: true),
          Answer(answerText: 'الحج'),
        ]),
    Question('من هو مكتشف أشعة ألفا؟', <Answer>[
      Answer(answerText: 'رذرفورد', isCorrect: true),
      Answer(answerText: 'ايثيان جول ماري'),
      Answer(answerText: 'كاراكتي'),
      Answer(answerText: 'جون ووكر'),
    ]),
    Question(
        'الناقة التي بلغت من العمر ثلاث سنين ودخلت في الرابعة تسمى..؟',
        <Answer>[
          Answer(answerText: 'بنت مخاض'),
          Answer(answerText: 'بنت لبون'),
          Answer(answerText: 'حقة', isCorrect: true),
          Answer(answerText: 'جذعة'),
        ]),
    Question('ماذا تعني كلمة الخرس؟', <Answer>[
      Answer(answerText: 'طعام الولادة', isCorrect: true),
      Answer(answerText: 'طعام العرس'),
      Answer(answerText: 'طعام المأتم'),
      Answer(answerText: 'طعام عودة الغائب'),
    ]),
    Question('الحالبان هما من أجزاء الجهاز ...؟', <Answer>[
      Answer(answerText: 'التنفسي'),
      Answer(answerText: 'الهضمي'),
      Answer(answerText: 'العصبي'),
      Answer(answerText: 'البولي', isCorrect: true),
    ]),
    Question('ما هو صوت الضفدع؟', <Answer>[
      Answer(answerText: 'نقيق', isCorrect: true),
      Answer(answerText: 'نهيق'),
      Answer(answerText: 'حفيف'),
      Answer(answerText: 'لبيب'),
    ]),
    Question('ما اسم السورة التى تعدل ثلث القرآن؟', <Answer>[
      Answer(answerText: 'الناس'),
      Answer(answerText: 'الفلق'),
      Answer(answerText: 'الاخلاص', isCorrect: true),
      Answer(answerText: 'الكوثر'),
    ]),
    Question('ما هو اثقل حيوان في العالم؟', <Answer>[
      Answer(answerText: 'الأسد'),
      Answer(answerText: 'الفيل'),
      Answer(answerText: 'الزرافة'),
      Answer(answerText: 'الحوت الازرق', isCorrect: true),
    ]),
    Question('ماذا تعني كلمة بوذا؟', <Answer>[
      Answer(answerText: 'الدين'),
      Answer(answerText: 'العالم', isCorrect: true),
      Answer(answerText: 'الأرض'),
      Answer(answerText: 'السماء'),
    ]),
    Question('ما هو الشرك الأصغر؟', <Answer>[
      Answer(answerText: 'الكذب'),
      Answer(answerText: 'النفاق'),
      Answer(answerText: 'الرياء', isCorrect: true),
      Answer(answerText: 'النميمة'),
    ]),
    Question('ما هي أكثر دولة اشتهرت بالسوشي؟', <Answer>[
      Answer(answerText: 'الصين'),
      Answer(answerText: 'اليابان', isCorrect: true),
      Answer(answerText: 'تركيا'),
      Answer(answerText: 'كوريا'),
    ]),
    Question('ما هي المدينة الذي يطلق عليها مدينة الشمس؟', <Answer>[
      Answer(answerText: 'باريس'),
      Answer(answerText: 'لندن'),
      Answer(answerText: 'اسطنبول'),
      Answer(answerText: 'بعلبك', isCorrect: true),
    ]),
    Question('أين توجد أعلى نافورة إرتفاعاً في العالم؟', <Answer>[
      Answer(answerText: 'جدة', isCorrect: true),
      Answer(answerText: 'باريس'),
      Answer(answerText: 'دبي'),
      Answer(answerText: 'لندن'),
    ]),
    Question(' كم عدد السجدات في القرآن الكريم؟', <Answer>[
      Answer(answerText: '15', isCorrect: true),
      Answer(answerText: '16'),
      Answer(answerText: '17'),
      Answer(answerText: '23'),
    ]),
    Question('من هو نبي اليهود؟', <Answer>[
      Answer(answerText: 'عيسى عليه السلام'),
      Answer(answerText: 'يعقوب عليه السلام'),
      Answer(answerText: 'محمد عليه الصلاة و السلام'),
      Answer(answerText: 'موسى عليه السلام', isCorrect: true),
    ]),
    Question(
        'ما هو العضو الذي يوجد في جسم الإنسان المسؤول عن طرد السموم؟', <Answer>[
      Answer(answerText: 'القلب'),
      Answer(answerText: 'الكلى'),
      Answer(answerText: 'الكبد', isCorrect: true),
      Answer(answerText: 'البنكرياس'),
    ]),
    Question(' كم عدد العضلات الموجودة في جسم الانسان؟', <Answer>[
      Answer(answerText: '550'),
      Answer(answerText: '230'),
      Answer(answerText: '180'),
      Answer(answerText: '620', isCorrect: true),
    ]),
    Question(
        'ما هي العملية الجراحية الأكثر إجراءاً للإنسان في العالم؟', <Answer>[
      Answer(answerText: 'المرارة'),
      Answer(answerText: 'اللوزتين', isCorrect: true),
      Answer(answerText: 'القلب'),
      Answer(answerText: 'الكبد'),
    ]),
    Question('ما هو الحيوان الذي يطلق عليه البهنس؟', <Answer>[
      Answer(answerText: 'النمر'),
      Answer(answerText: 'الحصان'),
      Answer(answerText: 'الجمل'),
      Answer(answerText: 'الاسد', isCorrect: true),
    ]),
    Question('ما هى المدينة المسماة مدينة التلال السبع؟', <Answer>[
      Answer(answerText: 'نيو يورك'),
      Answer(answerText: 'القاهرة'),
      Answer(answerText: 'روما', isCorrect: true),
      Answer(answerText: 'ميلانو'),
    ]),
    Question('من هي أكثر الدول المنتجة للفول السوداني؟', <Answer>[
      Answer(answerText: 'الهند', isCorrect: true),
      Answer(answerText: 'الصين'),
      Answer(answerText: 'البرازيل'),
      Answer(answerText: 'اليابان'),
    ]),
    Question('ما اسم أول دولة استخدمت الطوابع البريدية؟', <Answer>[
      Answer(answerText: 'فرنسا'),
      Answer(answerText: 'المانيا'),
      Answer(answerText: 'امريكا'),
      Answer(answerText: 'بريطانيا', isCorrect: true),
    ]),
    Question(' كم عدد الساعات التي ينامها الاسد في اليوم ؟', <Answer>[
      Answer(answerText: '10'),
      Answer(answerText: '5'),
      Answer(answerText: '20', isCorrect: true),
      Answer(answerText: '16'),
    ]),
    Question('ما هي الدولة التي لديها اكبر احتياطي من النفط؟', <Answer>[
      Answer(answerText: 'العراق'),
      Answer(answerText: 'الجزائر'),
      Answer(answerText: 'قطر'),
      Answer(answerText: 'فنزويلا', isCorrect: true),
    ]),
    Question(' ما هو اقرب الكواكب الى الارض ؟', <Answer>[
      Answer(answerText: 'المريخ'),
      Answer(answerText: 'عطارد'),
      Answer(answerText: 'نبتون'),
      Answer(answerText: 'الزهرة', isCorrect: true),
    ]),
    Question(' كم عدد السور المدنية', <Answer>[
      Answer(answerText: '28', isCorrect: true),
      Answer(answerText: '40'),
      Answer(answerText: '35'),
      Answer(answerText: '21'),
    ]),
    Question('ما هي اقدم لغة مكتوبة في العالم', <Answer>[
      Answer(answerText: 'العربية'),
      Answer(answerText: 'الصينية', isCorrect: true),
      Answer(answerText: 'العبرية'),
      Answer(answerText: 'اللاتينية'),
    ]),
    Question('ما هي كبرى مدن القارة الأوربية', <Answer>[
      Answer(answerText: 'باريس'),
      Answer(answerText: 'روما'),
      Answer(answerText: 'لندن', isCorrect: true),
      Answer(answerText: 'واشنطن'),
    ]),
    Question('ما أول دولة استخدمت العلم كشعار للدولة', <Answer>[
      Answer(answerText: 'الدانمرك', isCorrect: true),
      Answer(answerText: 'الو م أ'),
      Answer(answerText: 'روسيا'),
      Answer(answerText: 'فرنسا'),
    ]),
    Question('كم دولة عربية تقع في افريقيا', <Answer>[
      Answer(answerText: '5'),
      Answer(answerText: '9', isCorrect: true),
      Answer(answerText: '7'),
      Answer(answerText: '10'),
    ]),
    Question('كم عدد الأنبياء الذين ذكروا في القرآن', <Answer>[
      Answer(answerText: '15'),
      Answer(answerText: '40'),
      Answer(answerText: '14'),
      Answer(answerText: '25', isCorrect: true),
    ]),
    Question('كم مرة تطرف العين في الدقيقة', <Answer>[
      Answer(answerText: '25', isCorrect: true),
      Answer(answerText: '55'),
      Answer(answerText: '60'),
      Answer(answerText: '44'),
    ]),
    Question('كم رجلا للعنكبوت', <Answer>[
      Answer(answerText: 'رجلان'),
      Answer(answerText: 'ثلاثة ارجع'),
      Answer(answerText: 'أربع أرجل'),
      Answer(answerText: 'ثمانية أرجل', isCorrect: true),
    ]),
    Question('ما هو أغلى المعادن سعرا في العالم', <Answer>[
      Answer(answerText: 'الحديد'),
      Answer(answerText: 'الذهب'),
      Answer(answerText: 'الراديوم', isCorrect: true),
      Answer(answerText: 'اليورانيوم'),
    ]),
    Question('كم مرة اعتمر فيها الرسول صلى الله عليه و سلم', <Answer>[
      Answer(answerText: 'مرة واحدة'),
      Answer(answerText: 'مرتان'),
      Answer(answerText: 'ثلاث مرات'),
      Answer(answerText: 'أربع مرات', isCorrect: true),
    ]),
    Question('كم عدد الدول التي تحتويها آسيا', <Answer>[
      Answer(answerText: '30 دولة'),
      Answer(answerText: '39 دولة', isCorrect: true),
      Answer(answerText: '25 دولة'),
      Answer(answerText: '40 دولة'),
    ]),
    Question('كم تبلغ نبضات الطفل في الدقيقة', <Answer>[
      Answer(answerText: '70'),
      Answer(answerText: '60'),
      Answer(answerText: '42'),
      Answer(answerText: '85', isCorrect: true),
    ]),
    Question('من هو أول نبي قام بكتابة الخط بالقلم', <Answer>[
      Answer(answerText: 'آدم عليه السلام'),
      Answer(answerText: 'عيسى عليه السلام'),
      Answer(answerText: 'ابراهيم عليه السلام'),
      Answer(answerText: 'ادريس عليه السلام', isCorrect: true),
    ]),
    Question('ماهو الغاز المستعمل في إطفاء الحرائق', <Answer>[
      Answer(answerText: 'الميثان', isCorrect: true),
      Answer(answerText: 'البروبان'),
      Answer(answerText: 'الهيدروجين'),
      Answer(answerText: 'ثاني اكسيد الكربون'),
    ]),
  ];

  if (isInitialized == false || isInitialized == null) {
    for (var s in questionsList) {
      questionsBox.add(s);
    }
    sharedPreferences.setBool('isInitialized', true);
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(questionsBox, sharedPreferences));
}

class MyApp extends StatefulWidget {
  final Box<dynamic> database;
  SharedPreferences sharedPreferences;

  MyApp(this.database, this.sharedPreferences);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QuestionProvider(widget.database, true, widget.sharedPreferences),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizmer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
