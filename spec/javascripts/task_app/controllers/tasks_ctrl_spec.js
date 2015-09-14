describe('tasksCtrl', function () {
  var $scope, $controller, $modal, Task, deferred, finishDeferred, deleteDeferred, restartDeferred;

  beforeEach(module('taskApp'));

  beforeEach(inject(function ($rootScope, _$controller_, $q, _$modal_) {
    $scope = $rootScope.$new();
    $modal = _$modal_;

    Task = {
      save: function () {
        deferred = $q.defer();
        return {$promise: deferred.promise};
      },
      finish: function () {
        finishDeferred = $q.defer();
        return {$promise: finishDeferred.promise};
      },
      delete: function () {
        deleteDeferred = $q.defer();
        return {$promise: deleteDeferred.promise};
      },
      restart: function () {
        restartDeferred = $q.defer();
        return {$promise: restartDeferred.promise};
      }
    };

    $controller = _$controller_;
    $controller('tasksCtrl', {$scope: $scope, Task: Task});
  }));

  describe('#addTask', function() {
    var list;

    beforeEach(function() {
      list = {id: 1, started_tasks: []};
    });

    it('adds a task to the "taskList"', function() {
      $scope.newTask = {description: 'new task'};
      $scope.addTask(list);
      deferred.resolve({new: 'task'});
      $scope.$digest();

      expect(list.started_tasks).toEqual([{new: 'task'}]);
    });

    it('does not add an empty string to the list', function() {
      $scope.newTask = {description: ''};
      $scope.addTask(list);
      expect(list.started_tasks).toEqual([]);
    });

    it('adds the task to the database', function() {
      spyOn(Task, 'save').and.callThrough();
      $scope.newTask = {description: 'pump some iron'};
      $scope.addTask(list);

      expect(Task.save).toHaveBeenCalled();
    });
  });

  describe('#finishTask', function() {
    it('moves the task from the list of started tasks to the list of finished tasks', function() {
      var task = {id: 1, status: 'started'};
      $scope.list = {started_tasks: [task], finished_tasks: []};
      $scope.finishTask(task);

      finishDeferred.resolve();
      $scope.$digest();

      expect($scope.list).toEqual({started_tasks: [], finished_tasks: [task]});
    });
  });

  describe('#deleteTask', function() {
    it('removes a task from the finished_tasks list', function() {
      var task = {id: 1, status: 'finished'};
      $scope.list = {finished_tasks: [task]};
      $scope.deleteTask(task);

      deleteDeferred.resolve();
      $scope.$digest();

      expect($scope.list).toEqual({finished_tasks: []});
    });
  });

  describe('#restartTask', function() {
    it('it moves a task from finished_tasks to started_tasks', function() {
      var task = {id: 1, status: 'started'};
      $scope.list = {started_tasks: [], finished_tasks: [task]};
      $scope.restartTask(task);

      restartDeferred.resolve();
      $scope.$digest();

      expect($scope.list).toEqual({started_tasks: [task], finished_tasks: []});
    });
  });

  describe('#sendEmail', function() {
    it('opens the email modal', function() {
      spyOn($modal, 'open');

      $scope.sendEmail();

      expect($modal.open).toHaveBeenCalled()
    })
  });
});