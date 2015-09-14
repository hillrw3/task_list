describe('Task', function () {
  beforeEach(module('taskApp'));

  var Task, $httpBackend;

  beforeEach(inject(function (_Task_, _$httpBackend_) {
    Task = _Task_;
    $httpBackend = _$httpBackend_;
  }));

  describe('#finish', function() {
    it('finishes the task', function() {
      $httpBackend.expectPATCH('/tasks/4/finish').respond(200);
      var task = {id: 4};
      Task.finish(task);
      $httpBackend.flush();
    })
  });

  describe('#restart', function() {
    it('restarts the task', function() {
      $httpBackend.expectPATCH('/tasks/4/restart').respond(200);
      var task = {id: 4};
      Task.restart(task);
      $httpBackend.flush();
    })
  });
});
