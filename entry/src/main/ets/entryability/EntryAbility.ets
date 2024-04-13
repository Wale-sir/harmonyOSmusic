import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import AVPlayerClass from '../untils/AVPlayerClass';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
  }

  onDestroy() {
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    // AVPlayerClass.context = this.context
    AVPlayerClass.init()
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