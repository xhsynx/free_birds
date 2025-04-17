import 'auth_service.dart';
import 'class_service.dart';
import 'exam_service.dart';
import 'log_service.dart';
import 'parent_service.dart';
import 'student_service.dart';
import 'teacher_service.dart';
import 'user_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final AuthService auth = AuthService();
  final ClassService classes = ClassService();
  final ExamService exams = ExamService();
  final LogService logs = LogService();
  final ParentService parents = ParentService();
  final StudentService students = StudentService();
  final TeacherService teachers = TeacherService();
  final UserService users = UserService();
}
