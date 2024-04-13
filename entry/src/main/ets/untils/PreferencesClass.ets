import preferences from '@ohos.data.preferences'
import { defaultState, PlayStateType } from '../models/playState'

export class PreferencesClass {
  StoreName: string = 'HEIMA_CLOUD_MUSIC'
  PlayStateKey: string = 'HMIMA_PLAY_KEY'
  context: Context

  constructor(context: Context) {
    this.context = context
  }

  //获取store
  async getStore() {
    return await preferences.getPreferences(this.context, this.StoreName)
  }
  //存储播放状态
  async setPlayState(playState: PlayStateType) {
    const store = await this.getStore()
    await store.put(this.PlayStateKey, JSON.stringify(playState))
    await store.flush()
  }
  //获取存储的播放状态
  async getPlayState(): Promise<PlayStateType> {
    const store = await this.getStore()
    return JSON.parse(await store.get(this.PlayStateKey, JSON.stringify(defaultState)) as string) as PlayStateType
  }
}