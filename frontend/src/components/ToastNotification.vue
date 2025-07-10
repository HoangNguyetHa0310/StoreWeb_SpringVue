<template>
  <div v-if="show" class="fixed top-5 right-5 z-50">
    <div :class="`flex items-center px-4 py-3 rounded shadow-lg text-white transition-all duration-300 ${typeClass}`">
      <span class="mr-2">
        <svg v-if="type==='success'" class="h-5 w-5 text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" /></svg>
        <svg v-else-if="type==='error'" class="h-5 w-5 text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
        <svg v-else class="h-5 w-5 text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" /><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3" /></svg>
      </span>
      <span>{{ message }}</span>
      <button @click="close" class="ml-4 text-white hover:text-gray-200">&times;</button>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
const props = defineProps({
  show: Boolean,
  message: String,
  type: { type: String, default: 'info' } // success, error, info
});
const emit = defineEmits(['close']);
const typeClass = computed(() => {
  if (props.type === 'success') return 'bg-green-600';
  if (props.type === 'error') return 'bg-red-600';
  return 'bg-blue-600';
});
function close() {
  emit('close');
}
</script>
