# 🚀 Deploy PulseCheck AI to Render

## 📋 Prerequisites
- GitHub repository with the code
- Render account (free tier available)
- Firebase project configured
- Google AI API key

## 🛠️ Step-by-Step Deployment

### 1. **Connect GitHub to Render**
1. Go to [render.com](https://render.com)
2. Sign up/login with GitHub
3. Click "New +" → "Web Service"
4. Select your `Diagnoverseai` repository

### 2. **Configure Web Service**
- **Name**: `pulsecheck-ai-web`
- **Environment**: `Node`
- **Region**: Choose nearest region
- **Branch**: `main`
- **Root Directory**: `pulsecheck-ai-main/pulsecheck-ai-main`
- **Build Command**: `npm run build`
- **Start Command**: `npm start`
- **Instance Type**: `Free` (or upgrade as needed)

### 3. **Set Environment Variables**
Add these in the Environment tab:

#### Firebase Configuration
```
NEXT_PUBLIC_FIREBASE_API_KEY=AIzaSyBYHVp9GxWB3tOZeX86OVmo7cV6zyRbrcA
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=diagnoverseai.firebaseapp.com
NEXT_PUBLIC_FIREBASE_PROJECT_ID=diagnoverseai
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=diagnoverseai.firebasestorage.app
NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=587946724360
NEXT_PUBLIC_FIREBASE_APP_ID=1:587946724360:web:59e58a62cca72681f6d5bd
```

#### Google AI Configuration
```
GOOGLE_GENAI_API_KEY=AIzaSyArrn-pIVYDypJW0GQ96oHJTHq2yN-4rQ8
```

#### Additional Configuration
```
NEXT_TELEMETRY_DISABLED=1
NODE_VERSION=18
```

### 4. **Advanced Settings**
- **Health Check Path**: `/api/health` (if available) or `/`
- **Auto-Deploy**: ✅ Enabled
- **Plan**: Free (starts at $0/month)

### 5. **Deploy**
Click "Create Web Service" and wait for deployment (~3-5 minutes)

## 🔧 Troubleshooting

### Build Fails
- Check Node.js version (should be 18+)
- Verify all dependencies are in package.json
- Check build logs for specific errors

### API Routes Not Working
- Ensure all environment variables are set
- Check Firebase configuration
- Verify Google AI API key is valid

### Firebase Auth Issues
- Add your Render domain to Firebase authorized domains
- Enable required authentication methods in Firebase Console

## 🌍 After Deployment

1. **Update Firebase Auth Domains**:
   - Go to Firebase Console → Authentication → Settings
   - Add your Render URL: `your-app.onrender.com`

2. **Test All Features**:
   - User authentication
   - AI scan features
   - API endpoints

3. **Monitor Performance**:
   - Check Render logs
   - Monitor API usage
   - Scale up if needed

## 📱 Mobile App Deployment

For the React Native app in `pulsecheck-ai-mobile/`:
- Use Expo EAS Build
- Deploy to app stores
- Update API endpoints to Render URL

## 💡 Pro Tips

- **Free Tier Limitations**: 750 hours/month, sleeps after 15min inactivity
- **Custom Domain**: Add custom domain for professional appearance
- **SSL**: Automatic SSL certificate provided
- **Backups**: Regular backups included
- **Monitoring**: Built-in metrics and logging

## 🆘 Support

- Render docs: https://render.com/docs
- Firebase docs: https://firebase.google.com/docs
- Issues: Check Render dashboard logs
