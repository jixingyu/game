var game = new Phaser.Game(720, 1280, Phaser.AUTO, 'game');

BasicGame = {

    /* Here we've just got some global level vars that persist regardless of State swaps */
    // score: 0,

    /* If the music in your game needs to play through-out a few State swaps, then you could reference it here */
    // music: null,

    /* Your game can check BasicGame.orientated in internal loops to know if it should pause or not */
    // orientated: false

};

BasicGame.Boot = function (game) {
};

BasicGame.Boot.prototype = {

    init: function () {
        game.stage.backgroundColor = document.body.bgColor;
        if (window.innerWidth) {
            winWidth = window.innerWidth;
            winHeight = window.innerHeight;
        } else if ((document.body) && (document.body.clientWidth)) {
            winWidth = document.body.clientWidth;
            winHeight = document.body.clientHeight;
        } else if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
            winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
        }

        this.input.maxPointers = 1;
        this.stage.disableVisibilityChange = true;
        this.scale.parentIsWindow = true;

        if (winHeight / winWidth > 1.5 && winHeight / winWidth < 2) {
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
        } else {
            this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
        }
        this.scale.pageAlignHorizontally = true;
        this.scale.pageAlignVertically = true;
    },
    // init: function () {
    //     this.parentElement = document.getElementById("game");
    //     this.game.scale.fullScreenTarget = this.parentElement;
    //     this.game.scale.scaleMode = Phaser.ScaleManager.USER_SCALE;
    //     this.game.scale.fullScreenScaleMode = Phaser.ScaleManager.SHOW_ALL;
    //     this.game.scale.pageAlignHorizontally = true;
    //     this.game.scale.pageAlignVertically = true;
    //     this.game.stage.disableVisibilityChange = true;
    //     this.game.input.maxPointers = 1;

    //     this.game.scale.setResizeCallback(function () {
    //         this.myresize(); 
    //         // you would probably just use this.game.scale.setResizeCallback(this.resize, this);
    //     }, this);
    // },

    // myresize: function () {
    //     if (window.innerWidth) {
    //         winWidth = window.innerWidth;
    //         winHeight = window.innerHeight;
    //     } else if ((document.body) && (document.body.clientWidth)) {
    //         winWidth = document.body.clientWidth;
    //         winHeight = document.body.clientHeight;
    //     } else if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
    //         winHeight = document.documentElement.clientHeight;
    //         winWidth = document.documentElement.clientWidth;
    //     }

    //     // A value of 1 means no scaling 0.5 means half size, 2 double the size and so on.
    //     var scale = Math.min(window.innerWidth / this.game.width, window.innerHeight / this.game.height);

    //     // Resize parent div in order to vertically center the canvas correctly.
    //     this.parentElement.style.minHeight = window.innerHeight.toString() + "px";

    //     // Resize the canvas keeping the original aspect ratio.
    //     this.game.scale.setUserScale(scale, scale, 0, 0);

    //     var descobj=document.getElementById("desc");
    //     var infoobj=document.getElementById("info");
    //     descobj.style.top=winHeight * 0.7 + 'px';
    //     descobj.style.height=winHeight * 0.3 + 'px';
    //     infoobj.style.height=(winHeight * 0.3 - 30) + 'px';
    // },

    preload: function () {

        //  Here we load the assets required for our preloader (in this case a background and a loading bar)
        this.load.image('preloaderBar', 'assets/preloader.png');
        this.load.image('preloaderbar-bottom', 'assets/preloader-bottom.png');

    },

    create: function () {

        this.state.start('Preloader');

    },

    // gameResized: function (width, height) {

    //     //  This could be handy if you need to do any extra processing if the game resizes.
    //     //  A resize could happen if for example swapping orientation on a device or resizing the browser window.
    //     //  Note that this callback is only really useful if you use a ScaleMode of RESIZE and place it inside your main game state.

    // },

    // enterIncorrectOrientation: function () {

    //     BasicGame.orientated = false;

    //     document.getElementById('orientation').style.display = 'block';

    // },

    // leaveIncorrectOrientation: function () {

    //     BasicGame.orientated = true;

    //     document.getElementById('orientation').style.display = 'none';

    // }

};



BasicGame.Preloader = function (game) {
    this.preloadBar = null;

    this.ready = false;

};

BasicGame.Preloader.prototype = {

    preload: function () {
        this.add.sprite(100, 500, 'preloaderbar-bottom');
        this.preloadBar = this.add.sprite(106.5, 513.5, 'preloaderBar');
        // this.preloadBar.anchor.setTo(0.5,0.5);

        this.load.setPreloadSprite(this.preloadBar);

        //  Here we load the rest of the assets our game needs.
        //  As this is just a Project Template I've not provided these assets, the lines below won't work as the files themselves will 404, they are just an example of use.
        // this.load.image('background','assets/turntable/background.jpg');
        this.load.image('turntable',turntableImage);
        this.load.image('lottery','assets/turntable/start-button1.png');
        this.load.image('press','assets/turntable/press-button.png');
        this.load.image('mid-pannel','assets/turntable/mid.png');
        this.load.image('desc-pannel','assets/turntable/desc.png');
        this.load.image('ok','assets/ok.png');
        this.load.image('help','assets/help.png');
        this.load.image('music','assets/music.png');

        // this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

    },

    create: function () {

        //  Once the load has finished we disable the crop because we're going to sit in the update loop for a short while as the music decodes
        this.preloadBar.cropEnabled = false;

    },

    update: function () {

        //  You don't actually need to do this, but I find it gives a much smoother game experience.
        //  Basically it will wait for our audio file to be decoded before proceeding to the MainMenu.
        //  You can jump right into the menu if you want and still play the music, but you'll have a few
        //  seconds of delay while the mp3 decodes - so if you need your music to be in-sync with your menu
        //  it's best to wait for it to decode here first, then carry on.
        
        //  If you don't have any music in your game then put the game.state.start line into the create function and delete
        //  the update function completely.
        
        //if (this.cache.isSoundDecoded('hit_ground_sound') && this.ready == false)
        if (this.ready == false)
        {
            this.ready = true;
            this.state.start('Game');
        }

    }

};

BasicGame.Game = function (game) {

    //  When a State is added to Phaser it automatically has the following properties set on it, even if they already exist:

    this.add;       //  used to add sprites, text, groups, etc
    this.camera;    //  a reference to the game camera
    this.cache;     //  the game cache
    this.input;     //  the global input manager (you can access this.input.keyboard, this.input.mouse, as well from it)
    this.load;      //  for preloading assets
    this.math;      //  lots of useful common math operations
    this.sound;     //  the sound manager - add a sound, play one, set-up markers, etc
    this.stage;     //  the game stage
    this.time;      //  the clock
    this.tweens;    //  the tween manager
    this.world;     //  the game world
    this.particles; //  the particle manager
    this.physics;   //  the physics manager
    this.rnd;       //  the repeatable random number generator
    this.ready = true;
    this.award = '';
    this.costText;
    this.gameoverText;
    this.gameoverGroup;
    this.descGroup;
    this.descobj;
    this.remainNum;

    //  You can use any of these from any function within this State.
    //  But do consider them as being 'reserved words', i.e. don't create a property for your own game called "world" or you'll over-write the world reference.

};
// var descPanel;
BasicGame.Game.prototype = {

    create: function () {

        game.add.button(470, 10, 'help', this.toggleHelp, this);
        this.add.sprite(588, 10, 'music');

        var turnGroup = game.add.group();
        var turntableCache = this.cache.getImage('turntable');
        circleX = game.width / 2;
        circleY = 150 + turntableCache.height / 2;
        this.turntable = turnGroup.create(circleX, circleY, 'turntable');
        this.turntable.anchor.setTo(0.5,0.5);

        var midPannel = turnGroup.create(circleX - 184, circleY - 247, 'mid-pannel');

        var lotteryButton = game.add.button(circleX, circleY, 'lottery', this.lottery, this);
        lotteryButton.anchor.setTo(0.5,0.5);
        turnGroup.add(lotteryButton);

        this.remainNum = 0;
        if (isLogin) {
            this.remainNum = freeNum - todayNum;
        } else if (!isLogin && !!localStorage) {
            var today = new Date().toLocaleDateString();
            todayTimes = localStorage.getItem('todayTimes');
            lastDay = localStorage.getItem('lastDay');
            if (!lastDay || today != lastDay) {
                todayTimes = 0;
            }
            this.remainNum = freeNum - todayTimes;
        }

        this.costText = game.add.text(game.world.centerX, circleY + 130, '', { font: "32px Arial", fill: "#ffffff", align: "center" }, turnGroup);
        this.costText.anchor.setTo(0.5);
        this.showCost();

        game.add.text(100, 1000, '王小明', { font: "32px Arial", fill: "#ffffff", align: "center" }, turnGroup);


        // descPanel = new Phaser.Rectangle(0, 800, 680, 300);//game.debug.geom(descPanel,'#0fffff');
        // desc = "\n" + desc.replace(/###/g,"\n");
        // var descStyle = { font: "32px Arial", fill: "#ffffff", align: "center" };
        // descText = game.add.text(20, 800, desc, descStyle);
        // descText.inputEnabled = true;
        // descText.input.enableDrag();
        // descText.input.allowHorizontalDrag = false;
        this.descobj = document.getElementById("desc");
        var yScale = this.scale.height / 1280;
        var xScale = this.scale.width / 720;

        this.descobj.style.top=(0.5*(window.innerHeight-this.scale.height)+100*yScale) + 'px';
        this.descobj.style.left=(0.5*(window.innerWidth-this.scale.width)+50*xScale) + 'px';
        this.descobj.style.height=680*yScale + 'px';
        this.descobj.style.width=620*yScale + 'px';
        this.descobj.style.fontSize=(yScale == 1 ? xScale : yScale)*32 + 'px';

        this.descGroup = game.add.group();
        var panel = this.add.sprite(game.world.centerX, 20, 'desc-pannel');
        panel.anchor.setTo(0.5, 0);
        var okbutton = this.add.button(game.world.centerX, 10 + this.cache.getImage('desc-pannel').height, 'ok', this.toggleHelp, this);
        okbutton.anchor.setTo(0.5, 0);
        this.descGroup.add(panel);
        this.descGroup.add(okbutton);
        this.descGroup.visible = false;

        // gameover group
        this.gameoverGroup = game.add.group();
        this.gameoverGroup.visible = false;
        var style = { font: "32px Arial", fill: "#000000", align: "center" };

        this.gameoverText = game.add.text(game.world.centerX, 40, '', style, this.gameoverGroup);
        this.gameoverText.anchor.setTo(0.5);
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },

    showCost: function () {
        if (this.remainNum > 0) {
            this.costText.setText('免费(' + this.remainNum + ')');
        } else {
            this.costText.setText('每次' + consumePoints + '积分');
        }
    },

    toggleHelp: function () {
        if (this.descGroup.visible) {
            this.descGroup.visible = false;
            this.descobj.style.display="none";
        } else {
            this.descGroup.visible = true;
            this.descobj.style.display="block";
        }
    },

    lottery: function () {
        if (this.ready) {
            this.gameoverGroup.visible = false;
            var _self = this;
            ajax({
                url: '/turntable/lottery',
                data: {},
                onSuccess: function(data) {
                    var resp = JSON.parse(data);
                    if (resp.code == 0) {
                        _self.award = resp.data.award;
                        _self.turn(+resp.data.angle);
                    }
                },
            });
        }
    },

    turn: function (turnAngle) {
        if (isLogin && this.remainNum > 0) {
            this.remainNum--;
            this.showCost();
        }
        if(!isLogin && !!localStorage) {
            var today = new Date().toLocaleDateString();
            todayTimes = localStorage.getItem('todayTimes');
            lastDay = localStorage.getItem('lastDay');
            if (!lastDay || today != lastDay) {
                todayTimes = 0;
            }

            if (todayTimes >= freeNum) {
                alert('请登录');
                return;
            }

            localStorage.setItem('todayTimes', ++todayTimes);
            localStorage.setItem('lastDay', today);
            if (this.remainNum > 0) {
                this.remainNum--;
                this.showCost();
            }
        }
        this.ready = false;

        this.turntable.angle = 0;
        var circle = this.rnd.integerInRange(3, 8);
        var duration = this.rnd.integerInRange(2000, 3000);
        turnAngle = 360 * circle - turnAngle;
        var tw = game.add.tween(this.turntable).to({angle: turnAngle}, duration, Phaser.Easing.Circular.Out, true);
        tw.onComplete.add(this.endlottery, this);
    },

    endlottery: function () {
        this.ready = true;
        if (this.award == '') {
            var awardText = '很遗憾，未中奖';
        } else {
            var awardText = '恭喜，中了' + this.award + '！';
        }
        this.gameoverText.setText("\n" + awardText);
        this.gameoverGroup.visible = true;
    },

    // quitGame: function (pointer) {

    //     //  Here you should destroy anything you no longer need.
    //     //  Stop music, delete sprites, purge caches, free resources, all that good stuff.

    //     //  Then let's go back to the main menu.
    //     this.state.start('MainMenu');

    // }

};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
