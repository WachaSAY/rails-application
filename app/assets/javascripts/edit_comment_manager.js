function EditCommentManager (argument) {
  this.$body = $('body');
  this.$comments = this.$body.find('.' + argument.commentsClass);
  this.$editButtons = this.$comments.find('.' + argument.editButtonsClass);
  this.$editFormContainers = this.$comments.find('.' + argument.editFormContainersClass);
  this.commentContainerClass = argument.commentContainerClass;
  this.editFormContainersClass = argument.editFormContainersClass;
};

EditCommentManager.prototype.init = function() {
  this.bindEvents();
}

EditCommentManager.prototype.bindEvents = function() {
  this.bindEditButtons();
}

EditCommentManager.prototype.bindEditButtons = function() {
  this.$editFormContainers.hide();
  var _this = this;
  this.$editButtons.on('mousedown', function(){
    var $this = $(this);
    var $comment = $(this.closest('.' + _this.commentContainerClass));
    var $formContainer = $comment.find('.' + _this.editFormContainersClass);
    $formContainer.slideToggle();
    var nextToggleText = $this.text();
    $this.text($this.attr('toggle-text'));
    $this.attr('toggle-text', nextToggleText);
  });
}

$(function(){
  var argument = { commentsClass: 'comments',
                    editButtonsClass: 'comment-edit-button',
                    commentContainerClass: 'comment-container',
                    editFormContainersClass: 'comment-edit-form' };

  var obj1 = new EditCommentManager(argument);
  obj1.init();
});
