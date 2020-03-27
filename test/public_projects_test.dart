// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
import 'package:flutter_test/flutter_test.dart';

main() {
//  group('fetchPublicProjects', () {
//    String endpoint = "/api/v0/public_projects";
//    String uri = url + endpoint;
//
//    test('returns Public Projects if the http call completes successfully',
//        () async {
//      final client = MockClient();
//
//      // Use Mockito to return a successful response when it calls the
//      // provided http.Client.
//      when(client.get(uri))
//          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
//
//      expect(await getPublicProjects(1),
//          const TypeMatcher<ProjectsResponse>());
//    });
//
//    test('throws an exception if the http call completes with an error', () {
//      final client = MockClient();
//
//      // Use Mockito to return an unsuccessful response when it calls the
//      // provided http.Client.
//      when(client.get(uri))
//          .thenAnswer((_) async => http.Response('Not Found', 404));
//
//      expect(getPublicProjects(1, client: client), throwsException);
//    });
//  });

  test("true", () {
    expect(true, true);
  });
}
