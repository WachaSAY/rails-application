function NotificationManager (argument) {
  this.$body = $('body');
  this.$notificationButton = this.$body.find('.' + argument.notificationButtonClass);
  this.$notificationBox = this.$body.find('.' + argument.notificationBoxClass);
}

NotificationManager.prototype.init = function() {
  this.bindButton();
}

NotificationManager.prototype.bindButton = function() {
  var _this = this;
  this.$notificationButton.on('mousedown', function(){
    _this.$notificationBox.slideToggle();
  });
}

$(function() {
  var argument = { notificationButtonClass: 'notification-button',
                    notificationBoxClass: 'notification-box' };
  var obj1 = new NotificationManager(argument);
  obj1.init();
});
