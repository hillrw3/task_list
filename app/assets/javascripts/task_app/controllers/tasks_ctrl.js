angular.module('taskApp').controller('tasksCtrl', ['$scope', 'Task', function ($scope, Task) {
    $scope.newTask = '';
    $scope.taskList = [];

    $scope.addTask = function addTask() {
      if($scope.newTask != '') {
        Task.save({description: $scope.newTask}).$promise.then(function(data) {
          $scope.taskList.push($scope.newTask);
          $scope.newTask = '';
        });
      }
    };

    $scope.removeTask = function removeTask(task) {
      var index = $scope.taskList.indexOf(task);
      if (index > -1) {
        $scope.taskList.splice(index, 1);
      }
    }
  }]
);