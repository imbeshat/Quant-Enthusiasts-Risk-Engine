import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
      "@/components": path.resolve(__dirname, "./src/components"),
      "@/services": path.resolve(__dirname, "./src/services"),
      "@/types": path.resolve(__dirname, "./src/types"),
      "@/utils": path.resolve(__dirname, "./src/utils"),
      "@/hooks": path.resolve(__dirname, "./src/hooks"),
      "@/config": path.resolve(__dirname, "./src/config"),
    },
  },
  server: {
    port: 3000,
    host: true,
    open: false,
    proxy: {
      '/api': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/health': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/calculate_risk': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/price_option': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/update_market_data': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/get_cached_market_data': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/clear_market_data_cache': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      },
      '/portfolio': {
        target: 'http://localhost:5000',
        changeOrigin: true,
      }
    }
  },
  build: {
    outDir: 'dist',
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: undefined
      }
    }
  }
});