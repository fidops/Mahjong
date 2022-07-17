<template>
    <main>
        <a-page-header title="戦" :breadcrumb="{ props: { routes } }"></a-page-header>
        <p>{{ match.name }}</p>
    </main>
</template>

<script lang="ts">
import Vue from 'vue'
import { Match } from '~/types/IMatch'
import { Jansou } from '~/types/IJansou'
import { Game } from '~/types/IGame'

export default Vue.extend({
    name: 'MahjongGameListOnMatch',
    data: () => ({
        routes: [
            { path: '', breadcrumbName: 'Home' },
            { path: '', breadcrumbName: 'Matches' },
            { path: '', breadcrumbName: 'Scores' },
        ],
        match: {} as Match,
        loading: true,
    }),
    async fetch() {
        try {
            this.match = await this.$axios.$get(`/matches/${this.$route.params.id}`)
        } catch (_err: any) {
            return
        }

        this.loading = false
    },
})
</script>
