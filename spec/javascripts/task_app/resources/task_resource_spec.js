describe('Task', function () {
  beforeEach(module('taskApp'));

  var Task, $httpBackend;

  beforeEach(inject(function (_Task_, _$httpBackend_) {
    Task = _Task_;
    $httpBackend = _$httpBackend_;
  }));

  describe('#save', function() {
    it('saves the task', function() {
      $httpBackend.expectPOST('/tasks.json').respond(200);
      Task.save();
      $httpBackend.flush();
    })
  })
});
