var game = new Phaser.Game(600, 900, Phaser.AUTO, 'game');

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

        this.input.maxPointers = 1;
        this.stage.disableVisibilityChange = true;

        if (this.game.device.desktop)
        {
            this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
            this.scale.setMinMax(480, 260, 1024, 768);
            this.scale.pageAlignHorizontally = true;
            this.scale.pageAlignVertically = true;
            this.scale.setScreenSize(true);
            this.scale.refresh();
        }
        else
        {
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
            // this.scale.setMinMax(480, 260, 1024, 768);
            this.scale.pageAlignHorizontally = true;
            this.scale.pageAlignVertically = true;
            // this.scale.forceOrientation(true, false);
            // this.scale.setResizeCallback(this.gameResized, this);
            // this.scale.enterIncorrectOrientation.add(this.enterIncorrectOrientation, this);
            // this.scale.leaveIncorrectOrientation.add(this.leaveIncorrectOrientation, this);
            this.scale.setScreenSize(true);
            this.scale.refresh();
        }

    },

    preload: function () {

        //  Here we load the assets required for our preloader (in this case a background and a loading bar)
        this.load.image('preloaderBar', 'assets/loading.gif');

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

        this.preloadBar = this.add.sprite(game.width/2, game.height/2, 'preloaderBar');
        this.preloadBar.anchor.setTo(0.5,0.5);

        this.load.setPreloadSprite(this.preloadBar);

        //  Here we load the rest of the assets our game needs.
        //  As this is just a Project Template I've not provided these assets, the lines below won't work as the files themselves will 404, they are just an example of use.
        this.load.image('background','assets/turntable/background.jpg');
        this.load.image('turntable','assets/turntable/turntable.png');
        this.load.image('lottery','assets/turntable/start-button.png');



        this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

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
        
        if (this.cache.isSoundDecoded('hit_ground_sound') && this.ready == false)
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
    this.turnGroup;
    this.ready = true;

    //  You can use any of these from any function within this State.
    //  But do consider them as being 'reserved words', i.e. don't create a property for your own game called "world" or you'll over-write the world reference.

};

BasicGame.Game.prototype = {

    create: function () {

        this.add.sprite(0, 0, 'background');

        this.turnGroup = game.add.group();
        var turntable = this.cache.getImage('turntable');
        turntableX = -turntable.width / 2;
        turntableY = -turntable.height / 2;
        this.turnGroup.create(turntableX, turntableY, 'turntable');

        this.turnGroup.x = game.world.centerX;
        this.turnGroup.y = 50 - turntableY;

        var startButton = this.cache.getImage('lottery');
        game.add.button(this.turnGroup.x - startButton.width / 2, this.turnGroup.y - startButton.height / 2 + 17, 'lottery', this.lottery, this);
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },

    lottery: function () {
        if (this.ready) {
            var _self = this;
            ajax({
                url: '/turntable/lottery',
                data: {},
                onSuccess: function(data) {
                    var resp = JSON.parse(data);
                    if (resp.code == 0) {
                        _self.turn(+resp.data.prize, +resp.data.angle, +res.limit);
                    }
                },
            });
        }
    },

    turn: function (prize, turnAngle, timeLimit) {
        if(!!localStorage) {
            todayTimes = localStorage.getItem('todayTimes');
            if (!todayTimes) {
                todayTimes = 0;
            }
        }

        if (todayTimes < timeLimit) {
            this.ready = false;
            if(!!localStorage) {
                localStorage.setItem('todayTimes', ++todayTimes);
            } else {
                ++todayTimes;
            }
            this.turnGroup.angle = 0;
            var circle = 3 + (Math.random() * 5 >>> 0);
            var duration = 2000 + (Math.random() * 3000 >>> 0);
            turnAngle = 360 * circle - turnAngle;
            game.add.tween(this.turnGroup).to({angle: turnAngle}, duration, Phaser.Easing.Circular.Out, true);
            var _self = this;
            setTimeout(function(){_self.ready=true;}, duration);
        } else {
            alert('超过3次');
        }
    }

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
