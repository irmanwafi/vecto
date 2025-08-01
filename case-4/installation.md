npm install -g @vue/cli
vue create asset-app
cd asset-app
rm -rf node_modules package-lock.json
pnpm install
pnpm approve-builds
pnpm run serve