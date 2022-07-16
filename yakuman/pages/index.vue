<template>
    <main>
        <a-page-header
            title="Yakuman"
            :breadcrumb="{
                props: { routes: [{ path: '/', breadcrumbName: 'Home' }] },
            }"
        />
    </main>
</template>

<script lang="ts">
import Vue from 'vue'

export default Vue.extend({
    name: 'IndexPage',
})
</script>
