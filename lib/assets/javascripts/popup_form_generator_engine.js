function PopupFormGeneratorEngine (argument) {
  this.$body = $('body');
  if(argument) {
    this.$popupParent = this.$body.find('.' + argument.popupParentClass);
    this.$popupTriggerElement = this.$body.find('#' + argument.popupTriggerElementId)
  }
};

PopupFormGeneratorEngine.prototype.init = function() {
  this.bindEvents();
};


PopupFormGeneratorEngine.prototype.bindEvents = function() {
  this.setup();
};

PopupFormGeneratorEngine.prototype.setup = function() {
  this.generatePopupContainer();
  // this.generateForm();
  // this.configureForm();
  // if(this.$popupParent) {
  //   this.appendPopupContainer(this.$popupParent);
  // };
  this.bindTriggerElement();
};

PopupFormGeneratorEngine.prototype.generatePopupContainer = function() {
  this.$popup = $('<div/>');
  this.configurePopupCss();
  this.$popup.text('Test Text');
};

PopupFormGeneratorEngine.prototype.configurePopupCss = function() {
  this.$popup.css({
    'z-index': '999',
    'position': 'absolute',
    'top': '60px',
    'left': '25%',
    'margin-left': 'auto',
    'margin-right': 'auto',
    'padding': '50px',
    'width': '50%',
    'background-color': '#E7E7E7'
  });
};

PopupFormGeneratorEngine.prototype.appendPopupContainer = function(parent) {
  parent.append(this.$popup);
};

