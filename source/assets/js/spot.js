var game=new Phaser.Game(360,540,Phaser.AUTO,"game");BasicGame={};BasicGame.Boot=function(a){};BasicGame.Boot.prototype={init:function(){game.stage.backgroundColor=document.body.bgColor;if(window.innerWidth){winWidth=window.innerWidth;winHeight=window.innerHeight}else{if((document.body)&&(document.body.clientWidth)){winWidth=document.body.clientWidth;winHeight=document.body.clientHeight}else{if(document.documentElement&&document.documentElement.clientHeight&&document.documentElement.clientWidth){winHeight=document.documentElement.clientHeight;winWidth=document.documentElement.clientWidth}}}this.input.maxPointers=1;this.stage.disableVisibilityChange=true;this.scale.parentIsWindow=true;if(winHeight/winWidth>1.3&&winHeight/winWidth<1.7){this.scale.scaleMode=Phaser.ScaleManager.EXACT_FIT}else{this.scale.scaleMode=Phaser.ScaleManager.SHOW_ALL}this.scale.pageAlignHorizontally=true;this.scale.pageAlignVertically=true},preload:function(){this.load.image("preloaderBar","assets/preloader.png");this.load.image("preloaderbar-bottom","assets/preloader-bottom.png")},create:function(){this.state.start("Preloader")},};BasicGame.Preloader=function(a){this.preloadBar=null;this.ready=false};BasicGame.Preloader.prototype={preload:function(){this.add.sprite(55,250,"preloaderbar-bottom");this.preloadBar=this.add.sprite(58,257,"preloaderBar");this.load.setPreloadSprite(this.preloadBar);this.load.image("menu-header","assets/spot/menu-header.png");this.load.image("menu-mid","assets/spot/menu-mid.png");this.load.image("menu-footer","assets/spot/menu-footer.png");this.load.image("start","assets/spot/start.png");this.load.image("header","assets/spot/header.png");this.load.image("mid","assets/spot/mid.png");this.load.image("footer","assets/spot/footer.png");this.load.image("prompt","assets/spot/prompt.png");this.load.image("add-time","assets/spot/add-time.png");this.load.image("next","assets/spot/next.png");this.load.image("gamepoints","assets/gamepoints.png");this.load.json("sconfig","/spot/config")},create:function(){this.preloadBar.cropEnabled=false;this.state.start("MainMenu")},};BasicGame.MainMenu=function(a){this.music=null;this.playButton=null;this.scrollY;this.enableScroll};BasicGame.MainMenu.prototype={create:function(){this.add.sprite(0,0,"menu-header");var c=this.add.group();c.create(0,120,"gamepoints");this.pointsText=this.add.text(45,120,userpoints,{font:"20px Arial",fill:"#ffffff"},c);c.x=(game.world.width-c.width)/2;var b=this.cache.getJSON("sconfig").data.desc;descText=game.add.text(40,205,b,{font:"20px Arial",fill:"#000000"});var a=0;descY=270;if(descText.getLocalBounds().height<=135){game.add.sprite(0,descY,"menu-mid");descY+=62;this.enableScroll=false}else{this.enableScroll=true;for(i=1;i<=Math.ceil((descText.getLocalBounds().height-135)/62);i++){game.add.sprite(0,descY,"menu-mid");descY+=62;a++}}game.add.sprite(0,descY,"menu-footer");game.world.bringToTop(descText);if(this.enableScroll){game.world.setBounds(0,0,360,478+62*a);game.inputEnabled=true;game.input.onDown.add(this.beginScroll,this)}this.add.button(game.world.centerX,descY+100,"start",this.startGame,this).anchor.setTo(0.5,0)},update:function(){if(this.enableScroll&&game.input.activePointer.isDown){game.camera.y+=this.scrollY-game.input.activePointer.y;this.scrollY=game.input.activePointer.y}},beginScroll:function(){this.scrollY=game.input.activePointer.y},startGame:function(){this.state.start("Game",true,false)}};BasicGame.Game=function(a){this.simages;this.circles;this.found=0;this.currentLevel;this.levelText;this.upImage;this.downImage;this.myLoader;this.currentImage;this.defaultRadius=20;this.timeText;this.remainTimer;this.remainTime;this.promptTimes;this.promptText;this.addtTimes;this.nextText=null;this.addPointsText=null;this.ready=false;this.currentId;this.sconfig};BasicGame.Game.prototype={preload:function(){this.load.json("simages","/spot/images",true)},init:function(){this.currentLevel=0;this.promptTimes=0;this.addtTimes=0;this.currentId=0;this.ready=false;this.nextText=null;this.addPointsText=null;this.sconfig=this.cache.getJSON("sconfig");this.sconfig=this.sconfig.data;this.remainTime=parseInt(this.sconfig.i);this.sconfig.fr=parseInt(this.sconfig.fr);this.sconfig.rp=parseInt(this.sconfig.rp);this.sconfig.mr=parseInt(this.sconfig.mr);this.sconfig.at=parseInt(this.sconfig.at);this.sconfig.st=parseInt(this.sconfig.st);this.sconfig.t=parseInt(this.sconfig.t);this.sconfig.tp=parseInt(this.sconfig.tp);this.sconfig.mt=parseInt(this.sconfig.mt)},create:function(){this.simages=this.cache.getJSON("simages").data;if(!this.simages||this.simages.length<=0){sweetAlert("请检查网络");this.state.start("MainMenu");return}this.totalLevel=this.simages.length;this.myLoader=new Phaser.Loader(game);this.add.sprite(0,0,"header");this.add.sprite(0,255,"mid");this.add.sprite(0,485,"footer");this.add.button(10,500,"prompt",this.promptOnce,this);this.add.button(102,500,"add-time",this.addTime,this);this.promptText=this.add.text(53,506,this.sconfig.fr,{font:"15px Arial",fill:"#ffffff"});
this.levelText=this.add.text(305,22,"",{font:"28px Arial",fill:"#ffffff"});this.levelText.anchor.setTo(0.5);this.circles=game.add.graphics(0,0);this.nextLevel()},nextLevel:function(){this.found=0;this.ready=false;if(this.simages.length<=0){game.time.events.add(Phaser.Timer.SECOND,function(){var a=this;sweetAlert({title:"恭喜通关！"},function(){a.state.start("MainMenu")})},this).autoDestroy=true}else{if(this.currentLevel>0){if(!this.nextText){this.nextText=this.add.sprite(game.world.centerX,game.world.centerY,"next");this.nextText.anchor.setTo(0.5);this.nextText.scale.set(0)}else{this.nextText.scale.set(0);this.nextText.visible=true;game.world.bringToTop(this.nextText)}game.add.tween(this.nextText.scale).to({x:2,y:2},1000,Phaser.Easing.Sinusoidal.Out,true).onComplete.add(function(){this.nextText.visible=false;this.goNext()},this)}else{this.goNext()}}},goNext:function(){this.currentLevel++;this.levelText.setText(this.totalLevel+" - "+this.currentLevel);this.currentImage=this.simages.pop();this.currentImage.coordinate=JSON.parse(this.currentImage.coordinate);for(i=0;i<this.currentImage.coordinate.length;i++){this.currentImage.coordinate[i].x=parseInt(this.currentImage.coordinate[i].x);this.currentImage.coordinate[i].y=parseInt(this.currentImage.coordinate[i].y);if(parseInt(this.currentImage.coordinate[i].r)>0){this.currentImage.coordinate[i].iradius=this.currentImage.coordinate[i].r}else{this.currentImage.coordinate[i].iradius=this.defaultRadius}}this.myLoader.image("up","assets/spot/images/"+this.currentImage.image_ori,true);this.myLoader.image("down","assets/spot/images/"+this.currentImage.image_mod,true);if(this.currentLevel==1){this.myLoader.onLoadComplete.addOnce(this.firstLoaded,this);this.myLoader.start()}else{this.myLoader.onLoadComplete.addOnce(this.imageLoaded,this);this.myLoader.start()}},firstLoaded:function(){var a=this;ajax({url:"/spot/begin",data:{},onSuccess:function(b){var c=JSON.parse(b);if(c.code==0){a.currentId=c.data.i;a.ready=true;a.begin()}else{ajaxError(c.code)}},})},begin:function(){this.upImage=this.add.sprite(0,44,"up");this.downImage=this.add.sprite(0,274,"down");this.upImage.inputEnabled=true;this.upImage.events.onInputDown.add(this.check,this);this.downImage.inputEnabled=true;this.downImage.events.onInputDown.add(this.check,this);this.circles.lineStyle(3,16711680);game.world.bringToTop(this.circles);this.timeText=this.add.text(300,503,this.getRTime(),{font:"21px Arial",fill:"#ffffff"});this.remainTimer=game.time.events.loop(Phaser.Timer.SECOND,this.updateTime,this)},imageLoaded:function(){this.upImage.loadTexture("up");this.downImage.loadTexture("down");this.circles.clear();this.circles.lineStyle(3,16711680);this.ready=true},finishOne:function(){var a=this;ajax({url:"/spot/finish",data:{i:this.currentId,level:this.currentLevel},onSuccess:function(b){var c=JSON.parse(b);if(c.code==0){if(c.data&&c.data.points){a.showPoints("奖励"+c.data.points+"积分")}a.nextLevel()}else{ajaxError(c.code)}},})},showPoints:function(b){if(!this.addPointsText){this.addPointsText=this.add.text(game.world.centerX,30,b,{font:"20px Arial",fill:"#A6E22E"});this.addPointsText.anchor.setTo(0.5);this.addPointsText.alpha=0}else{this.addPointsText.setText(b);game.world.bringToTop(this.addPointsText)}var a=game.add.tween(this.addPointsText).to({alpha:1},1000,Phaser.Easing.Linear.None);a.to({alpha:0},500,Phaser.Easing.Linear.None);a.start()},updateTime:function(){if(!this.ready){return}this.remainTime--;if(this.remainTime<=0){game.time.events.remove(this.remainTimer);this.timeText.setText("00:00");this.ready=false;var b=false;var a=this;sweetAlert({title:"时间到！"},function(){b=true;a.state.start("MainMenu")});game.time.events.add(Phaser.Timer.SECOND*5,function(){if(!b){this.state.start("MainMenu")}},this).autoDestroy=true}else{this.timeText.setText(this.getRTime())}},getRTime:function(){minutes=Math.floor(this.remainTime/60);seconds=this.remainTime%60;if(minutes<10){minutes="0"+minutes}if(seconds<10){seconds="0"+seconds}return minutes+":"+seconds},check:function(a,b){for(i=0;i<this.currentImage.coordinate.length;i++){if((this.math.distance(b.x,b.y,this.currentImage.coordinate[i].x,this.currentImage.coordinate[i].y+44)<this.currentImage.coordinate[i].iradius)||(this.math.distance(b.x,b.y,this.currentImage.coordinate[i].x,this.currentImage.coordinate[i].y+274)<this.currentImage.coordinate[i].iradius)){this.circles.drawCircle(this.currentImage.coordinate[i].x,44+this.currentImage.coordinate[i].y,this.currentImage.coordinate[i].iradius*2);this.circles.drawCircle(this.currentImage.coordinate[i].x,274+this.currentImage.coordinate[i].y,this.currentImage.coordinate[i].iradius*2);this.found++;this.currentImage.coordinate.splice(i,1);this.remainTime+=this.sconfig.at;if(this.found==5){this.finishOne()}return}}this.remainTime-=this.sconfig.st},promptOnce:function(){if(!this.ready){return}if(this.promptTimes>=this.sconfig.fr+this.sconfig.mr){sweetAlert("每轮最多购买"+this.sconfig.mr+"次提醒")}else{if(this.promptTimes>=this.sconfig.fr){if(userpoints<this.sconfig.rp){sweetAlert("您的积分不够");
return}else{var a=this;ajax({url:"/spot/prompt",data:{i:this.currentId},onSuccess:function(b){var c=JSON.parse(b);if(c.code==0){userpoints-=a.sconfig.rp;if(a.found<4){a.showPoints("-"+a.sconfig.rp)}a.doPrompt()}else{ajaxError(c.code)}},})}}else{this.promptText.setText(this.sconfig.fr-this.promptTimes-1);this.doPrompt()}}},doPrompt:function(){this.promptTimes++;promptpoint=this.currentImage.coordinate.pop();this.circles.drawCircle(promptpoint.x,44+promptpoint.y,promptpoint.iradius*2);this.circles.drawCircle(promptpoint.x,274+promptpoint.y,promptpoint.iradius*2);this.found++;if(this.found==5){this.finishOne()}},addTime:function(){if(!this.ready){return}if(this.addtTimes>=this.sconfig.mt){sweetAlert("每轮最多加时"+this.sconfig.mt+"次")}else{if(userpoints<this.sconfig.t){sweetAlert("您的积分不够");return}else{var a=this;ajax({url:"/spot/timer",data:{i:this.currentId},onSuccess:function(b){var c=JSON.parse(b);if(c.code==0){userpoints-=a.sconfig.tp;a.remainTime+=a.sconfig.t;a.showPoints("-"+a.sconfig.tp);a.addtTimes++}else{ajaxError(c.code)}},})}}},update:function(){},};game.state.add("Boot",BasicGame.Boot);game.state.add("Preloader",BasicGame.Preloader);game.state.add("MainMenu",BasicGame.MainMenu);game.state.add("Game",BasicGame.Game);game.state.start("Boot");