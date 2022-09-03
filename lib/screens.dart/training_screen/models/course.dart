// ignore_for_file: public_member_api_docs, sort_constructors_first
class Course {
  String author;
  String authorImg;
  String title;
  String imageUrl;
  Course(
    this.author,
    this.authorImg,
    this.title,
    this.imageUrl,
  );
  static List<Course> generateCourse() {
    return [
      Course('Luther King', 'images/nicole-2.jpg', 'Copywriting',
          r'images/copywriter.png'),
      Course('Luther King', 'images/graphics.png', 'Graphics Design',
          'images/graphics.png'),
      Course(
          'Luther King', 'images/graphics.png', 'UI & UX', 'images/uiux.jpg'),
      Course('Luther King', 'images/graphics.png', 'Programming',
          'images/programmer.png'),
      Course(
          'Luther King', 'images/graphics.png', 'UI & UX', 'images/uiux.jpg'),
      Course('Luther King', 'images/graphics.png', 'Marketing',
          'images/marketer.png'),
    ];
  }
}
// 