var game = new Phaser.Game(360, 540, Phaser.AUTO, 'game');
var horseNum = 8;
BasicGame = {};

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
        this.add.sprite(game.world.centerX, game.world.centerY, 'preloaderbar-bottom').anchor.setTo(0.5);
        this.preloadBar = this.add.sprite(game.world.centerX, game.world.centerY, 'preloaderBar');
        this.preloadBar.anchor.setTo(0.5);

        this.load.setPreloadSprite(this.preloadBar);

        this.load.image('menu-bg','assets/horserace/bg.jpg');
        this.load.image('start','assets/horserace/start.png');
        this.load.image('back','assets/horserace/back.png');
        this.load.image('confirm','assets/horserace/confirm.png');
        this.load.image('popup','assets/horserace/popup.png');
        this.load.spritesheet('rank', 'assets/horserace/rank.png', 24, 24);
        this.load.image('add','assets/horserace/add.png');
        this.load.image('sub','assets/horserace/sub.png');
        this.load.image('gameover','assets/horserace/gameover.png');
        this.load.image('light','assets/horserace/light.png');

        for (i = 0; i < horseNum; i++) {
            hid = i + 1;
            this.load.spritesheet('horse' + hid, 'assets/horserace/' + hid + '.png', 130, 60);
        }

        this.load.image('runway-begin','assets/horserace/begin.png');
        this.load.image('runway','assets/horserace/runway.png');
        this.load.image('runway-end','assets/horserace/end.png');
        this.load.image('panel','assets/horserace/panel.png');
        this.load.spritesheet('stand','assets/horserace/stand.png', 87, 55);
        this.load.image('gamepoints','assets/gamepoints.png');

        // this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};

myChips = {};
myChips.rank = [0, 0, 0];
myChips.rankPoints = [0, 0, 0];

BasicGame.MainMenu = function (game) {

    this.music = null;
    this.selectedHorse = null;
    this.betPoints = null;
    this.popup;
    this.rankButton = [];
    this.rankSprite = [];
    this.selectedRank = null;
    this.oldSelectedRank = null;
    this.ready = false;
    this.isPopup = false;
    this.pointsText;
};

BasicGame.MainMenu.prototype = {

    init: function () {
        if (this.selectedHorse) {
            this.selectedHorse.destroy();
        }
        if (this.betPoints) {
            this.betPoints.destroy();
        }
        if (this.popup) {
            this.popup.destroy();
        }
        this.rankButton = [];
        if (this.rankSprite.length > 0) {
            for (i = 0; i < this.rankSprite.length; i++) {
                this.rankSprite[i].destroy();
            }
        }
        this.ready = false;
        this.selectedRank = null;
        this.oldSelectedRank = null;

        myChips.rank = [0, 0, 0];
        myChips.rankPoints = [0, 0, 0];
    },

    create: function () {
        game.world.setBounds(0, 0, 360, 540);
        this.add.sprite(0, 0, 'menu-bg');
        this.add.sprite(110, 50, 'gamepoints');
        this.pointsText = this.add.text(160, 50, userpoints, { font: "20px Arial", fill: "#00CC00" });
        var horseX = 59;
        var horseY = 90;
        for (i = 0; i < horseNum; i++) {
            var h = this.add.sprite(horseX, horseY, 'stand', i);
            h.inputEnabled = true;
            h.events.onInputDown.add(this.bet, this);
            if (i % 2 == 0) {
                horseX += 155;
            } else {
                horseX -= 155;
                horseY += 100;
            }
        }
        this.popup = this.add.group();
        this.popup.create(game.world.centerX, game.world.centerY,'popup').anchor.setTo(0.5);
        this.selectedHorse = this.add.text(132, 161, '', { font: "20px Arial", fill: "#ffffff" }, this.popup);
        this.popup.visible = false;
        rankButtonX = 112;
        for (i = 0; i < 3; i++) {
            this.rankButton[i] = this.popup.create(rankButtonX, 210, 'rank', 3 + i);
            this.rankButton[i].inputEnabled = true;
            this.rankButton[i].events.onInputDown.add(this.toggleRank, this);
            this.rankButton[i].rankId = i;
            rankButtonX += 54;
        }
        this.add.button(game.world.centerX, 375, 'confirm', this.closePopup, this, null, null, null, null, this.popup).anchor.setTo(0.5);
        this.add.button(55, 315, 'sub', this.subPoints, this, null, null, null, null, this.popup).anchor.setTo(0.5);
        this.add.button(305, 315, 'add', this.addPoints, this, null, null, null, null, this.popup).anchor.setTo(0.5);
        this.betPoints = this.add.text(150, 300, chip, { font: "30px Arial", fill: "#000000" }, this.popup);

        for (i = 0; i < 3; i++) {
            this.rankSprite[i] = this.add.group();
        }

        this.add.button(game.world.centerX, 495, 'start', this.startGame, this).anchor.setTo(0.5, 0);

    },

    update: function () {
    },

    bet: function (sprite) {
        if (this.isPopup) {
            return;
        }
        this.selectedRank = this.oldSelectedRank = null;
        this.isPopup = true;
        var horseId = sprite.frame + 1;
        this.selectedHorse.setText(horseId);
        this.betPoints.setText(chip);
        for (i = 0; i < 3; i++) {
            if (myChips.rank[i] == horseId) {
                this.rankButton[i].loadTexture('rank', i);
                this.selectedRank = this.oldSelectedRank = i + 1;
                this.betPoints.setText(myChips.rankPoints[i]);
                break;
            }
        }
        game.world.bringToTop(this.popup);
        this.popup.visible = true;
    },

    closePopup: function () {
        this.popup.visible = false;
        var myBet = +this.betPoints.text;
        var horseId = +this.selectedHorse.text;
        var updP = 0;
        if (this.oldSelectedRank) {
            if (this.oldSelectedRank != this.selectedRank || !myBet) {
                myChips.rank[this.oldSelectedRank - 1] = 0;
                this.rankSprite[this.oldSelectedRank - 1].visible = false;
            }
            updP += myChips.rankPoints[this.oldSelectedRank - 1];
        }
        if (this.selectedRank) {
            this.rankButton[this.selectedRank - 1].loadTexture('rank', this.selectedRank + 2);
            if (myBet) {
                this.selectedRank--;
                myChips.rank[this.selectedRank] = horseId;
                myChips.rankPoints[this.selectedRank] = myBet;
                updP -= myBet;
                var tempX = 55 + (horseId - 1) % 2 * 155;
                var tempY = 155 + parseInt((horseId - 1) / 2) * 100;
                if (this.rankSprite[this.selectedRank].length == 0) {
                    this.rankSprite[this.selectedRank].create(0, 0, 'rank', this.selectedRank);
                    this.add.text(40, 0, myBet, { font: "20px Arial", fill: "#00CC00" }, this.rankSprite[this.selectedRank]);
                    this.rankSprite[this.selectedRank].x = tempX;
                    this.rankSprite[this.selectedRank].y = tempY;
                } else {
                    this.rankSprite[this.selectedRank].x = tempX;
                    this.rankSprite[this.selectedRank].y = tempY;
                    this.rankSprite[this.selectedRank].getAt(1).setText(myBet);
                    this.rankSprite[this.selectedRank].visible = true;
                }
            }
        }
        this.updPoints(updP);
        this.isPopup = false;
    },

    toggleRank: function (sprite) {
        var horseId = +this.selectedHorse.text;
        var rankId = sprite.rankId;
        if (this.selectedRank && this.selectedRank == rankId + 1) {
            sprite.loadTexture('rank', rankId + 3);
            this.selectedRank = null;
        } else {
            if (myChips.rank[rankId] && myChips.rank[rankId] != horseId) {
                var _self = this;
                sweetAlert({
                    title: "确定要重新下注第" + (rankId + 1) + "名吗?",
                    text: "确定将会取消前次下注" + myChips.rank[rankId] + "号马为第" + (rankId + 1) + "名!",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定",
                    closeOnConfirm: true
                }, function() {
                    myChips.rank[rankId] = 0;
                    _self.updPoints(myChips.rankPoints[rankId]);
                    _self.rankSprite[sprite.rankId].visible = false;
                    _self.selectRank(sprite);
                });
            } else {
                this.selectRank(sprite);
            }
        }
    },

    updPoints: function (p) {
        if (p != 0) {
            userpoints += p;
            this.pointsText.setText(userpoints);
        }
    },

    selectRank: function (sprite) {
        if (this.selectedRank) {
            this.rankButton[this.selectedRank - 1].loadTexture('rank', this.selectedRank + 2);
        }
        sprite.loadTexture('rank', sprite.rankId);
        this.selectedRank = sprite.rankId + 1;
    },

    addPoints: function (i, j) {
        if (userpoints < chip) {
            sweetAlert('您的积分不够');
            return;
        } else {
            this.betPoints.setText(+this.betPoints.text + chip);
        }
    },

    subPoints: function () {
        var myBet = +this.betPoints.text;
        if (myBet >= chip) {
            this.betPoints.setText(myBet - chip);
        } else if (myBet > 0) {
            this.betPoints.setText(0);
        }
    },

    startGame: function () {
        if (this.isPopup) {
            return;
        }

        var totalChips = 0;
        //  Ok, the Play Button has been clicked or touched, so let's stop the music (otherwise it'll carry on playing)
        // this.music.stop();
        for (i = 0; i < myChips.rank.length; i ++) {
            if (myChips.rank[i] > 0 && myChips.rankPoints[i] > 0) {
                this.ready = true;
                totalChips += myChips.rankPoints[i];
            } else if (myChips.rank[i] == 0 && myChips.rankPoints[i] > 0) {
                myChips.rankPoints[i] = 0;
            }
        }

        if (!this.ready) {
            sweetAlert('请先下注');
            return;
        } else {
            var _self = this;
            ajax({
                url: '/horserace/start',
                data: myChips,
                onSuccess: function(data) {
                    var resp = JSON.parse(data);
                    if (resp.code == 0) {
                        _self.state.start('Game', true, false, resp.data.rank);
                    } else {
                        _self.updPoints(totalChips);
                    }
                },
            });
        }
    }

};


BasicGame.Game = function (game) {
    this.ranklist;
    this.players = [];
    this.panel;
    this.runwayLength = 1080;
    this.runLength = 900;
    this.startX = 0;
    this.horsePadding = 10;
};

BasicGame.Game.prototype = {

    init: function (ranklist) {
        this.ranklist = ranklist;
    },

    create: function () {
        game.world.setBounds(0, 0, this.runwayLength, 540);
        game.add.tileSprite(
            0,
            0,
            game.world.width,
            game.height,
            'runway'
        );
        game.add.sprite(50 + this.startX, 108, 'runway-begin');
        game.add.sprite(this.startX + this.runLength + 130 - this.horsePadding, 108, 'runway-end');

        this.panel = game.add.group();
        this.panel.create(0, 0, 'panel');
        this.panel.fixedToCamera = true;
        this.panel.cameraOffset.x = 0;
        this.panel.cameraOffset.y = 0;

        var chipY = 5;
        if (myChips['rank'][0]) {
            game.add.text(80, chipY, myChips['rank'][0] + '号  下注积分：' + myChips['rankPoints'][0], { font: "20px Arial", fill: "#00CC00" }, this.panel);
        } else {
            game.add.text(150, chipY, '未下注', { font: "20px Arial", fill: "#FF0000" }, this.panel);
        }
        chipY += 30;
        if (myChips['rank'][1]) {
            game.add.text(80, chipY, myChips['rank'][1] + '号  下注积分：' + myChips['rankPoints'][1], { font: "20px Arial", fill: "#00CC00" }, this.panel);
        } else {
            game.add.text(150, chipY, '未下注', { font: "20px Arial", fill: "#FF0000" }, this.panel);
        }
        chipY += 30;
        if (myChips['rank'][2]) {
            game.add.text(80, chipY, myChips['rank'][2] + '号  下注积分：' + myChips['rankPoints'][2], { font: "20px Arial", fill: "#00CC00" }, this.panel);
        } else {
            game.add.text(150, chipY, '未下注', { font: "20px Arial", fill: "#FF0000" }, this.panel);
        }

        var y = 95;
        for (i = 0; i < horseNum; i++) {
            this.players[i] = game.add.sprite(this.startX, y + 53 * (this.ranklist[i] - 1), 'horse' + this.ranklist[i], 0);
        }
        this.runStart();
    },

    runStart: function () {
        var duration = this.rndDuration(7000, 12000);

        cameraMoveTime = duration[0];

        var pSectionDistance = this.runLength / 4;
        var ptween = [];
        tweenLimit = 4;
        for (i = 0; i < horseNum; i++) {
            section = this.rndSection(duration[i], this.runLength, tweenLimit);
            var ptemptween = game.add.tween(this.players[i]).to({ x: this.startX + pSectionDistance }, section[0], Phaser.Easing.Linear.None);
            for (tweenI = 1; tweenI < tweenLimit; tweenI++) {
                ptemptween.to({ x: this.startX + pSectionDistance * (tweenI + 1) }, section[tweenI], Phaser.Easing.Linear.None);
            }
            if (i == 7) {
                ptemptween.chain(game.add.tween(this.players[i]).to({ x: game.world.width }, 2000, Phaser.Easing.Linear.None));
                ptemptween.onComplete.add(function() {
                    game.time.events.add(1000, this.gameover, this);
                }, this);
                ptween[i] = ptemptween;
            } else {
                ptemptween.to({ x: game.world.width }, 2000, Phaser.Easing.Linear.None);
                ptween[i] = ptemptween;
            }
        }

        for (i = 0; i < horseNum; i++) {
            this.players[i].animations.add('run');
            this.players[i].animations.play('run', 12, true);
            ptween[i].start();
        }
        game.add.tween(game.camera).to({ x: 720 }, cameraMoveTime, Phaser.Easing.Linear.None, true);
    },

    gameover: function () {
        var graphics = game.add.graphics(0, 0);
        graphics.alpha = 0.7;
        graphics.beginFill(0x000000);
        graphics.drawRect(this.runwayLength - 360, 0, 360, 540);
        game.world.bringToTop(graphics);
        graphics.endFill();

        var endgroup = this.add.group();
        endgroup.create(this.runwayLength - 175, game.world.centerY, 'gameover').anchor.setTo(0.5);
        if (this.ranklist[1] == myChips.rank[1]) {
            endgroup.create(this.runwayLength - 330, game.world.centerY - 125, 'light');
        }
        if (this.ranklist[0] == myChips.rank[0]) {
            endgroup.create(this.runwayLength - 240, game.world.centerY - 160, 'light');
        }
        if (this.ranklist[2] == myChips.rank[2]) {
            endgroup.create(this.runwayLength - 160, game.world.centerY - 110, 'light');
        }
        endgroup.create(this.runwayLength - 300, game.world.centerY - 80, 'stand', this.ranklist[1] - 1);
        endgroup.create(this.runwayLength - 210, game.world.centerY - 110, 'stand', this.ranklist[0] - 1);
        endgroup.create(this.runwayLength - 130, game.world.centerY - 60, 'stand', this.ranklist[2] - 1);

        this.add.button(this.runwayLength - 245, game.world.centerY + 100, 'back', function(){this.state.start('MainMenu');}, this);
    },

    update: function () {
    },

    rndDuration: function (min, max) {
        var r = this.rnd.integerInRange(min, max);
        var array = [];
        for (var i = 0; i < horseNum; i++) {
            var flag = 0;
            do {
                for (var j = 0;j < array.length; j++) {
                    if (array[j] == r) {
                        flag = 1;
                        break;
                    }
                }
                if (!flag) {
                    array[array.length] = r;
                } else {
                    r = this.rnd.integerInRange(min, max);
                }
            } while (!flag);
        }
        array.sort(function(x,y){return x-y});
        return array;
    },

    rndSection: function(duration, distance, limit) {
        var t = duration / 4;
        var intT = parseInt(t);
        var minT = parseInt(t * 0.8);
        var maxT = parseInt(t * 1.2);
        var tArray = [];
        var avg = distance / duration;

        for (k = 0; k < limit; k++) {
            if (k == limit - 1) {
                tArray[tArray.length] = duration - eval(tArray.join('+'));
            } else if (k == 3) {
                var sum = eval(tArray.join('+'));
                if (sum / tArray.length > avg) {
                    tArray[tArray.length] = this.rnd.integerInRange(minT, intT);
                } else if (sum / tArray.length < avg) {
                    tArray[tArray.length] = this.rnd.integerInRange(intT, maxT);
                } else {
                    tArray[tArray.length] = this.rnd.integerInRange(minT, maxT);
                }
            } else {
                tArray[tArray.length] = this.rnd.integerInRange(minT, maxT);
            }
        }
        return tArray;
    },

};

game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('MainMenu',BasicGame.MainMenu);
game.state.add('Game', BasicGame.Game);

game.state.start('Boot');
