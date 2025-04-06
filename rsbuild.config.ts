import { defineConfig } from '@rsbuild/core';

export default defineConfig({
  html: {
    template: 'src/index.html',
    title: 'Ranking Odpowiedzialności Społecznej',
  },
  server: {
    publicDir: {
      name: 'public',
    },
  },
  security: {
    nonce: 'CSP_NONCE_PLACEHOLDER',
  },
});
