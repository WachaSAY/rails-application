function CommentReplyManager (argument) {
  this.$body = $('body');
  this.$comments = this.$body.find('.' + argument.commentsClass);
  this.$replyButtons = this.$comments.find('.' + argument.replyButtonsClass);
  this.$replyFormContainers = this.$comments.find('.' + argument.replyFormContainersClass);
  this.commentContainerClass = argument.commentContainerClass;
  this.replyFormContainersClass = argument.replyFormContainersClass;
}

CommentReplyManager.prototype.init = function() {
  this.bindEvents();
}

CommentReplyManager.prototype.bindEvents = function() {
  this.bindReplyButtons();
}

CommentReplyManager.prototype.bindReplyButtons = function() {
  this.$replyFormContainers.hide();
  var _this = this;
  this.$replyButtons.on('mousedown', function(){
    var $this = $(this);
    var $comment = $(this.closest('.' + _this.commentContainerClass));
    var $formContainer = $comment.find('.' + _this.replyFormContainersClass);
    $formContainer.slideToggle();
    var nextToggleText = $this.text();
    $this.text($this.attr('toggle-text'));
    $this.attr('toggle-text', nextToggleText);
  });
}

$(function(){
  var argument = { commentsClass: 'comments',
                    replyButtonsClass: 'comment-reply-button',
                    commentContainerClass: 'comment-container',
                    replyFormContainersClass: 'comment-reply-form' };

  var obj1 = new CommentReplyManager(argument);
  obj1.init();
});
