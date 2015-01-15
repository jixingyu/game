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
    this.parentElement;
};

BasicGame.Boot.prototype = {

    init: function () {

        // this.input.maxPointers = 1;
        // this.stage.disableVisibilityChange = true;

        // if (this.game.device.desktop)
        // {
        //     this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
        //     this.scale.setMinMax(480, 260, 1024, 768);
        //     this.scale.pageAlignHorizontally = true;
        //     this.scale.pageAlignVertically = true;
        //     this.scale.setScreenSize(true);
        //     this.scale.refresh();
        // }
        // else
        // {
        //     this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
        //     // this.scale.setMinMax(480, 260, 1024, 768);
        //     this.scale.pageAlignHorizontally = true;
        //     this.scale.pageAlignVertically = true;
        //     // this.scale.forceOrientation(true, false);
        //     // this.scale.setResizeCallback(this.gameResized, this);
        //     // this.scale.enterIncorrectOrientation.add(this.enterIncorrectOrientation, this);
        //     // this.scale.leaveIncorrectOrientation.add(this.leaveIncorrectOrientation, this);
        //     this.scale.setScreenSize(true);
        //     this.scale.refresh();
        // }
        this.parentElement = document.getElementById("game");
        this.game.scale.fullScreenTarget = this.parentElement;
        this.game.scale.scaleMode = Phaser.ScaleManager.USER_SCALE;
        this.game.scale.fullScreenScaleMode = Phaser.ScaleManager.SHOW_ALL;
        this.game.scale.pageAlignHorizontally = true;
        this.game.scale.pageAlignVertically = true;
        this.game.stage.disableVisibilityChange = true;
        this.game.input.maxPointers = 1;

        this.game.scale.setResizeCallback(function () {
            this.myresize(this.parentElement, this, false); 
            // you would probably just use this.game.scale.setResizeCallback(this.resize, this);
        }, this);

        this.game.state.start('Preload', true, false);

    },

    myresize: function (element, context, logging) {
        var _this = context;

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

        // A value of 1 means no scaling 0.5 means half size, 2 double the size and so on.
        var scale = Math.min(winWidth / _this.game.width, winHeight / _this.game.height);

        // Resize parent div in order to vertically center the canvas correctly.
        element.style.minHeight = winHeight.toString() + "px";

        // Resize the canvas keeping the original aspect ratio.
        _this.game.scale.setUserScale(scale, scale, 0, 0);

        var descobj=document.getElementById("desc");
        var infoobj=document.getElementById("info");
        descobj.style.top=winHeight * 0.7 + 'px';
        descobj.style.height=winHeight * 0.3 + 'px';
        infoobj.style.height=(winHeight * 0.3 - 30) + 'px';

        if (logging == true) {
            var w = Math.floor(_this.game.width * scale),
            h = Math.floor(_this.game.height * scale);
            console.info("The game has just been resized to: " + w + " x " + h);
        }
    },

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

        // game.stage.backgroundColor = '#000000';

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
    this.gameoverText;
    this.gameoverGroup;

    //  You can use any of these from any function within this State.
    //  But do consider them as being 'reserved words', i.e. don't create a property for your own game called "world" or you'll over-write the world reference.

};
// var descPanel;
BasicGame.Game.prototype = {

    create: function () {

        // this.add.sprite(0, 0, 'background');

        var turnGroup = game.add.group();
        var turntableCache = this.cache.getImage('turntable');
        circleX = game.width / 2;
        circleY = 100 + turntableCache.height / 2;
        this.turntable = turnGroup.create(circleX, circleY, 'turntable');
        this.turntable.anchor.setTo(0.5,0.5);

        var midPannel = turnGroup.create(circleX - 184, circleY - 247, 'mid-pannel');

        var lotteryButton = game.add.button(circleX, circleY, 'lottery', this.lottery, this);
        lotteryButton.anchor.setTo(0.5,0.5);

        // gameover group
        this.gameoverGroup = game.add.group();
        this.gameoverGroup.visible = false;
        var style = { font: "32px Arial", fill: "#ffffff", align: "center" };

        this.gameoverText = game.add.text(game.world.centerX, 40, '', style, this.gameoverGroup);
        this.gameoverText.anchor.setTo(0.5);

        // descPanel = new Phaser.Rectangle(0, 800, 680, 300);//game.debug.geom(descPanel,'#0fffff');
        // desc = "\n" + desc.replace(/###/g,"\n");
        // var descStyle = { font: "32px Arial", fill: "#ffffff", align: "center" };
        // descText = game.add.text(20, 800, desc, descStyle);
        // descText.inputEnabled = true;
        // descText.input.enableDrag();
        // descText.input.allowHorizontalDrag = false;
        var descobj=document.getElementById("desc");
        descobj.style.display="block";
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

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
        if(!isLogin && !!localStorage) {
            var today = new Date().toLocaleDateString();
            todayTimes = localStorage.getItem('todayTimes');
            lastDay = localStorage.getItem('lastDay');
            if (!lastDay || today != lastDay) {
                todayTimes = 0;
            }

            if (todayTimes >= freeNum) {
                alert('超过3次');
                return;
            }

            localStorage.setItem('todayTimes', ++todayTimes);
            localStorage.setItem('lastDay', today);
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
