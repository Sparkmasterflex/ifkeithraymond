document.observe('dom:loaded', function(){
  $$('a[rel="external"]').invoke('writeAttribute', 'target', '_blank');

  if($('projects') && $('webpages')) {
    new SlideShow({
      parent: $('projects'),
      slides: $$('ul#projects li'),
      links: 'next'
    });
  }

  if($('constant') && $('slideshow')) {
    new SlideShow({
      parent: $('slideshow'),
      slides: $$('ul#slideshow li'),
      links: 'slide',
      caption: true,
      seconds: 4
    });
  }

  if($('gallery')) $('gallery').select('li a').each(function(el) {new Gallery({el: el, images: $('gallery').select('li a')});});

  if($('contact-form')) $$('input[type=text]', 'textarea').invoke('observe', 'focus', function(e){
    var el = Event.element(e),
        all = $('contact-form').select('label'),
        labels = el.up('.formfield').select('label');
    all.invoke('setStyle', {color: '#000'});
    labels.invoke('setStyle', {color: '#50030D'});
  });

  if($('about-text')) {
    new Effect.toggle($('resume-text'), 'blind', {
      duration: 0.3,
      afterFinish: function(effect) {
        var el = effect.element,
            elipse = new Element('a', {href: 'expand','class': 'elipse'});
        elipse.insert('Click to expand...');
        el.insert({after: elipse});
        elipse.observe('click', collapseExpand);
      }
    });
  }

  if($('contact-form')) $('contact-form').observe('submit', ajaxSubmit);
  if($('progress')) createProgressBar();
});

function collapseExpand(e){
  e.stop();
  var el = Event.element(e),
      about = $('about-text'),
      resume = $('resume-text'),
      elipse = new Element('a', {href: 'expand','class': 'elipse'});
  elipse.insert('Click to expand...');
  el.remove();
  resume.visible() ? resume.insert({after: elipse}) : about.insert({after: elipse});
  new Effect.toggle(about, 'blind', {duration: 0.5});
  new Effect.toggle(resume, 'blind', {duration: 0.5});
  elipse.observe('click', collapseExpand);
}

function ajaxSubmit(e) {
  e.stop();
  var el = Event.element(e);

  new Ajax.Request('/editor/contacts',{
    method: 'post',
    parameters: el.serialize(true),
    onComplete: function(transport) {
      var json = transport.responseText.evalJSON();
      $('contact-form').replace(json.output);
    }
  });
}

function createProgressBar() {
  var bar = $('progress'),
      p = bar.down('p'),
      white = bar.down('p.white'),
      percent = p.readAttribute('data_progress')/100,
      complete = bar.getWidth() * percent,
      left = bar.getWidth() - complete;

  p.setStyle({width: (complete - 5) + 'px'});
  white.setStyle({width: (left - 6) + 'px'});
  complete > left ? white.update(' ') : p.update(' ');
}