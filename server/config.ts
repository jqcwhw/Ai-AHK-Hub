/**
 * Configuration utility that handles environment variables for both
 * Replit AI integrations and external deployments
 */

// Replit-specific environment variables (do NOT add to Vercel/external deployments)
const REPLIT_ONLY_VARS = [
  'AI_INTEGRATIONS_OPENAI_BASE_URL',
  'AI_INTEGRATIONS_OPENAI_API_KEY',
  'REPLIT_DEV_DOMAIN',
  'REPL_ID',
  'REPL_OWNER',
  'REPL_SLUG'
];

export const config = {
  // OpenAI Configuration
  openai: {
    // Prefer Replit AI integration, fallback to standard OpenAI env vars
    baseURL: process.env.AI_INTEGRATIONS_OPENAI_BASE_URL || undefined,
    apiKey: process.env.AI_INTEGRATIONS_OPENAI_API_KEY || 
            process.env.OPENAI_API_KEY || 
            process.env.OPENAI_API || 
            undefined
  },

  // GitHub Configuration
  github: {
    // Check multiple possible environment variable names
    token: process.env.GITHUB_TOKEN || 
           process.env.GITHUB_PERSONAL_ACCESS_TOKEN || 
           process.env.Github_Token || 
           undefined
  },

  // Database Configuration
  database: {
    url: process.env.DATABASE_URL
  },

  // Server Configuration
  server: {
    port: parseInt(process.env.PORT || '5000', 10),
    nodeEnv: process.env.NODE_ENV || 'development'
  },

  // Platform detection
  isReplit: !!process.env.REPL_ID
};

// Validation
export function validateConfig() {
  const warnings: string[] = [];
  
  if (!config.openai.apiKey) {
    warnings.push('⚠️  No OpenAI API key found. AI generation features will not work.');
    if (config.isReplit) {
      warnings.push('   Set one of: AI_INTEGRATIONS_OPENAI_API_KEY, OPENAI_API_KEY, or OPENAI_API');
    } else {
      warnings.push('   Set: OPENAI_API_KEY (do NOT use AI_INTEGRATIONS_* variables outside Replit)');
    }
  }
  
  if (!config.github.token) {
    warnings.push('⚠️  No GitHub token found. GitHub search will have lower rate limits (60 requests/hour).');
    warnings.push('   Set one of: GITHUB_TOKEN, GITHUB_PERSONAL_ACCESS_TOKEN, or Github_Token');
  }
  
  if (!config.database.url) {
    warnings.push('⚠️  No DATABASE_URL found. Database features will not work.');
  }
  
  return warnings;
}

// Get list of required environment variables for external deployments (Vercel, etc.)
export function getRequiredEnvVars() {
  return [
    'SESSION_SECRET',
    'DATABASE_URL',
    'OPENAI_API_KEY', // Use this, NOT AI_INTEGRATIONS_OPENAI_API_KEY
    'GITHUB_PERSONAL_ACCESS_TOKEN', // Optional but recommended
    'NODE_ENV' // Should be 'production'
  ];
}

// Get list of Replit-only environment variables (do NOT add to Vercel)
export function getReplitOnlyVars() {
  return REPLIT_ONLY_VARS;
}
