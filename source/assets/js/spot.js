var game = new Phaser.Game(720, 1080, Phaser.AUTO, 'game');

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

        if (winHeight / winWidth > 1.3 && winHeight / winWidth < 1.7) {
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
        } else {
            this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
        }
        this.scale.pageAlignHorizontally = true;
        this.scale.pageAlignVertically = true;
    },

    preload: function () {

        //  Here we load the assets required for our preloader (in this case a background and a loading bar)
        this.load.image('preloaderBar', 'assets/preloader.png');
        this.load.image('preloaderbar-bottom', 'assets/preloader-bottom.png');

    },

    create: function () {

        this.state.start('Preloader');

    },
};

BasicGame.Preloader = function (game) {
    this.preloadBar = null;

    this.ready = false;

};

BasicGame.Preloader.prototype = {

    preload: function () {
        this.add.sprite(100, 500, 'preloaderbar-bottom');
        this.preloadBar = this.add.sprite(106.5, 513.5, 'preloaderBar');

        this.load.setPreloadSprite(this.preloadBar);

        this.load.image('header','assets/spot/header.png');
        this.load.image('mid','assets/spot/mid.png');
        this.load.image('footer','assets/spot/footer.png');
        this.load.image('prompt','assets/spot/prompt.png');
        this.load.image('add-time','assets/spot/add-time.png');

        this.load.json('simages', '/spot/images');
    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};

BasicGame.MainMenu = function (game) {

    this.music = null;
    this.playButton = null;
    this.myChips = {};
};

BasicGame.MainMenu.prototype = {

    create: function () {
        this.startGame();
        // this.add.sprite(0, 0, 'titlepage');

        // this.playButton = this.add.button(400, 600, 'playButton', this.startGame, this, 'buttonOver', 'buttonOut', 'buttonOver');

    },

    update: function () {

        //  Do some nice funky main menu effect here

    },

    startGame: function () {

        //  Ok, the Play Button has been clicked or touched, so let's stop the music (otherwise it'll carry on playing)
        // this.music.stop();
        this.state.start('Game', true, false);
    }

};


BasicGame.Game = function (game) {
    this.simages;
    this.circles;
    this.found = 0;
    this.currentLevel = 0;
    this.upImage;
    this.downImage;
    this.myLoader;
    this.currentImage;
    this.defaultRadius = 20;
    this.timeText;
    this.remainTimer;
    this.remainTime = 10;//TODOconfig.initial_time;
    this.promptTimes = 0;
};

BasicGame.Game.prototype = {

    init: function () {
        this.simages = this.cache.getJSON('simages');
        this.simages = this.simages.data;
    },

    create: function () {
        this.myLoader = new Phaser.Loader(game);
        this.add.sprite(0, 0, 'header');
        this.add.sprite(0, 510, 'mid');
        this.add.sprite(0, 971, 'footer');
        this.add.sprite(20, 1000, 'prompt');
        this.add.sprite(170, 1000, 'add-time');

        this.circles = game.add.graphics(0, 0);
        this.nextLevel(true);
    },

    nextLevel: function (first) {
        this.currentLevel++;

        if (this.simages.length > 0) {
            this.currentImage = this.simages.pop();
            this.currentImage.coordinate = JSON.parse(this.currentImage.coordinate);
            for (i = 0; i < this.currentImage.coordinate.length; i++) {
                this.currentImage.coordinate[i].x = parseInt(this.currentImage.coordinate[i].x);
                this.currentImage.coordinate[i].y = parseInt(this.currentImage.coordinate[i].y);
                if (parseInt(this.currentImage.coordinate[i].r) > 0) {
                    this.currentImage.coordinate[i].iradius = this.currentImage.coordinate[i].r;
                } else {
                    this.currentImage.coordinate[i].iradius = this.defaultRadius;
                }
            }
            this.myLoader.image('up', 'assets/spot/images/' + this.currentImage.image_ori, true);
            this.myLoader.image('down', 'assets/spot/images/' + this.currentImage.image_mod, true);

            if (first) {
                this.myLoader.onLoadComplete.addOnce(this.firstLoaded, this);
                this.myLoader.start();
            } else {
                this.myLoader.onLoadComplete.addOnce(this.imageLoaded, this);
                this.myLoader.start();
            }
        }
    },

    firstLoaded: function() {
        this.upImage = this.add.sprite(0, 88,'up');
        this.downImage = this.add.sprite(0, 548,'down');

        this.upImage.inputEnabled = true;
        this.upImage.events.onInputDown.add(this.check, this);
        this.downImage.inputEnabled = true;
        this.downImage.events.onInputDown.add(this.check, this);
        this.circles.lineStyle(3, 0xff0000);
        game.world.bringToTop(this.circles);
        this.timeText = this.add.text(580, 1000, this.getRTime(), {font: "42px Arial", fill: "#ffffff"});
        this.remainTimer = game.time.events.loop(Phaser.Timer.SECOND, this.updateTime, this);
    },

    imageLoaded: function() {
        this.upImage.loadTexture('up');
        this.downImage.loadTexture('down');
        this.circles.clear();
        this.circles.lineStyle(3, 0xff0000);
    },

    updateTime: function () {
        this.remainTime--;
        if (this.remainTime <= 0) {
            //TODO gameover
            game.time.events.remove(this.remainTimer);
            this.timeText.setText('00:00');
        } else {
            this.timeText.setText(this.getRTime());
        }
    },

    getRTime: function () {
        minutes = Math.floor(this.remainTime / 60);
        seconds = this.remainTime % 60;

        if (minutes < 10) minutes = '0' + minutes;
        if (seconds < 10) seconds = '0' + seconds;

        return minutes + ':' + seconds;
    },

    check: function (sprite, pointer) {
        for (i = 0; i < this.currentImage.coordinate.length; i++) {
            if ((this.math.distance(pointer.x, pointer.y, this.currentImage.coordinate[i].x, this.currentImage.coordinate[i].y + 88) < this.currentImage.coordinate[i].iradius) ||
            (this.math.distance(pointer.x, pointer.y, this.currentImage.coordinate[i].x, this.currentImage.coordinate[i].y + 548) < this.currentImage.coordinate[i].iradius)) {
                this.circles.drawCircle(this.currentImage.coordinate[i].x, 88 + this.currentImage.coordinate[i].y, this.currentImage.coordinate[i].iradius * 2);
                this.circles.drawCircle(this.currentImage.coordinate[i].x, 548 + this.currentImage.coordinate[i].y, this.currentImage.coordinate[i].iradius * 2);
                this.found++;
                this.currentImage.coordinate.splice(i, 1);
                this.remainTime += config.right_add_time;
                if (this.found == 5) {
                    this.nextLevel(false);
                }
                return;
            }

        }
        this.remainTime -= config.wrong_sub_time;
    },

    prompt: function () {
        if (this.promptTimes >= config.free_reminder) {
            if (this.userPoints < config.reminder_points) {
                alert('您的积分不够');
                return;
            } else {
                this.userPoints -= config.reminder_points;
            }
        }
        this.promptTimes++;
        promptpoint = this.currentImage.pop();
        this.circles.drawCircle(promptpoint.x, 88 + promptpoint.y, promptpoint.iradius * 2);
        this.circles.drawCircle(promptpoint.x, 548 + promptpoint.y, promptpoint.iradius * 2);
        this.found++;

        if (this.found == 5) {
            this.nextLevel(false);
        }
    },

    addTime: function () {
        if (this.userPoints < config.time_chunk_points) {
            alert('您的积分不够');
            return;
        } else {
            this.userPoints -= config.time_chunk_points;
            this.remainTime += config.time_chunk;
        }
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },
};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('MainMenu',BasicGame.MainMenu);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
