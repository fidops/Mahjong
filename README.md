# Mahjong

Monorepo for fidops/houou and fidops/yakuman .

## setup

```sh
# taskctl をタスクランナーとして使用する
$ ./setup

# subtree 参照先の追加 / .env 生成 / docker compose build / DB
$ bin/taskctl setup
```

## usage

```sh
# 開発環境の立ち上げ
$ docker compose up -d

# 終了
$ docker compose down
```

- Backend : [houou/README.md](houou/README.md)
- Frontend : [yakuman/README.md](yakuman/README.md)
