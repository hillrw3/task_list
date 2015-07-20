angular.module('taskApp').controller('tasksCtrl', ['$scope', 'Task', function ($scope, Task) {
    $scope.newTask = '';
    $scope.taskList = [];
    Task.query().$promise.then(function(data) {
      $scope.taskList = data
    });

    $scope.addTask = function addTask() {
      if($scope.newTask != '') {
        Task.save({description: $scope.newTask}).$promise.then(function(data) {
          $scope.taskList.push(data);
          $scope.newTask = '';
        });
      }
    };

    $scope.removeTask = function removeTask(task) {
      Task.delete({id: task.id}).$promise.then(function() {
        var index = $scope.taskList.indexOf(task);
        if (index > -1) {
          $scope.taskList.splice(index, 1);
        }
      })
    }
  }]
);