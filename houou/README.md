# Houou

Show me your passion.

## Build setup

- Ruby 3.1.2
- Bundler 2.3.7
- Rails 7.0.3
- Docker
- gcc make

```bash
# Set .env, install dependencies and up/create/migrate db
$ make setup

# rails server + postgres
# ctrl-c で rails server 終了
$ make up

# stop/rm postgres container
$ make down
```

## Endpoints

:construction: WIP :construction:

## Contribute

ルーティングとそれに対するアクションの定義に関する変更はここ:

```
config
└── routes.rb

app/controllers
├── api
│   └── v1
│       ├── administrator_sessions_controller.rb
│       ├── administrators_controller.rb
│       ├── mahjong_games_controller.rb
│       ├── mahjong_jansous_controller.rb
│       ├── mahjong_matches_controller.rb
│       └── members_controller.rb
└── application_controller.rb
```

JSON 形式でのレスポンスの表現に関する変更はここ:

```
app/views/api/v1/
├── administrators
├── mahjong_games
├── mahjong_jansous
├── mahjong_matches
└── members
```

DBの実データとRubyでの表現を司る O/R マッパーに関する変更はここ:

```
app/models
├── administrator.rb
├── application_record.rb
├── concerns
├── mahjong_game.rb
├── mahjong_jansou.rb
├── mahjong_match.rb
└── member.rb
```
