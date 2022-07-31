<template>
    <v-app>
        <v-navigation-drawer app v-model="drawer">
            <v-list nav dense>
                <NuxtLink :to="link.path" v-for="link in links" :key="link.path" class="aside-link">
                    <v-list-item>
                        <v-list-item-icon>
                            <v-icon>{{ link.icon }}</v-icon>
                        </v-list-item-icon>
                            <v-list-item-title>{{ link.text }}</v-list-item-title>
                    </v-list-item>
                </NuxtLink>
            </v-list>
        </v-navigation-drawer>

        <v-app-bar app dense elevation="3">
            <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>Yakuman</v-toolbar-title>
        </v-app-bar>
        <v-main>
            <Nuxt />
        </v-main>
    </v-app>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
    name: 'DefaultLayout',
    data: () => ({
        drawer: true,
        links: [
            { path: '/members', text: '雀士一覧', icon: 'mdi-account-group' },
            { path: '/jansous', text: '雀荘一覧', icon: 'mdi-home-group' },
            { path: '/matches', text: '戦一覧', icon: 'mdi-axe-battle' },
            { path: '/games', text: '戦績一覧', icon: 'mdi-list-box' },
        ]
    }),
})
</script>

<style scoped>
.aside-link, .aside-link:visited {
    text-decoration: none;
    color: inherit;
}
</style>
