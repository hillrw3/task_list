describe('TasksCtrl', function () {
  var $scope, $controller, Task, deferred, queryDeferred, $q;

  beforeEach(module('taskApp'));

  beforeEach(inject(function (_$rootScope_, _$controller_, _Task_, _$q_) {
    $scope = _$rootScope_.$new();
    $controller = _$controller_;
    $controller('tasksCtrl', {$scope: $scope, Task: Task});
    $q = _$q_;
    Task = _Task_;

    Task = {
      save: function () {
        deferred = $q.defer();
        return {$promise: deferred.promise};
      },
      query: function () {
        queryDeferred = $q.defer();
        return {$promise: queryDeferred.promise};
      }
    };
  }));


  describe('addTask', function() {
    it('adds a task to the "taskList"', function() {
      expect($scope.taskList).toEqual([]);
      $scope.newTask = 'new task';
      $scope.addTask();
      deferred.resolve({new: 'task'});
      $scope.$digest();

      expect($scope.taskList).toEqual(['new task']);
    });

    it('does not add an empty string to the list', function() {
      $scope.newTask = '';
      $scope.addTask();
      expect($scope.taskList).toEqual([]);
    });

    it('adds the task to the database', function() {
      spyOn(Task, 'save').and.callThrough();
      $scope.newTask = 'new task';
      $scope.addTask();

      expect(Task.save).toHaveBeenCalled();
    });
  });

  describe('removeTask', function() {
    it('removes the task from the taskList', function() {
      $scope.taskList = ['Im temporary'];
      $scope.removeTask('Im temporary');
      expect($scope.taskList).toEqual([])
    })
  })
});