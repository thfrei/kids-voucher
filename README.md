# kids voucher

web app to host an interactive app for kids so they get weekly vouchers that they can use.

## Getting Started

```bash
git clone https://github.com/thfrei/kids-voucher
mv .env.template .env.local
touch prisma/dev.db
npx prisma db push
yarn
yarn db:seed
yarn dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.js`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) to automatically optimize and load Inter, a custom Google Font.

## Database

```
npx prisma db push
npx prisma studio
```