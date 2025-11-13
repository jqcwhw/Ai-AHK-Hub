# Vercel Deployment Guide

This guide will help you deploy the Milamoos AutoHotkey Macro Hub to Vercel.

## Prerequisites

- A [Vercel account](https://vercel.com/signup)
- A [Neon Database](https://neon.tech) (already configured)
- An [OpenAI API key](https://platform.openai.com/api-keys)
- (Optional) A [GitHub Personal Access Token](https://github.com/settings/tokens)

## Step 1: Prepare Your Repository

Make sure your code is pushed to a Git repository (GitHub, GitLab, or Bitbucket).

## Step 2: Import to Vercel

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New Project"**
3. Select your repository
4. Vercel will automatically detect the project settings

## Step 3: Configure Environment Variables

In the Vercel project settings, add the following environment variables:

### Required Variables


SESSION_SECRET=ct8US0idRWKzcOgA2t7qAJSgdn1zscpJsDhO7xK2KLtDQnmuhFR5EyAjnQdHVD8GB/WzBaBGSSfu0pOtemoRBQ==

DATABASE_URL=postgresql://neondb_owner:npg_L5YKPye6zroM@ep-steep-bar-ae5p27ih.c-2.us-east-2.aws.neon.tech/neondb?sslmode=require

PGDATABASE=neondb
PGHOST=ep-steep-bar-ae5p27ih.c-2.us-east-2.aws.neon.tech
PGPORT=5432
PGUSER=neondb_owner
PGPASSWORD=npg_L5YKPye6zroM

OPENAI_API_KEY=


### Optional Variables


GITHUB_PERSONAL_ACCESS_TOKEN=


**Important**: Add these variables to **Production**, **Preview**, and **Development** environments.

## Step 4: Deploy

1. Click **"Deploy"**
2. Vercel will build and deploy your application
3. Once deployed, you'll receive a URL like `https://your-app.vercel.app`

## Step 5: Verify Deployment

1. Visit your deployed URL
2. Test the following features:
   - GitHub Search (search for AutoHotkey macros)
   - AI Generator (generate custom AHK scripts)
   - My Macros (save and manage personal macros)

## Troubleshooting

### Build Fails

- Check the build logs in Vercel dashboard
- Ensure all environment variables are set correctly
- Verify Node.js version compatibility

### Database Connection Issues

- Verify DATABASE_URL is correct
- Check that your Neon database allows connections from Vercel IPs
- Ensure SSL mode is set to `require`

### OpenAI API Errors

- Verify your OPENAI_API_KEY is valid
- Check your OpenAI account has available credits
- Ensure the API key has proper permissions

## Post-Deployment

### Custom Domain (Optional)

1. Go to Project Settings > Domains
2. Add your custom domain
3. Follow Vercel's DNS configuration instructions

### Monitoring

- Use Vercel Analytics to monitor traffic
- Check Vercel Logs for any runtime errors
- Set up error monitoring (e.g., Sentry) for production

## Environment Variable Reference

| Variable | Required | Description |
|----------|----------|-------------|
| `SESSION_SECRET` | Yes | Encryption key for user sessions |
| `DATABASE_URL` | Yes | PostgreSQL connection string (Neon) |
| `PGDATABASE` | Yes | Database name |
| `PGHOST` | Yes | Database host |
| `PGPORT` | Yes | Database port (usually 5432) |
| `PGUSER` | Yes | Database username |
| `PGPASSWORD` | Yes | Database password |
| `OPENAI_API_KEY` | Yes | OpenAI API key for AI features |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | No | GitHub token for higher rate limits |

## Support

For issues specific to:
- **Vercel deployment**: [Vercel Support](https://vercel.com/support)
- **Neon Database**: [Neon Documentation](https://neon.tech/docs)
- **OpenAI API**: [OpenAI Help Center](https://help.openai.com)
