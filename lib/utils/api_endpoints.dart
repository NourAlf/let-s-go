class ApiEndPoints{
  static String baseUrl = 'https://present-ksa.com/api/';
  static _AuthEndPoints auth = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registrationwithEmail = 'register';
  final String loginEmail = 'login';
  final String addStudent = 'addstudent';
  final String getSchools='allschools';
  final String parent_children ='parent_children';

}