describe('listsCtrl', function() {
  var $scope, $controller, $modal, List, queryDeferred, deleteDeferred;

  beforeEach(module('taskApp'));

  beforeEach(inject(function ($rootScope, _$controller_, $q, _$modal_) {
    $scope = $rootScope.$new();
    $modal = _$modal_;

    List = {
      query: function() {
        queryDeferred = $q.defer();
        return { $promise: queryDeferred.promise }
      },
      delete: function() {
        deleteDeferred = $q.defer();
        return { $promise: deleteDeferred.promise }
      }
    };

    $controller = _$controller_;
    $controller('listsCtrl', {$scope: $scope, List: List, $modal: $modal});
  }));

  describe('#init', function() {
    it('retrieves all the lists for a user', function() {
      $scope.init();

      queryDeferred.resolve([{name: 'list1'}, {name: 'list2'}]);
      $scope.$digest();

      expect($scope.lists).toEqual([{name: 'list1'}, {name: 'list2'}])
    });
  });

  describe('#openNewListModal', function() {
    it('opens a modal to create a new task list', function() {
      spyOn($modal, 'open');

      $scope.openNewListModal();

      expect($modal.open).toHaveBeenCalled();
    })
  });

  describe('#sendEmail', function() {
    it('opens the email modal', function() {
      spyOn($modal, 'open');

      $scope.sendEmail();

      expect($modal.open).toHaveBeenCalled()
    })
  });

  describe('#deleteList', function () {
    it('removes the list for $scope.lists', function() {
      var list = {id:1, name: 'Astronaut Gear'};
      $scope.lists = [list];

      $scope.deleteList(list);

      expect($scope.lists).toEqual([])
    });

    it('calls List#delete', function() {
      spyOn(List, 'delete');
      var list = {id:1, name: 'Astronaut Gear'};
      $scope.lists = [list];

      $scope.deleteList(list);

      expect(List.delete).toHaveBeenCalled();
    })
  });
});