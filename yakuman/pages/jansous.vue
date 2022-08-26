<template>
    <v-container>
        <h1>雀荘一覧</h1>
        <v-spacer></v-spacer>
        <v-breadcrumbs :items="items" large></v-breadcrumbs>
        <v-spacer></v-spacer>
        <v-data-table
            item-key="id"
            :headers="headers"
            :items="jansous"
            :items-per-page="10"
            :loading="loading"
            loading-text="よみこみちゅう..."
        ></v-data-table>
    </v-container>
</template>

<script lang="ts">
import Vue from 'vue'
import { Jansou } from '~/types/IJansou'

export default Vue.extend({
    name: 'MahjongMatch',
    data: () => ({
        items: [
            { text: 'Top', disabled: false, href: '/' },
            { text: '雀荘一覧', disabled: true, href: '/jansous' },
        ],
        jansous: [] as Jansou[],
        headers: [
            { text: '名前', value: 'name' },
            { text: '住所', value: 'address' },
            { text: 'GoogleMap', value: 'google_map_url' },
        ],
        loading: true,
    }),
    async fetch() {
        try {
            this.jansous = await this.$axios.$get('/jansous')
        } catch (_err: any) {
            return
        }

        this.loading = false
    },
})
</script>
