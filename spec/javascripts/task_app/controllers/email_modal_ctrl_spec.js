describe('emailModalCtrl', function () {
  var $scope, $controller, $modalInstance, list, List, emailDeferred;

  beforeEach(module('taskApp'));

  beforeEach(inject(function ($rootScope, _$controller_, _$modal_, $q) {
    $scope = $rootScope.$new();

    $modalInstance = _$modal_.open({
      template: JST['task_app/templates/email_modal']()
    });

    List = {
      email: function () {
        emailDeferred = $q.defer();
        return {$promise: emailDeferred.promise}
      }
    };

    list = {id: 1, started_tasks: [], finished_tasks: []};

    $controller = _$controller_;
    $controller('emailModalCtrl', {$scope: $scope, $modalInstance: $modalInstance, List: List, list: list});
  }));

  describe('#send', function() {
    it('splits the recipientString into a comma-delimited array of emails', function() {
      $scope.recipientString = 'email@test.com, boo@yah.com';
      spyOn($scope, 'recipients');
      $scope.send();

      emailDeferred.resolve();
      $scope.$digest();

      expect($scope.recipients).toHaveBeenCalled()
    });

    it('closes the modal', function() {
      spyOn($modalInstance, 'dismiss');
      $scope.send();

      expect($modalInstance.dismiss).toHaveBeenCalled()
    });

    it('sets the recipientString as undefined', function() {
      $scope.recipientString = 'email@test.com, boo@yah.com';

      $scope.send();

      expect($scope.recipientString).toBeUndefined();
    });
  });
});