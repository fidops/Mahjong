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

:construction: wip :construction:

### Auth

```
   api_v1_auth_create POST   /api/v1/auth/create
  api_v1_auth_destroy DELETE /api/v1/auth/destroy
```

### Administrators

```
api_v1_administrators GET    /api/v1/administrators
                      POST   /api/v1/administrators
 api_v1_administrator GET    /api/v1/administrators/:id
                      PATCH  /api/v1/administrators/:id
                      PUT    /api/v1/administrators/:id
                      DELETE /api/v1/administrators/:id
```

### Jansous

```
       api_v1_jansous GET    /api/v1/jansous
                      POST   /api/v1/jansous
        api_v1_jansou GET    /api/v1/jansous/:id
                      PATCH  /api/v1/jansous/:id
                      PUT    /api/v1/jansous/:id
                      DELETE /api/v1/jansous/:id
```

### Games & Match with Games

```
         api_v1_games GET    /api/v1/games
          api_v1_game PATCH  /api/v1/games/:id
                      PUT    /api/v1/games/:id
                      DELETE /api/v1/games/:id
   api_v1_match_games GET    /api/v1/matches/:match_id/games
                      POST   /api/v1/matches/:match_id/games
```

### Matches

```
       api_v1_matches GET    /api/v1/matches
                      POST   /api/v1/matches
         api_v1_match GET    /api/v1/matches/:id
                      PATCH  /api/v1/matches/:id
                      PUT    /api/v1/matches/:id
                      DELETE /api/v1/matches/:id
```

### Members

```
       api_v1_members GET    /api/v1/members
                      POST   /api/v1/members
        api_v1_member GET    /api/v1/members/:id
                      PATCH  /api/v1/members/:id
                      PUT    /api/v1/members/:id
                      DELETE /api/v1/members/:id
```

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
