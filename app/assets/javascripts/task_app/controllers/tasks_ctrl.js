angular.module('taskApp').controller('tasksCtrl', ['$scope', '$modal', 'Task', function ($scope, $modal, Task) {

    $scope.init = function init() {
      $scope.newTask = {description: ''};
    };

    $scope.addTask = function addTask(list) {
      if($scope.newTask.description!= '') {
        Task.save({description: $scope.newTask.description, list_id: list.id}).$promise.then(function(data) {
          list.started_tasks.push(data);
          $scope.newTask.description = '';
        });
      }
    };

    $scope.finishTask = function finishTask(task) {
      Task.finish({id: task.id}).$promise.then(function() {
        var index = $scope.list.started_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.started_tasks.splice(index, 1);
        }
        $scope.list.finished_tasks.push(task)
      })
    };

    $scope.deleteTask = function deleteTask(task) {
      Task.delete({id: task.id}).$promise.then(function() {
        var index = $scope.list.finished_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.finished_tasks.splice(index, 1);
        }
      })
    };

    $scope.restartTask = function restartTask(task) {
      Task.restart({id: task.id}).$promise.then(function(data) {
        var index = $scope.list.finished_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.finished_tasks.splice(index, 1);
        }
        $scope.list.started_tasks.push(task)
      })
    };

    $scope.sendEmail = function sendEmail(e, list) {
      if (e) {
        e.preventDefault();
        e.stopPropagation();
      }

      $modal.open({
        template: JST['task_app/templates/email_modal'](),
        controller: 'emailModalCtrl',
        resolve: {
          list: function() { return list }
        }
      })
    };
  }]
);