import emitter from '@ohos:events.emitter';
import Animator from '@ohos:animator';
import AVPlayerClass from '@bundle:com.example.myapplication/entry/ets/untils/AVPlayerClass';
class PlayStateTypeModel {
    constructor(model) {
        this.img = '';
        this.name = '';
        this.author = '';
        this.url = '';
        this.playIndex = 0;
        this.time = 0;
        this.duration = 0;
        this.isPlay = false;
        this.playMode = 'auto';
        this.playList = [];
        this.img = model.img;
        this.name = model.name;
        this.author = model.author;
        this.url = model.url;
        this.playIndex = model.playIndex;
        this.time = model.time;
        this.duration = model.duration;
        this.isPlay = model.isPlay;
        this.playMode = model.playMode;
        this.playList = model.playList;
    }
}
class Play extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__randomColor = new ObservedPropertySimplePU('rgb(0,0,0)', this, "randomColor");
        this.__randomNum = new ObservedPropertySimplePU(50, this, "randomNum");
        this.__shakenX = new ObservedPropertySimplePU(0, this, "shakenX");
        this.__shakenY = new ObservedPropertySimplePU(0, this, "shakenY");
        this.__panelHeight = new ObservedPropertySimplePU('0%'
        // 动画配置参数
        , this, "panelHeight");
        this.animationOption = {
            duration: 20 * 1000,
            easing: 'linear',
            delay: 0,
            fill: 'none',
            direction: 'normal',
            iterations: -1,
            begin: 0,
            end: 360
        };
        this.animator = null;
        this.__rotateAngle = new ObservedPropertySimplePU(0, this, "rotateAngle");
        this.__playState = new ObservedPropertyObjectPU(new PlayStateTypeModel({}), this, "playState");
        this.songs = [
            {
                img: 'http://p1.music.126.net/CfTiq9PTU7wNBKc_xRQFKA==/109951167835107568.jpg?param=130y130',
                name: '小宇',
                author: '周俐言',
                url: 'https://music.163.com/song/media/outer/url?id=1404597072.mp3',
                id: '0000'
            },
            {
                img: 'http://p2.music.126.net/STWQpRLgUBOcXQIDPoEL_A==/109951163533011733.jpg?param=130y130',
                name: '蒲公英的约定',
                author: '周杰伦',
                url: 'http://waletools.tech:8080/music/zjl.mp3',
                id: '0001'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
                name: 'Sweet Dreams',
                author: 'TPaul Sax / Eurythmics',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3',
                id: '0002'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg',
                name: '奢香夫人',
                author: '凤凰传奇',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a',
                id: '0003'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg',
                name: '空心',
                author: '光泽',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.mp3',
                id: '0004'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg',
                name: '反转地球',
                author: '潘玮柏',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3',
                id: '0005'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg',
                name: 'No.9',
                author: 'T-ara',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.m4a',
                id: '0006'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg',
                name: '孤独',
                author: 'G.E.M.邓紫棋',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.m4a',
                id: '0007'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg',
                name: 'Lose Control',
                author: 'Hedley',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.m4a',
                id: '0008'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg',
                name: '倩女幽魂',
                author: '张国荣',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.m4a',
                id: '0009'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg',
                name: '北京北京',
                author: '汪峰',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.m4a',
                id: '0010'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg',
                name: '苦笑',
                author: '汪苏泷',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.mp3',
                id: '0011'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg',
                name: '一生所爱',
                author: '卢冠廷 / 莫文蔚',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a',
                id: '0012'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg',
                name: '月半小夜曲',
                author: '李克勤',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.mp3',
                id: '0013'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg',
                name: 'Rolling in the Deep',
                author: 'Adele',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.m4a',
                id: '0014'
            },
            {
                img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg',
                name: '海阔天空',
                author: 'Beyond',
                url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.m4a',
                id: '0015'
            }
        ];
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.randomColor !== undefined) {
            this.randomColor = params.randomColor;
        }
        if (params.randomNum !== undefined) {
            this.randomNum = params.randomNum;
        }
        if (params.shakenX !== undefined) {
            this.shakenX = params.shakenX;
        }
        if (params.shakenY !== undefined) {
            this.shakenY = params.shakenY;
        }
        if (params.panelHeight !== undefined) {
            this.panelHeight = params.panelHeight;
        }
        if (params.animationOption !== undefined) {
            this.animationOption = params.animationOption;
        }
        if (params.animator !== undefined) {
            this.animator = params.animator;
        }
        if (params.rotateAngle !== undefined) {
            this.rotateAngle = params.rotateAngle;
        }
        if (params.playState !== undefined) {
            this.playState = params.playState;
        }
        if (params.songs !== undefined) {
            this.songs = params.songs;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__randomColor.purgeDependencyOnElmtId(rmElmtId);
        this.__randomNum.purgeDependencyOnElmtId(rmElmtId);
        this.__shakenX.purgeDependencyOnElmtId(rmElmtId);
        this.__shakenY.purgeDependencyOnElmtId(rmElmtId);
        this.__panelHeight.purgeDependencyOnElmtId(rmElmtId);
        this.__rotateAngle.purgeDependencyOnElmtId(rmElmtId);
        this.__playState.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__randomColor.aboutToBeDeleted();
        this.__randomNum.aboutToBeDeleted();
        this.__shakenX.aboutToBeDeleted();
        this.__shakenY.aboutToBeDeleted();
        this.__panelHeight.aboutToBeDeleted();
        this.__rotateAngle.aboutToBeDeleted();
        this.__playState.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get randomColor() {
        return this.__randomColor.get();
    }
    set randomColor(newValue) {
        this.__randomColor.set(newValue);
    }
    get randomNum() {
        return this.__randomNum.get();
    }
    set randomNum(newValue) {
        this.__randomNum.set(newValue);
    }
    get shakenX() {
        return this.__shakenX.get();
    }
    set shakenX(newValue) {
        this.__shakenX.set(newValue);
    }
    get shakenY() {
        return this.__shakenY.get();
    }
    set shakenY(newValue) {
        this.__shakenY.set(newValue);
    }
    get panelHeight() {
        return this.__panelHeight.get();
    }
    set panelHeight(newValue) {
        this.__panelHeight.set(newValue);
    }
    get rotateAngle() {
        return this.__rotateAngle.get();
    }
    set rotateAngle(newValue) {
        this.__rotateAngle.set(newValue);
    }
    get playState() {
        return this.__playState.get();
    }
    set playState(newValue) {
        this.__playState.set(newValue);
    }
    aboutToAppear() {
        // const index = router.getParams()['index']
        // this.playSong = this.songs[index]
        emitter.on({
            eventId: 0
        }, (data) => {
            // console.log('logData', JSON.stringify(data.data))
            this.playState = new PlayStateTypeModel(JSON.parse(data.data.data));
            //   生成颜色随机数
            this.randomColor = 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')';
            this.shakenX = 2 - Math.random() * 4;
            this.shakenY = 2 - Math.random() * 4;
            if (this.playState.isPlay) {
                this.animator.play();
            }
            else {
                this.animator.pause();
                this.randomColor = 'rgb(0, 0, 0)';
                this.shakenX = 0;
                this.shakenY = 0;
            }
        });
        this.animator = Animator.create(this.animationOption);
        this.animator.onframe = (val) => {
            this.rotateAngle = val;
        };
    }
    number2time(number) {
        const ms = number % 1000;
        const second = (number - ms) / 1000;
        const s = second % 60;
        if (second > 60) {
            const m = (second - s) / 60 % 60;
            return m.toString()
                .padStart(2, '0') + ':' + s.toString()
                .padStart(2, '0');
        }
        return '00:' + s.toString()
            .padStart(2, '0');
    }
    // 当前播放的歌曲
    // @State
    // playSong:songItemType = this.songs[0]
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Stack.create();
            Stack.width('100%');
            Stack.height('100%');
            Stack.backgroundColor(Color.Transparent);
            if (!isInitialRender) {
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Stack.create({ alignContent: Alignment.Bottom });
            Stack.backgroundColor(Color.Transparent);
            if (!isInitialRender) {
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 变色背景
            Image.create(this.playState.img);
            // 变色背景
            Image.width('100%');
            // 变色背景
            Image.height('100%');
            // 变色背景
            Image.blur(1000);
            if (!isInitialRender) {
                // 变色背景
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 内容
            Column.create();
            // 内容
            Column.onClick(() => {
                this.panelHeight = '0%';
            });
            if (!isInitialRender) {
                // 内容
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //  播放界面
            Column.create();
            //  播放界面
            Column.layoutWeight(1);
            //  播放界面
            Column.width('100%');
            if (!isInitialRender) {
                //  播放界面
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            //   图片
            Stack.create({ alignContent: Alignment.Top });
            if (!isInitialRender) {
                //   图片
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.margin({
                top: 50
            });
            Row.width('90%');
            Row.aspectRatio(1);
            Row.justifyContent(FlexAlign.Center);
            Row.padding(24);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.rotate({
                angle: this.rotateAngle
            });
            Row.shadow({
                radius: this.randomNum,
                color: this.randomColor
            });
            Row.backgroundImage({ "id": 16777236, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Row.backgroundImageSize(ImageSize.Cover);
            Row.justifyContent(FlexAlign.Center);
            Row.width('100%');
            Row.borderRadius(400);
            Row.clip(true);
            Row.aspectRatio(1);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(this.playState.img);
            Image.width('70%');
            Image.borderRadius(400);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 唱针
            Image.create({ "id": 16777259, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Context.animation({
                duration: 500
            });
            // 唱针
            Image.width(200);
            // 唱针
            Image.aspectRatio(1);
            // 唱针
            Image.rotate({
                angle: this.playState.isPlay ? -45 : -55,
                centerX: 100,
                centerY: 30
            });
            Context.animation(null);
            if (!isInitialRender) {
                // 唱针
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        //   图片
        Stack.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 歌曲信息
            Stack.create();
            // 歌曲信息
            Stack.layoutWeight(1);
            if (!isInitialRender) {
                // 歌曲信息
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 第一个
            Column.create({ space: 8 });
            // 第一个
            Column.translate({
                x: this.shakenX,
                y: this.shakenY
            });
            // 第一个
            Column.layoutWeight(1);
            // 第一个
            Column.justifyContent(FlexAlign.Center);
            // 第一个
            Column.zIndex(1);
            if (!isInitialRender) {
                // 第一个
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.name);
            Text.fontSize(28);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#4bb0c4');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.author);
            Text.fontSize(18);
            Text.fontColor('#4bb0c4');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 第一个
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 第二个
            Column.create({ space: 8 });
            // 第二个
            Column.layoutWeight(1);
            // 第二个
            Column.justifyContent(FlexAlign.Center);
            // 第二个
            Column.zIndex(2);
            if (!isInitialRender) {
                // 第二个
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.name);
            Text.fontSize(28);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#ec5c87');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.author);
            Text.fontSize(18);
            Text.fontColor('#ec5c87');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 第二个
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 第三个
            Column.create({ space: 8 });
            // 第三个
            Column.layoutWeight(1);
            // 第三个
            Column.justifyContent(FlexAlign.Center);
            // 第三个
            Column.zIndex(3);
            // 第三个
            Column.translate({
                x: this.shakenY,
                y: this.shakenX
            });
            if (!isInitialRender) {
                // 第三个
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.name);
            Text.fontSize(28);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor(Color.White);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.playState.author);
            Text.fontSize(18);
            Text.fontColor(Color.White);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 第三个
        Column.pop();
        // 歌曲信息
        Stack.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 操作
            Row.create();
            // 操作
            Row.width('100%');
            // 操作
            Row.justifyContent(FlexAlign.SpaceAround);
            if (!isInitialRender) {
                // 操作
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Badge.create({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } });
            if (!isInitialRender) {
                Badge.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777245, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.fillColor(Color.White);
            Image.width(24);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Badge.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Badge.create({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc' } });
            if (!isInitialRender) {
                Badge.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777241, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.fillColor(Color.White);
            Image.width(18);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Badge.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Badge.create({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131' } });
            if (!isInitialRender) {
                Badge.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777234, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.fillColor(Color.White);
            Image.width(24);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Badge.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Badge.create({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371' } });
            if (!isInitialRender) {
                Badge.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777242, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.fillColor(Color.White);
            Image.width(24);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Badge.pop();
        // 操作
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 播放
            Column.create();
            // 播放
            Column.width('100%');
            if (!isInitialRender) {
                // 播放
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 进度条
            Row.create({ space: 4 });
            // 进度条
            Row.width('100%');
            // 进度条
            Row.padding(24);
            if (!isInitialRender) {
                // 进度条
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.number2time(this.playState.time));
            Text.fontSize(12);
            Text.fontColor(Color.White);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 滑块
            Slider.create({
                value: this.playState.time,
                min: 0,
                max: this.playState.duration
            });
            // 滑块
            Slider.onChange((value) => {
                AVPlayerClass.player.seek(value);
            });
            // 滑块
            Slider.layoutWeight(1);
            // 滑块
            Slider.blockColor(Color.White);
            // 滑块
            Slider.selectedColor(Color.White);
            // 滑块
            Slider.trackColor('#ccc5c5c5');
            // 滑块
            Slider.trackThickness(2);
            if (!isInitialRender) {
                // 滑块
                Slider.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.number2time(this.playState.duration));
            Text.fontSize(12);
            Text.fontColor(Color.White);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        // 进度条
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 切换
            Row.create();
            // 切换
            Row.width('100%');
            // 切换
            Row.padding({
                bottom: 24
            });
            // 切换
            Row.justifyContent(FlexAlign.SpaceAround);
            if (!isInitialRender) {
                // 切换
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            // Image($r('app.media.ic_auto'))
            //   .fillColor(Color.White)
            //   .width(30)
            if (this.playState.playMode === 'auto') {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Image.create({ "id": 16777224, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
                        Image.fillColor(Color.White);
                        Image.width(30);
                        Image.onClick(() => {
                            AVPlayerClass.changeMode('repeat');
                        });
                        if (!isInitialRender) {
                            Image.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            else if (this.playState.playMode === 'repeat') {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Image.create({ "id": 16777266, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
                        Image.fillColor(Color.White);
                        Image.width(30);
                        Image.onClick(() => {
                            AVPlayerClass.changeMode('random');
                        });
                        if (!isInitialRender) {
                            Image.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            else if (this.playState.playMode === 'random') {
                this.ifElseBranchUpdateFunction(2, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Image.create({ "id": 16777253, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
                        Image.fillColor(Color.White);
                        Image.width(30);
                        Image.onClick(() => {
                            AVPlayerClass.changeMode('auto');
                        });
                        if (!isInitialRender) {
                            Image.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 上一首
            Image.create({ "id": 16777252, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            // 上一首
            Image.fillColor(Color.White);
            // 上一首
            Image.width(30);
            // 上一首
            Image.onClick(() => {
                AVPlayerClass.prev();
            });
            if (!isInitialRender) {
                // 上一首
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 播放按钮
            Image.create(this.playState.isPlay ? { "id": 16777275, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" } : { "id": 16777251, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            // 播放按钮
            Image.onClick(() => {
                if (this.playState.isPlay) {
                    AVPlayerClass.pause();
                }
                else {
                    AVPlayerClass.singlePlay(this.playState.playList[this.playState.playIndex]);
                }
            });
            // 播放按钮
            Image.fillColor(Color.White);
            // 播放按钮
            Image.width(50);
            if (!isInitialRender) {
                // 播放按钮
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 下一首
            Image.create({ "id": 16777249, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            // 下一首
            Image.fillColor(Color.White);
            // 下一首
            Image.width(30);
            // 下一首
            Image.onClick(() => {
                AVPlayerClass.next();
            });
            if (!isInitialRender) {
                // 下一首
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 播放列表
            Image.create({ "id": 16777258, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            // 播放列表
            Image.fillColor(Color.White);
            // 播放列表
            Image.width(30);
            // 播放列表
            Image.onClick(() => {
                this.panelHeight = '50%';
            });
            if (!isInitialRender) {
                // 播放列表
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // 切换
        Row.pop();
        // 播放
        Column.pop();
        //  播放界面
        Column.pop();
        // 内容
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 列表
            Column.create();
            Context.animation({
                duration: 300
            });
            // 列表
            Column.height(this.panelHeight);
            Context.animation(null);
            if (!isInitialRender) {
                // 列表
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.layoutWeight(1);
            Column.onClick(() => {
                this.panelHeight = '0%';
            });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.padding(20);
            Column.backgroundColor('rgb(53, 51, 52)');
            Column.width('100%');
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create({ space: 10 });
            Row.width('100%');
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create({ "id": 16777251, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.width(20);
            Image.aspectRatio(1);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create('播放列表');
            Text.fontColor('white');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            var _a;
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(`(${(_a = this.playState.playList) === null || _a === void 0 ? void 0 : _a.length})`);
            Text.fontColor('white');
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 列表
            List.create();
            if (!isInitialRender) {
                // 列表
                List.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = (_item, index) => {
                const item = _item;
                {
                    const isLazyCreate = true;
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ListItem.create(deepRenderFunction, isLazyCreate);
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const observedShallowRender = () => {
                        this.observeComponentCreation(itemCreation);
                        ListItem.pop();
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation(itemCreation);
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Row.create({ space: 10 });
                            Row.width('100%');
                            Row.height(60);
                            if (!isInitialRender) {
                                Row.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(String(index + 1));
                            Text.fontColor('rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Column.create();
                            Column.onClick(() => {
                                AVPlayerClass.singlePlay(item);
                            });
                            Column.alignItems(HorizontalAlign.Start);
                            Column.layoutWeight(1);
                            if (!isInitialRender) {
                                Column.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(item.name);
                            Text.fontColor(this.playState.playIndex === index ? 'rgb(254, 81, 134)' : 'rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(item.author);
                            Text.fontColor(this.playState.playIndex === index ? 'rgb(254, 81, 134)' : 'rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        Column.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Image.create({ "id": 16777248, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
                            Image.width(20);
                            Image.fillColor('rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Image.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Row.pop();
                        ListItem.pop();
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.updateFuncByElmtId.set(elmtId, itemCreation);
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Row.create({ space: 10 });
                            Row.width('100%');
                            Row.height(60);
                            if (!isInitialRender) {
                                Row.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(String(index + 1));
                            Text.fontColor('rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Column.create();
                            Column.onClick(() => {
                                AVPlayerClass.singlePlay(item);
                            });
                            Column.alignItems(HorizontalAlign.Start);
                            Column.layoutWeight(1);
                            if (!isInitialRender) {
                                Column.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(item.name);
                            Text.fontColor(this.playState.playIndex === index ? 'rgb(254, 81, 134)' : 'rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Text.create(item.author);
                            Text.fontColor(this.playState.playIndex === index ? 'rgb(254, 81, 134)' : 'rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Text.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Text.pop();
                        Column.pop();
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            Image.create({ "id": 16777248, "type": 20000, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
                            Image.width(20);
                            Image.fillColor('rgb(99, 97, 98)');
                            if (!isInitialRender) {
                                Image.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        Row.pop();
                        ListItem.pop();
                    };
                    if (isLazyCreate) {
                        observedShallowRender();
                    }
                    else {
                        observedDeepRender();
                    }
                }
            };
            this.forEachUpdateFunction(elmtId, this.playState.playList, forEachItemGenFunction, undefined, true, false);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        // 列表
        List.pop();
        Column.pop();
        // 列表
        Column.pop();
        Stack.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new Play(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=Play.js.map