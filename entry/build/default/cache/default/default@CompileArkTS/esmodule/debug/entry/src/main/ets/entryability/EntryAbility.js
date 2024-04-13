import UIAbility from '@ohos:app.ability.UIAbility';
import AVPlayerClass from '@bundle:com.example.myapplication/entry/ets/untils/AVPlayerClass';
export default class EntryAbility extends UIAbility {
    onCreate(want, launchParam) {
    }
    onDestroy() {
    }
    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        // AVPlayerClass.context = this.context
        AVPlayerClass.init();
        windowStage.loadContent('pages/Start');
    }
    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
    }
    onForeground() {
        // Ability has brought to foreground
    }
    onBackground() {
        // Ability has back to background
    }
}
//# sourceMappingURL=EntryAbility.js.map