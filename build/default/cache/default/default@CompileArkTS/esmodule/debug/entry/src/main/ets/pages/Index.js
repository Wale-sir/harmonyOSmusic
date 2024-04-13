import { tabsData } from '@bundle:com.example.myapplication/entry/ets/constants/musicsj';
import Find from '@bundle:com.example.myapplication/entry/ets/pages/Find';
import Mine from '@bundle:com.example.myapplication/entry/ets/pages/Mine';
import Moment from '@bundle:com.example.myapplication/entry/ets/pages/Moment';
import Recommend from '@bundle:com.example.myapplication/entry/ets/pages/Recommend';
import SongList from '@bundle:com.example.myapplication/entry/ets/pages/SongList';
class HomeIndex extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__currentName = new ObservedPropertySimplePU('recommend', this, "currentName");
        this.__opacityNum = new ObservedPropertySimplePU(1
        // tabBar组件
        , this, "opacityNum");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.currentName !== undefined) {
            this.currentName = params.currentName;
        }
        if (params.opacityNum !== undefined) {
            this.opacityNum = params.opacityNum;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentName.purgeDependencyOnElmtId(rmElmtId);
        this.__opacityNum.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentName.aboutToBeDeleted();
        this.__opacityNum.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get currentName() {
        return this.__currentName.get();
    }
    set currentName(newValue) {
        this.__currentName.set(newValue);
    }
    get opacityNum() {
        return this.__opacityNum.get();
    }
    set opacityNum(newValue) {
        this.__opacityNum.set(newValue);
    }
    // tabBar组件
    getTabBar(item, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width('100%');
            Column.alignItems(HorizontalAlign.Center);
            Column.justifyContent(FlexAlign.SpaceBetween);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(22);
            Row.aspectRatio(1);
            Row.borderRadius(22);
            Row.backgroundColor(item.name === this.currentName ? { "id": 16777222, "type": 10001, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" } : Color.Transparent);
            Row.justifyContent(FlexAlign.Center);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Image.create(item.icon);
            Image.fillColor(item.name === this.currentName ? Color.White : { "id": 16777221, "type": 10001, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            Image.width(item.name === this.currentName ? 18 : 22);
            Image.aspectRatio(1);
            if (!isInitialRender) {
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(item.title);
            Text.fontSize(12);
            Text.fontWeight(400);
            Text.margin({ top: 5 });
            Text.fontColor(item.name === this.currentName ? { "id": 16777222, "type": 10001, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" } : { "id": 16777221, "type": 10001, params: [], "bundleName": "com.example.myapplication", "moduleName": "entry" });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
    }
    // // 订阅事件
    // @State
    // playState: PlayStateType = new PlayStateTypeModel({} as PlayStateType)
    //
    // aboutToAppear() {
    //   emitter.on({ eventId: EmitEvenType.UPDATE_STATE }, (data) => {
    //     this.playState = new PlayStateTypeModel(JSON.parse(data.data.playStateStr))
    //   })
    // }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Stack.create();
            Stack.width('100%');
            Stack.height('100%');
            Stack.backgroundColor('#3c3f41');
            Stack.opacity(this.opacityNum);
            if (!isInitialRender) {
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Stack.create({ alignContent: Alignment.Bottom });
            if (!isInitialRender) {
                Stack.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Tabs.create({ barPosition: BarPosition.End });
            Tabs.barHeight(60);
            Tabs.onChange(index => {
                this.currentName = tabsData[index].name;
            });
            if (!isInitialRender) {
                Tabs.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    TabContent.create(() => {
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            If.create();
                            if (item.name === 'recommend') {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    {
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            if (isInitialRender) {
                                                ViewPU.create(new Recommend(this, {}, undefined, elmtId));
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                    }
                                });
                            }
                            else if (item.name === 'find') {
                                this.ifElseBranchUpdateFunction(1, () => {
                                    {
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            if (isInitialRender) {
                                                ViewPU.create(new Find(this, {}, undefined, elmtId));
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                    }
                                });
                            }
                            else if (item.name === 'moment') {
                                this.ifElseBranchUpdateFunction(2, () => {
                                    {
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            if (isInitialRender) {
                                                ViewPU.create(new Moment(this, {}, undefined, elmtId));
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                    }
                                });
                            }
                            else if (item.name === 'mine') {
                                this.ifElseBranchUpdateFunction(3, () => {
                                    {
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            if (isInitialRender) {
                                                ViewPU.create(new Mine(this, {}, undefined, elmtId));
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                    }
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(4, () => {
                                    {
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            if (isInitialRender) {
                                                ViewPU.create(new SongList(this, {}, undefined, elmtId));
                                            }
                                            else {
                                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                    }
                                });
                            }
                            if (!isInitialRender) {
                                If.pop();
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                        If.pop();
                    });
                    TabContent.tabBar({ builder: () => {
                            this.getTabBar.call(this, item);
                        } });
                    TabContent.backgroundColor('#121215');
                    if (!isInitialRender) {
                        TabContent.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                TabContent.pop();
            };
            this.forEachUpdateFunction(elmtId, tabsData, forEachItemGenFunction);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        Tabs.pop();
        Stack.pop();
        Stack.pop();
    }
    // 页面也换效果,避免滑动切换效果
    pageTransition() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            PageTransition.create();
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            PageTransitionEnter.create({ duration: 200 });
            PageTransitionEnter.onEnter(() => {
                this.opacityNum = 1;
            });
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            PageTransitionExit.create({ duration: 200 });
            PageTransitionExit.onExit(() => {
                this.opacityNum = 0;
            });
            ViewStackProcessor.StopGetAccessRecording();
        });
        PageTransition.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new HomeIndex(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=Index.js.map