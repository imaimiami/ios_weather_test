ios_weather_test
================

[WEB+DB PRESS Vol.79](http://www.amazon.co.jp/WEB-DB-PRESS-Vol-79-%E6%88%90%E7%80%AC/dp/4774162876/ref=sr_1_3?ie=UTF8&qid=1394374576&sr=8-3&keywords=db+web)の特集2をやってみました。

Yahoo APIのKeyとか持ってなかったんで、[livedoor 天気情報](http://weather.livedoor.com/weather_hacks/webservicev)を使用して東京の天気を表示してます。

### つまったとこ

`cellForRowAtIndexPath`の中で上手くcellがとれなくて`if(cell==nil)`とかやってたんだけど、きちんとTableViewCellにIdentifer指定したらとれるようになった。

```
static NSString *CellIdentifier = @"Cell";
UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
if (cell==nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
}
```

![question_xcodeproj__main_storyboard](https://f.cloud.github.com/assets/2256037/2368131/ad18660a-a797-11e3-964f-3d4f4186cc53.png)
