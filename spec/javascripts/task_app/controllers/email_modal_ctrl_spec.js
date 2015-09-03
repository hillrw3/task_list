describe('emailModalCtrl', function () {
  var $scope, $controller;

  beforeEach(module('taskApp'));

  beforeEach(inject(function (_$rootScope_, _$controller_) {
    $scope = _$rootScope_.$new();
    $controller = _$controller_;
    $controller('emailModalCtrl', {$scope: $scope});
  }));

  describe('#recipients', function() {
    it('splits the recipientString into a comma-delimited array of emails', function() {
      $scope.recipientString = 'email@test.com, boo@yah.com';
      spyOn($scope.recipientString, 'split');
      $scope.recipients();

      expect($scope.recipientString.split).toHaveBeenCalledWith(',')
    })
  });
});