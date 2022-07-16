# Yakuman

Show me your YAKUMAN.

## Build Setup

- Node v16.15.1 (*Stable* LTS)
- Nuxt.js 2.x
- TypeScript
- Vue.js 2.x

```bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```

## Contribute

`pages/` 配下に `path/to/file.vue` を生成すると自動的に `baseURL/path/to/file` へルーティングの組まれるページを作成できる。
`directory/index.vue` の場合は `baseURL/directory` へルーティングが設定される。

詳細 : [Nuxt - ページディレクトリ](https://nuxtjs.org/ja/docs/directory-structure/pages)
