describe('TasksCtrl', function () {
  var $scope, $controller, Task, deferred, finishDeferred;

  beforeEach(module('taskApp'));

  beforeEach(inject(function ($rootScope, _$controller_, $q) {
    $scope = $rootScope.$new();

    Task = {
      save: function () {
        deferred = $q.defer();
        return {$promise: deferred.promise};
      },
      finish: function () {
        finishDeferred = $q.defer();
        return {$promise: finishDeferred.promise};
      }
    };

    $controller = _$controller_;
    $controller('tasksCtrl', {$scope: $scope, Task: Task});
  }));

  describe('addTask', function() {
    it('adds a task to the "taskList"', function() {
      var list = {id: 1, started_tasks: []};
      $scope.newTask = {description: 'new task'};
      $scope.addTask(list);
      deferred.resolve({new: 'task'});
      $scope.$digest();

      expect(list.started_tasks).toEqual([{new: 'task'}]);
    });

    it('does not add an empty string to the list', function() {
      var list = {id: 1, started_tasks: []};
      $scope.newTask = {description: ''};
      $scope.addTask(list);
      expect(list.started_tasks).toEqual([]);
    });

    it('adds the task to the database', function() {
      spyOn(Task, 'save').and.callThrough();
      var list = {id: 1, started_tasks: []};
      $scope.newTask = {description: 'pump some iron'};
      $scope.addTask(list);

      expect(Task.save).toHaveBeenCalled();
    });
  });

  describe('finishTask', function() {
    it('moves the task from the list of started tasks to the list of finished tasks', function() {
      var task = {id: 1, status: 'started'};
      $scope.list = {started_tasks: [task], finished_tasks: []};
      $scope.finishTask(task);

      finishDeferred.resolve();
      $scope.$digest();

      expect($scope.list).toEqual({started_tasks: [], finished_tasks: [task]});
    })
  })
});