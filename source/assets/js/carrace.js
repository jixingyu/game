var game=new Phaser.Game(360,540,Phaser.AUTO,"game");var carNum=8;BasicGame={};BasicGame.Boot=function(a){};BasicGame.Boot.prototype={init:function(){game.stage.backgroundColor=document.body.bgColor;if(window.innerWidth){winWidth=window.innerWidth;winHeight=window.innerHeight}else{if((document.body)&&(document.body.clientWidth)){winWidth=document.body.clientWidth;winHeight=document.body.clientHeight}else{if(document.documentElement&&document.documentElement.clientHeight&&document.documentElement.clientWidth){winHeight=document.documentElement.clientHeight;winWidth=document.documentElement.clientWidth}}}this.input.maxPointers=1;this.scale.parentIsWindow=true;if(winHeight/winWidth>1.3&&winHeight/winWidth<1.7){this.scale.scaleMode=Phaser.ScaleManager.EXACT_FIT}else{this.scale.scaleMode=Phaser.ScaleManager.SHOW_ALL}this.scale.pageAlignHorizontally=true;this.scale.pageAlignVertically=true},preload:function(){this.load.image("preloaderBar","assets/preloader.png");this.load.image("preloaderbar-bottom","assets/preloader-bottom.png")},create:function(){this.state.start("Preloader")},};BasicGame.Preloader=function(a){this.preloadBar=null;this.ready=false};BasicGame.Preloader.prototype={preload:function(){this.add.sprite(55,250,"preloaderbar-bottom");this.preloadBar=this.add.sprite(58,257,"preloaderBar");this.load.setPreloadSprite(this.preloadBar);this.load.image("menu-bg","assets/carrace/bg.png");this.load.image("start","assets/carrace/start.png");this.load.image("back","assets/carrace/back.png");this.load.image("confirm","assets/carrace/confirm.png");this.load.image("popup","assets/carrace/popup.png");this.load.spritesheet("rank","assets/horserace/rank.png",24,24);this.load.image("add","assets/carrace/add.png");this.load.image("sub","assets/carrace/sub.png");this.load.image("gameover","assets/horserace/gameover.png");this.load.image("light","assets/horserace/light.png");for(i=0;i<carNum;i++){hid=i+1;this.load.spritesheet("car"+hid,"assets/carrace/"+hid+".png",120,60)}this.load.image("runway-begin","assets/carrace/begin.png");this.load.image("runway","assets/carrace/runway.png");this.load.image("runway-end","assets/carrace/end.png");this.load.image("panel","assets/carrace/panel.png");this.load.spritesheet("stand","assets/carrace/stand.png",86,51);this.load.image("gamepoints","assets/gamepoints.png");this.load.audio("race-sound","assets/horserace/race.mp3")},create:function(){this.preloadBar.cropEnabled=false;this.state.start("MainMenu")},};myChips={};myChips.rank=[0,0,0];myChips.rankPoints=[0,0,0];BasicGame.MainMenu=function(a){this.music=null;this.selectedCar=null;this.betPoints=null;this.popup;this.rankButton=[];this.rankSprite=[];this.selectedRank=null;this.oldSelectedRank=null;this.ready=false;this.isPopup=false;this.pointsText};BasicGame.MainMenu.prototype={init:function(){if(this.selectedCar){this.selectedCar.destroy()}if(this.betPoints){this.betPoints.destroy()}if(this.popup){this.popup.destroy()}this.rankButton=[];if(this.rankSprite.length>0){for(i=0;i<this.rankSprite.length;i++){this.rankSprite[i].destroy()}}this.started=false;this.ready=false;this.selectedRank=null;this.oldSelectedRank=null;myChips.rank=[0,0,0];myChips.rankPoints=[0,0,0]},create:function(){game.world.setBounds(0,0,360,540);this.add.sprite(0,0,"menu-bg");var d=this.add.group();d.create(0,60,"gamepoints");this.pointsText=this.add.text(45,60,userpoints,{font:"20px Arial",fill:"#00CC00"},d);d.x=(game.world.width-d.width)/2;var b=45;var a=90;for(i=0;i<carNum;i++){var c=this.add.sprite(b,a,"stand",i);c.inputEnabled=true;c.events.onInputDown.add(this.bet,this);if(i%2==0){b+=185}else{b-=185;a+=95}}this.popup=this.add.group();this.popup.create(game.world.centerX,game.world.centerY,"popup").anchor.setTo(0.5);this.selectedCar=this.add.text(132,161,"",{font:"20px Arial",fill:"#ffffff"},this.popup);this.popup.visible=false;rankButtonX=112;for(i=0;i<3;i++){this.rankButton[i]=this.popup.create(rankButtonX,210,"rank",3+i);this.rankButton[i].inputEnabled=true;this.rankButton[i].events.onInputDown.add(this.toggleRank,this);this.rankButton[i].rankId=i;rankButtonX+=54}this.add.button(game.world.centerX,375,"confirm",this.closePopup,this,null,null,null,null,this.popup).anchor.setTo(0.5);this.add.button(55,315,"sub",this.subPoints,this,null,null,null,null,this.popup).anchor.setTo(0.5);this.add.button(305,315,"add",this.addPoints,this,null,null,null,null,this.popup).anchor.setTo(0.5);this.betPoints=this.add.text(150,300,chip,{font:"30px Arial",fill:"#000000"},this.popup);for(i=0;i<3;i++){this.rankSprite[i]=this.add.group()}this.add.button(game.world.centerX,480,"start",this.startGame,this).anchor.setTo(0.5,0)},update:function(){},bet:function(b){if(this.isPopup){return}this.selectedRank=this.oldSelectedRank=null;this.isPopup=true;var a=b.frame+1;this.selectedCar.setText(a);this.betPoints.setText(chip);for(i=0;i<3;i++){if(myChips.rank[i]==a){this.rankButton[i].loadTexture("rank",i);this.selectedRank=this.oldSelectedRank=i+1;this.betPoints.setText(myChips.rankPoints[i]);
break}}game.world.bringToTop(this.popup);this.popup.visible=true},closePopup:function(){this.popup.visible=false;var c=+this.betPoints.text;var b=+this.selectedCar.text;var a=0;if(this.oldSelectedRank){if(this.oldSelectedRank!=this.selectedRank||!c){myChips.rank[this.oldSelectedRank-1]=0;this.rankSprite[this.oldSelectedRank-1].visible=false}a+=myChips.rankPoints[this.oldSelectedRank-1]}if(this.selectedRank){this.rankButton[this.selectedRank-1].loadTexture("rank",this.selectedRank+2);if(c){this.selectedRank--;myChips.rank[this.selectedRank]=b;myChips.rankPoints[this.selectedRank]=c;a-=c;var e=45+(b-1)%2*185;var d=154+parseInt((b-1)/2)*95;if(this.rankSprite[this.selectedRank].length==0){this.rankSprite[this.selectedRank].create(0,0,"rank",this.selectedRank);this.add.text(30,0,c,{font:"20px Arial",fill:"#00CC00"},this.rankSprite[this.selectedRank]);this.rankSprite[this.selectedRank].x=e;this.rankSprite[this.selectedRank].y=d}else{this.rankSprite[this.selectedRank].x=e;this.rankSprite[this.selectedRank].y=d;this.rankSprite[this.selectedRank].getAt(1).setText(c);this.rankSprite[this.selectedRank].visible=true}}}this.updPoints(a);this.isPopup=false},toggleRank:function(c){var b=+this.selectedCar.text;var d=c.rankId;if(this.selectedRank&&this.selectedRank==d+1){c.loadTexture("rank",d+3);this.selectedRank=null}else{if(myChips.rank[d]&&myChips.rank[d]!=b){var a=this;sweetAlert({title:"确定要重新下注第"+(d+1)+"名吗?",text:"确定将会取消前次下注"+myChips.rank[d]+"号马为第"+(d+1)+"名!",type:"warning",showCancelButton:true,cancelButtonText:"取消",confirmButtonColor:"#DD6B55",confirmButtonText:"确定",closeOnConfirm:true},function(){myChips.rank[d]=0;a.updPoints(myChips.rankPoints[d]);a.rankSprite[c.rankId].visible=false;a.selectRank(c)})}else{this.selectRank(c)}}},updPoints:function(a){if(a!=0){userpoints+=a;this.pointsText.setText(userpoints)}},selectRank:function(a){if(this.selectedRank){this.rankButton[this.selectedRank-1].loadTexture("rank",this.selectedRank+2)}a.loadTexture("rank",a.rankId);this.selectedRank=a.rankId+1},addPoints:function(b,a){if(userpoints<chip){sweetAlert("您的积分不够");return}else{this.betPoints.setText(+this.betPoints.text+chip)}},subPoints:function(){var a=+this.betPoints.text;if(a>=chip){this.betPoints.setText(a-chip)}else{if(a>0){this.betPoints.setText(0)}}},startGame:function(){if(this.isPopup||this.started){return}var b=0;for(i=0;i<myChips.rank.length;i++){if(myChips.rank[i]>0&&myChips.rankPoints[i]>0){this.ready=true;b+=myChips.rankPoints[i]}else{if(myChips.rank[i]==0&&myChips.rankPoints[i]>0){myChips.rankPoints[i]=0}}}if(!this.ready){sweetAlert("请先下注");return}else{this.started=true;var a=this;ajax({url:"/carrace/start",data:myChips,onSuccess:function(c){var d=JSON.parse(c);if(d.code==0){a.state.start("Game",true,false,d.data.rank)}else{a.updPoints(b);ajaxError(d.code)}},})}}};BasicGame.Game=function(a){this.ranklist;this.players=[];this.panel;this.runwayLength=1080;this.runLength=900;this.startX=0;this.carPadding=10};BasicGame.Game.prototype={init:function(a){this.ranklist=a},create:function(){game.world.setBounds(0,0,this.runwayLength,540);game.add.tileSprite(0,0,game.world.width,game.height,"runway");game.add.sprite(50+this.startX,92,"runway-begin");game.add.sprite(this.startX+this.runLength+130-this.carPadding,92,"runway-end");this.panel=game.add.group();this.panel.create(0,0,"panel");this.panel.fixedToCamera=true;this.panel.cameraOffset.x=0;this.panel.cameraOffset.y=0;var a=8;if(myChips["rank"][0]){game.add.text(110,a,myChips["rank"][0]+"号  下注积分："+myChips["rankPoints"][0],{font:"20px Arial",fill:"#00CC00"},this.panel)}else{game.add.text(150,a,"未下注",{font:"20px Arial",fill:"#FF0000"},this.panel)}a+=26;if(myChips["rank"][1]){game.add.text(110,a,myChips["rank"][1]+"号  下注积分："+myChips["rankPoints"][1],{font:"20px Arial",fill:"#00CC00"},this.panel)}else{game.add.text(150,a,"未下注",{font:"20px Arial",fill:"#FF0000"},this.panel)}a+=26;if(myChips["rank"][2]){game.add.text(110,a,myChips["rank"][2]+"号  下注积分："+myChips["rankPoints"][2],{font:"20px Arial",fill:"#00CC00"},this.panel)}else{game.add.text(150,a,"未下注",{font:"20px Arial",fill:"#FF0000"},this.panel)}var b=90;for(i=0;i<carNum;i++){this.players[i]=game.add.sprite(this.startX,b+56*(this.ranklist[i]-1),"car"+this.ranklist[i],0)}this.raceSound=this.add.sound("race-sound",1,true);this.runStart()},runStart:function(){var d=this.rndDuration(7000,12000);cameraMoveTime=d[0];var c=this.runLength/4;var b=[];tweenLimit=4;for(i=0;i<carNum;i++){section=this.rndSection(d[i],this.runLength,tweenLimit);var a=game.add.tween(this.players[i]).to({x:this.startX+c},section[0],Phaser.Easing.Linear.None);for(tweenI=1;tweenI<tweenLimit;tweenI++){a.to({x:this.startX+c*(tweenI+1)},section[tweenI],Phaser.Easing.Linear.None)}if(i==7){a.chain(game.add.tween(this.players[i]).to({x:game.world.width},2000,Phaser.Easing.Linear.None));a.onComplete.add(function(){this.raceSound.fadeOut(1500);game.time.events.add(1000,this.gameover,this)},this);b[i]=a}else{a.to({x:game.world.width},2000,Phaser.Easing.Linear.None);
b[i]=a}}for(i=0;i<carNum;i++){this.players[i].animations.add("run");this.players[i].animations.play("run",12,true);b[i].start()}this.raceSound.play();game.add.tween(game.camera).to({x:720},cameraMoveTime,Phaser.Easing.Linear.None,true)},gameover:function(){var a=game.add.graphics(0,0);a.alpha=0.7;a.beginFill(0);a.drawRect(this.runwayLength-360,0,360,540);game.world.bringToTop(a);a.endFill();var b=this.add.group();b.create(this.runwayLength-175,game.world.centerY,"gameover").anchor.setTo(0.5);if(this.ranklist[1]==myChips.rank[1]){b.create(this.runwayLength-335,game.world.centerY-120,"light")}if(this.ranklist[0]==myChips.rank[0]){b.create(this.runwayLength-250,game.world.centerY-155,"light")}if(this.ranklist[2]==myChips.rank[2]){b.create(this.runwayLength-165,game.world.centerY-105,"light")}b.create(this.runwayLength-300,game.world.centerY-70,"stand",this.ranklist[1]-1);b.create(this.runwayLength-215,game.world.centerY-105,"stand",this.ranklist[0]-1);b.create(this.runwayLength-130,game.world.centerY-50,"stand",this.ranklist[2]-1);this.add.button(this.runwayLength-240,game.world.centerY+100,"back",function(){this.state.start("MainMenu")},this)},update:function(){},rndDuration:function(e,a){var f=this.rnd.integerInRange(e,a);var g=[];for(var d=0;d<carNum;d++){var b=0;do{for(var c=0;c<g.length;c++){if(g[c]==f){b=1;break}}if(!b){g[g.length]=f}else{f=this.rnd.integerInRange(e,a)}}while(!b)}g.sort(function(h,j){return h-j});return g},rndSection:function(duration,distance,limit){var t=duration/4;var intT=parseInt(t);var minT=parseInt(t*0.8);var maxT=parseInt(t*1.2);var tArray=[];var avg=distance/duration;for(k=0;k<limit;k++){if(k==limit-1){tArray[tArray.length]=duration-eval(tArray.join("+"))}else{if(k==3){var sum=eval(tArray.join("+"));if(sum/tArray.length>avg){tArray[tArray.length]=this.rnd.integerInRange(minT,intT)}else{if(sum/tArray.length<avg){tArray[tArray.length]=this.rnd.integerInRange(intT,maxT)}else{tArray[tArray.length]=this.rnd.integerInRange(minT,maxT)}}}else{tArray[tArray.length]=this.rnd.integerInRange(minT,maxT)}}}return tArray},};game.state.add("Boot",BasicGame.Boot);game.state.add("Preloader",BasicGame.Preloader);game.state.add("MainMenu",BasicGame.MainMenu);game.state.add("Game",BasicGame.Game);game.state.start("Boot");