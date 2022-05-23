class datainfo {
  final int position;
  final String url;
  final String subname;
  final String iconImage;

  datainfo(
    this.position, {
    required this.url,
    required this.subname,
    required this.iconImage,
  });
}

List<datainfo> planets = [
  datainfo(
    1,
    url: '/patientfirstlook',
    subname: 'Get Started',
    iconImage: 'assets/images/jon-tyson-P_IpuFD1u3g-unsplash.jpg',
  ),
  datainfo(
    2,
    url: '/caretaker_login',
    subname: 'Caretaker Panel',
    iconImage: 'assets/images/resul-mentes-_1jRY4Imjdg-unsplash.jpg',
  ),
  datainfo(
    3,
    url: '/doctor_login',
    subname: 'Doctor Panel',
    iconImage: 'assets/images/jael-coon-qrLFPeH0Y3w-unsplash.jpg',
  ),
];
