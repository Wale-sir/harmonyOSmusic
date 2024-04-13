export class songItemTypeModel {
    constructor(model) {
        this.img = '';
        this.name = '';
        this.author = '';
        this.url = '';
        this.id = '';
        this.img = model.img;
        this.name = model.name;
        this.author = model.author;
        this.url = model.url;
        this.id = model.id;
    }
}
export class recommendListTypeModel {
    constructor(model) {
        this.img = '';
        this.title = '';
        this.count = '';
        this.img = model.img;
        this.title = model.title;
        this.count = model.count;
    }
}
export class recommendDailyTypeModel {
    constructor(model) {
        this.img = '';
        this.title = '';
        this.type = '';
        this.top = '';
        this.bottom = '';
        this.img = model.img;
        this.title = model.title;
        this.type = model.type;
        this.top = model.top;
        this.bottom = model.bottom;
    }
}
export class favoriteListTypeModel {
    constructor(model) {
        this.name = '';
        this.nickName = '';
        this.avatar = '';
        this.songs = [];
        this.name = model.name;
        this.nickName = model.nickName;
        this.avatar = model.avatar;
        this.songs = model.songs;
    }
}
export class momentListTypeModel {
    constructor(model) {
        this.author = '';
        this.avatar = '';
        this.content = '';
        this.comment = 0;
        this.like = 0;
        this.song = new songItemTypeModel({});
        this.author = model.author;
        this.avatar = model.avatar;
        this.content = model.content;
        this.comment = model.comment;
        this.like = model.like;
        this.song = model.song;
    }
}
export class TabClass {
    constructor() {
        this.title = '';
        this.name = '';
    }
}
//# sourceMappingURL=music.js.map