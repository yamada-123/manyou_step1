# テーブル管理

Taskテーブル
| title | content |
| --- | --- |
|string | text |


# herokuにデプロイする方法
## 1 herokuのアプリケーションを作成する　
```
$ heroku create
```
## 2 herokuにデプロイする
```
$ git push heroku master
```

## 3 データベース移行
```
$ run rails  db:migrate
```

## 4 アプリケーションを開く
```
$ heroku open
```
