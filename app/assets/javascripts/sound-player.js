function SoundPlayer() {
  var self = this,
  pl = this,
  ua = navigator.userAgent,
  isTouchDevice = (ua.match(/ipad|ipod|iphone/i)),
  sm = soundManager;
  this.excludeClass = 'link-exclude';
	
  this.css = {
	// CSS class names appended to link during various states
    sDefault: 'sm2-panel', // default state
    sLoading: 'sm2-loading',
    sPlaying: 'sm2-playing',
    sPaused: 'sm2-paused'
  };
  
  this.includeClass = this.css.sDefault;
  
  this.banOtherSounds = function() {
  	if (pl.isTouchDevice) {
      sm.stopAll();
    } else {
      sm.pauseAll();
    };
  };
  
  this.clearEvent = function() {
  	$(".play-button").unbind();
  	$(".statusbar").unbind();
  };
  
  this.clearInfo = function() {
  	$(".position-time").text("0:00");
  	$(".loading").css("width", "0%");
  	$(".position").css("width", "0%");
  };
  
  this.init = function() {
    sm._writeDebug('soundPlayer.init()');
    var oLinks = $("a.sm2-link");
    var foundItem = 0;
    oLinks.parent().addClass(self.css.sDefault);
    oLinks.each(function() {
      if ((sm.getSoundById($(this).text()) == null) && (sm.canPlayURL($(this).attr("href")))) {
      	sm.createSound({
      		id: $(this).text(),
      		url: $(this).attr("href"),
      	});
        sm._writeDebug('soundPlayer.init(): Loading Song:'+$(this).text()+' from '+$(this).attr("href"));
        foundItem++;
      }
    });
    sm._writeDebug('soundPlayer.init(): Found '+foundItem+' new relevant items.');    
    
    pl.clearEvent();
    
    $(".play-button").click(function() {
      var sid = $(this).siblings("a").text();
      var panel = $(this).parent();
      var thisSound = sm.getSoundById(sid);
      
      if (panel.hasClass(pl.css.sDefault)) {
      	pl.banOtherSounds();
        
        sm.play(sid, {
          onplay: function() {
          	panel.removeClass(pl.css.sDefault);
            panel.addClass(pl.css.sPlaying);
            $("span.song-playing").show();
          },
          onpause: function() {
          	panel.removeClass(pl.css.sPlaying);
            panel.addClass(pl.css.sPaused);
            $("span.song-playing").hide();
          },
          onresume: function() {
          	panel.removeClass(pl.css.sPaused);
            panel.addClass(pl.css.sPlaying);
            $("span.song-playing").show();
          },
          onstop: function() {
          	panel.removeClass(pl.css.sPlaying);
          	panel.removeClass(pl.css.sPaused);
            panel.addClass(pl.css.sDefault);
            $("span.song-playing").hide();
          },
          onfinish: function() {
          	panel.removeClass(pl.css.sPlaying);
          	panel.addClass(pl.css.sDefault);
          	$("span.song-playing").hide();
          },
        });
      } else if (panel.hasClass(pl.css.sPlaying)) {
        thisSound.pause();
      } else if (panel.hasClass(pl.css.sPaused)) {
        pl.banOtherSounds();
        thisSound.resume();
      }
            
    });
  };

  this.init();
  
}

var soundPlayer = null;

soundManager.setup({
	debugMode: false,
	consoleOnly: false,
	preferFlash: false,
    url: '/swf',
	flashversion: 9
});

soundManager.onready(function() {
  // soundManager.createSound() etc. may now be called
  soundPlayer = new SoundPlayer();
});
