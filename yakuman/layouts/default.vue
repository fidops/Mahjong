<template>
    <a-layout>
        <a-layout-sider
            theme="dark"
            breakpoint="lg"
            collapsed-width="0"
            @breakpoint="onBreakpoint"
        >
            <a-menu theme="dark" mode="inline">
                <a-menu-item key="1">
                    <NuxtLink to="/members">
                        <a-icon type="user" />
                        <span>雀士一覧</span>
                    </NuxtLink>
                </a-menu-item>
                <a-menu-item key="2">
                    <NuxtLink to="/jansous">
                        <a-icon type="bank" />
                        <span>雀荘一覧</span>
                    </NuxtLink>
                </a-menu-item>
                <a-menu-item key="3">
                    <NuxtLink to="/matches">
                        <a-icon type="video-camera" />
                        <span>戦一覧</span>
                    </NuxtLink>
                </a-menu-item>
                <a-menu-item key="4">
                    <NuxtLink to="/games">
                        <a-icon type="line-chart" />
                        <span>戦績一覧</span>
                    </NuxtLink>
                </a-menu-item>
            </a-menu>
        </a-layout-sider>
        <a-layout :style="styles.layout">
            <a-layout-content :style="styles.layoutContent">
                <Nuxt />
            </a-layout-content>
        </a-layout>
    </a-layout>
</template>

<script lang="ts">
import Vue from 'vue'

const defaultStyles = {
    layout: {
        height: '100vh',
    },
    layoutContent: {
        overflow: 'auto',
        margin: '3em 2em',
        padding: '2em',
        background: '#fefefe',
    },
}

export default Vue.extend({
    name: 'DefaultLayout',
    data: () => ({
        styles: {
            ...defaultStyles,
        },
    }),
    methods: {
        onBreakpoint(isBroken: boolean) {
            if (isBroken) {
                this.styles.layoutContent = Object.assign(
                    {},
                    this.styles.layoutContent,
                    {
                        margin: '1em .5em',
                        padding: '1em',
                    }
                )
            } else {
                this.styles.layoutContent = Object.assign(
                    {},
                    this.styles.layoutContent,
                    defaultStyles.layoutContent
                )
            }
        },
    },
})
</script>
