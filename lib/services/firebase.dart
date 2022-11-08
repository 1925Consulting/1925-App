import 'package:cloud_firestore/cloud_firestore.dart';

final String mainCollection = 'Information';
final String mainPageContent = ' Main_Page';
final String aboutUsInside = ' AboutUs';

final String services = ' Services';
final String servicesInside = 'services';

final String testimonials = ' Testimonials';
final String testimonialsInside = 'testimonials';

final String client = 'Client';
final String clientProject = 'projects';

final String projects = 'our_projects';
final String projectsInside = 'our_projects';

final String projectsData = 'ProjectScreenData';

Stream<DocumentSnapshot> getMainPageContent() {
  Stream<DocumentSnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(mainPageContent)
      .snapshots();

  return querySnapshot;
}

Future<void> test() async {
  QuerySnapshot _collectionRef =
      await FirebaseFirestore.instance.collection(mainCollection).get();
  print(_collectionRef.docs[5].id);
}

Stream<DocumentSnapshot> projectData() {
  Stream<DocumentSnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(projectsData)
      .snapshots();
  return querySnapshot;
  // QuerySnapshot _collectionRef = await FirebaseFirestore.instance.collection("Client").doc('a9mt4yUsCsVDJdog5Vq4ucEvJgJ2').collection('projects').get();
  // print(_collectionRef.docs.elementAt(0).id);
}

Stream<DocumentSnapshot> getAboutUsContent() {
  test();

  Stream<DocumentSnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(aboutUsInside)
      .snapshots();
  return querySnapshot;
}

Stream<QuerySnapshot> getServicesContent() {
  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(services)
      .collection(servicesInside)
      .orderBy("order", descending: false)
      .snapshots();
  return querySnapshot;
}

Stream<QuerySnapshot> getTestimonialsContent() {
  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(testimonials)
      .collection(testimonialsInside)
      .orderBy("date", descending: true)
      .snapshots();
  return querySnapshot;
}

Stream<QuerySnapshot> getProjectsContent() {
  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(mainCollection)
      .doc(projects)
      .collection(projectsInside)
      .snapshots();
  return querySnapshot;
}

// Client Projects

Stream<QuerySnapshot> getClientProjects(String uid) {
  Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
      .collection(client)
      .doc(uid)
      .collection(clientProject)
      .snapshots();
  return querySnapshot;
}
