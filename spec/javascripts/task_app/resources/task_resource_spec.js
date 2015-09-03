describe('Task', function () {
  beforeEach(module('taskApp'));

  var Task, $httpBackend;

  beforeEach(inject(function (_Task_, _$httpBackend_) {
    Task = _Task_;
    $httpBackend = _$httpBackend_;
  }));

  describe('#finish', function() {
    it('finishes the task', function() {
      $httpBackend.expectPATCH('/tasks/4/finish.json').respond(200);
      Task.finish(4);
      $httpBackend.flush();
    })
  });

  describe('#restart', function() {
    it('restarts the task', function() {
      $httpBackend.expectPATCH('/tasks/4/restart.json').respond(200);
      Task.restart(4);
      $httpBackend.flush();
    })
  });
});
