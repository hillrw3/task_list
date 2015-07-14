describe('TasksCtrl', function () {
  var $scope, $controller;

  beforeEach(module('taskApp'));

  beforeEach(inject(function (_$rootScope_, _$controller_) {
    $scope = _$rootScope_.$new();
    $controller = _$controller_;
    $controller('tasksCtrl', {$scope: $scope});
  }));


  describe('addTask', function() {
    it('adds a task to the "taskList"', function() {
      expect($scope.taskList).toEqual([]);
      $scope.newTask = 'new task';
      $scope.addTask();
      expect($scope.taskList).toEqual(['new task']);
    });

    it('does not add an empty string to the list', function() {
      $scope.newTask = '';
      $scope.addTask();
      expect($scope.taskList).toEqual([]);
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