function EditReplyManager (argument) {
  this.$body = $('body');
  this.$comments = this.$body.find('.' + argument.commentsClass);
  this.$editButtons = this.$comments.find('.' + argument.editButtonsClass);
  this.$replyFormContainers = this.$comments.find('.' + argument.replyFormContainersClass);
  this.replyContainerClass = argument.replyContainerClass;
  this.replyFormContainersClass = argument.replyFormContainersClass;
}

EditReplyManager.prototype.init = function() {
  this.bindEvents();
}

EditReplyManager.prototype.bindEvents = function() {
  this.bindEditButtons();
}

EditReplyManager.prototype.bindEditButtons = function() {
  this.$replyFormContainers.hide();
  var _this = this;
  this.$editButtons.on('mousedown', function(){
    var $this = $(this);
    var $comment = $(this.closest('.' + _this.replyContainerClass));
    var $formContainer = $comment.find('.' + _this.replyFormContainersClass);
    $formContainer.slideToggle();
    var nextToggleText = $this.text();
    $this.text($this.attr('toggle-text'));
    $this.attr('toggle-text', nextToggleText);
  });
}

$(function(){
  var argument = { commentsClass: 'comments',
                    editButtonsClass: 'reply-edit-button',
                    replyContainerClass: 'reply',
                    replyFormContainersClass: 'reply-edit-form' };

  var obj1 = new EditReplyManager(argument);
  obj1.init();
});
