describe('List', function() {
  beforeEach(module('taskApp'));

  var List, $httpBackend;

  beforeEach(inject(function(_List_, _$httpBackend_) {
    List = _List_;
    $httpBackend = _$httpBackend_;
  }));

  describe('#email', function() {
    it('emails the list', function() {
      $httpBackend.expectPOST('/email_list').respond(200);

      List.email({list_name: 'Books'});
      $httpBackend.flush();
    });
  })
});
