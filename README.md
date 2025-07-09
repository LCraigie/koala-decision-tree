# Koala Decision Tree - Sales Call Script Generator

An AI-powered decision tree tool for business development representatives to generate personalized sales call scripts in real-time.

## Features

- **Real-time Call Analysis**: Live transcript analysis with AI-powered problem detection
- **Personalized Scripts**: Dynamic script generation based on prospect responses
- **Content Recommendations**: AI-suggested resources based on conversation context
- **Prospect Management**: Track and manage prospect information
- **Call Session Tracking**: Save and review call sessions with notes
- **Responsive Design**: Works seamlessly on desktop and mobile devices

## Tech Stack

- **Frontend**: Next.js 15, React 19, TypeScript
- **Styling**: Tailwind CSS
- **Database**: Supabase (PostgreSQL)
- **Deployment**: Vercel
- **UI Components**: shadcn/ui

## Prerequisites

- Node.js 18+ 
- npm or yarn
- Supabase account
- Vercel account (for deployment)

## Setup Instructions

### 1. Clone and Install Dependencies

```bash
git clone <your-repo-url>
cd koala-decision-tree
npm install
```

### 2. Set Up Supabase

1. **Create a Supabase Project**:
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Note your project URL and anon key

2. **Set Up Database Schema**:
   - Go to your Supabase dashboard
   - Navigate to SQL Editor
   - Copy and paste the contents of `supabase/schema.sql`
   - Run the SQL to create tables and sample data

### 3. Configure Environment Variables

1. **Copy the example environment file**:
   ```bash
   cp .env.local.example .env.local
   ```

2. **Update `.env.local` with your Supabase credentials**:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
   ```

### 4. Run the Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

## Database Schema

### Tables

1. **prospects**: Store prospect information
   - Basic info (name, title, company, industry)
   - Pain points and priorities arrays
   - Timestamps for tracking

2. **content_items**: Marketing content library
   - Content metadata (title, type, description, URL)
   - Tags for categorization
   - Relevance scoring

3. **call_sessions**: Track call interactions
   - Live transcript and notes
   - Detected problems and personalized scripts
   - Session status and completion tracking

## Deployment to Vercel

### 1. Connect to Vercel

1. **Install Vercel CLI** (optional):
   ```bash
   npm i -g vercel
   ```

2. **Deploy via Vercel Dashboard**:
   - Connect your GitHub repository to Vercel
   - Vercel will automatically detect Next.js configuration

### 2. Configure Environment Variables in Vercel

In your Vercel project dashboard:

1. Go to **Settings** → **Environment Variables**
2. Add the following variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`

### 3. Deploy

```bash
vercel --prod
```

Or simply push to your main branch if connected to Vercel.

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase project URL | Yes |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anon/public key | Yes |
| `SUPABASE_SERVICE_ROLE_KEY` | Your Supabase service role key | Yes (for server-side operations) |

## Project Structure

```
koala-decision-tree/
├── src/
│   ├── app/                 # Next.js app router pages
│   ├── components/          # React components
│   ├── lib/                 # Utility functions and configurations
│   │   ├── supabase.ts      # Supabase client configuration
│   │   ├── database.ts      # Database operations
│   │   └── database.types.ts # TypeScript types
│   └── styles/              # Global styles
├── supabase/
│   └── schema.sql           # Database schema
├── public/                  # Static assets
├── .env.local.example       # Environment variables template
├── vercel.json             # Vercel deployment configuration
└── README.md               # This file
```

## Usage

### For Sales Representatives

1. **Add Prospect Information**: Fill in prospect details in the left panel
2. **Start Call Simulation**: Click "Start Call" to begin live analysis
3. **Follow AI Scripts**: Use the personalized scripts generated in real-time
4. **Track Progress**: Mark sections as completed as you progress through the call
5. **Save Notes**: Add call notes and review session data

### For Administrators

1. **Manage Content**: Add/update content items in the database
2. **Review Analytics**: Monitor call sessions and prospect data
3. **Customize Scripts**: Modify script generation logic in the codebase

## Development

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

### Adding New Features

1. **Database Changes**: Update `supabase/schema.sql` and run in Supabase
2. **Type Updates**: Modify `src/lib/database.types.ts`
3. **New Components**: Add to `src/components/`
4. **API Routes**: Create in `src/app/api/`

## Security Considerations

- **Row Level Security (RLS)**: Enabled on all tables
- **Environment Variables**: Sensitive data stored in `.env.local`
- **CORS**: Configured for production domains
- **Input Validation**: Implement proper validation for all user inputs

## Troubleshooting

### Common Issues

1. **Environment Variables Not Loading**:
   - Ensure `.env.local` exists and has correct values
   - Restart development server after changes

2. **Supabase Connection Issues**:
   - Verify URL and keys are correct
   - Check Supabase project status

3. **Build Errors**:
   - Run `npm run lint` to check for issues
   - Ensure all dependencies are installed

### Getting Help

- Check the [Next.js documentation](https://nextjs.org/docs)
- Review [Supabase documentation](https://supabase.com/docs)
- Open an issue in the repository

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.
