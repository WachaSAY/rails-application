function AccountPictureManager (argument) {
  this.$body = $('body');
  this.$imageIcon = this.$body.find('.' + argument.imageIconClass);
  this.$imageModal = this.$body.find('#' + argument.imageModalId);
  this.$imageModalTriggerButton = this.$body.find('#' + argument.imageModalTriggerButtonId);
}

AccountPictureManager.prototype.init = function() {
  this.bindEvents();
}

AccountPictureManager.prototype.bindEvents = function() {
  this.bindImageIcon();
}

AccountPictureManager.prototype.bindImageIcon = function() {
  this.$imageModalTriggerButton.hide();
  var _this = this;
  this.$imageIcon.on('mousedown', function(){
    _this.$imageModalTriggerButton.click();
  });
}

$(function() {
  var argument = { imageIconClass: 'account-picture-icon',
                imageModalId: 'display-picture-modal',
                imageModalTriggerButtonId: 'display-picture-modal-trigger-button' };
  var obj1 = new AccountPictureManager(argument);
  obj1.init();
});
