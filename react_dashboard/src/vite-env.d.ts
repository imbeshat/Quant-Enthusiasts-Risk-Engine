interface ImportMetaEnv {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  MODE: any
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  PROD: any
  // Define the variables you are accessing from .env
  readonly VITE_API_BASE_URL: string
  readonly VITE_API_HEALTH_CHECK_INTERVAL: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}