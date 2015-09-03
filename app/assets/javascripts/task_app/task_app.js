//= require_self
//= require_tree ./controllers

angular.module('taskApp', ['ngResource', 'ui.bootstrap'])
  .config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    $httpProvider.defaults.headers.common['Accept'] = 'application/json';
  }]);
