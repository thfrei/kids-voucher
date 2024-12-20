# kids voucher

web app to host an interactive app for kids so they get weekly vouchers that they can use.

## Getting Started

```bash
git clone https://github.com/thfrei/kids-voucher
mv .env.template .env
npx prisma migrate dev
yarn install
yarn dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.js`. The page auto-updates as you edit the file.

## Database

```cmd
# 
npx prisma db push
npx prisma studio
```

### Change Schema

```cmd
npx prisma migrate dev --name [migrationname]
```
